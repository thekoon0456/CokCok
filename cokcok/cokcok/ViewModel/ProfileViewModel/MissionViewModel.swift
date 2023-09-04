//
//  MissionViewModel.swift
//  cokcok
//
//  Created by 이승준 on 2023/01/05.
//

import SwiftUI
import FirebaseFirestore

final class MissionViewModel: ObservableObject {
	@Published var userMissionTable: MissionTable?
	
	let path = Firestore.firestore().collection("MissionTable")
	
	public let gridSystem: [GridItem] = [
		GridItem(.flexible(), spacing: 0, alignment: .top),
		GridItem(.flexible(), spacing: 0, alignment: .top),
		GridItem(.flexible(), spacing: 0, alignment: .top),
	]
	
	public let missionIconName = [
		"firstCocktail",
		"fizzCocktail",
		"sweetCocktail",
		"russianCocktail",
		"tutorialComplete",
		"vanGogh",
		"classicCocktails",
		"mexicanSpirit",
		"moreThanTen",
	]
	
	@MainActor
	public func requestMissionTable(with userUid: String?) async -> Void {
		guard let userUid else { return }
		
		do {
			if let usersMission = try await path.document(userUid).getDocument().data() {
				let id = usersMission["id"] as? String ?? ""
				let userId = usersMission["userId"] as? String ?? ""
				let round = usersMission["round"] as? Int ?? 0
				let isClear = usersMission["isClear"] as? Bool ?? false
				
				let missions = usersMission["missions"] as? [[String: Any]] ?? [[:]]
				
				var eachMissionArray: [Mission] = []
				
				for eachMission in missions {
					let eachMissionId = eachMission["id"] as? String ?? ""
					let tableId = eachMission["tableId"] as? String ?? ""
					let missionName: String = eachMission["missionName"] as? String ?? ""
					let isEachMissionClear = eachMission["isClear"] as? Bool ?? false
					let missionCondition: String =
					eachMission["missionCondition"] as? String ?? "아직 조건이 없으니 db에 올리셈"
					let completedAt = eachMission["completedAt"] as? Timestamp ?? nil
					
					let usersEachMission = Mission(id: eachMissionId, tableId: tableId, missionName: missionName, missionCondition: missionCondition, isClear: isEachMissionClear, completedAt: completedAt?.dateValue())
					
					eachMissionArray.append(usersEachMission)
				}
				
				let newMissionTable = MissionTable(id: id, userId: userUid, round: round, isClear: isClear, missions: eachMissionArray)
				
				self.userMissionTable = newMissionTable
			}
		} catch {
			dump("\(#function) - DEBUG \(error.localizedDescription)")
		}
	}
	
	public func updateMissionTable(with userInfo: UserInfo, byMission mission: [MissionEnum], byMissionCondition eachMissionCondition: [MissionCondition]) async -> Void {
		let path = path.document(userInfo.id)
		
		do {
            if (try await path.getDocument().exists) {
                try await path.updateData([
                    "missions" : FieldValue.delete()
                ])
            }
			
			for missionIndex in 0 ..< mission.count {
				print("/////", mission[missionIndex].rawValue, mission[missionIndex].checkUsersChallenge(with: userInfo, byMission: mission[missionIndex]))
				
				try await path.setData([
					"missions": FieldValue.arrayUnion([[
						"id": UUID().uuidString,
						"missionName": mission[missionIndex].rawValue,
						"missionCondition": eachMissionCondition[missionIndex].rawValue,
						"tableId" : "tableId",
						"isClear" : mission[missionIndex].checkUsersChallenge(with: userInfo, byMission: mission[missionIndex]),
						"completedAt": Timestamp(date: .now)
					]])
				], merge: true)
			}
			await self.requestMissionTable(with: userInfo.id)
		} catch {
			dump("\(#function) - DEBUG \(error.localizedDescription)")
		}
	}
}
 
