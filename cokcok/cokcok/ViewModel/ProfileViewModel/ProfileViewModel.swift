//
//  MainProfileView.swift
//  cokcok
//
//  Created by 이승준 on 2023/01/05.
//

import SwiftUI
import FirebaseFirestore

final class ProfileViewModel: ObservableObject {
	@Published var userInfo: UserInfo?
    @Published var surveyAnswer: SurveyAnswer = SurveyAnswer(id: "", favoriteTaste: [], favoriteScent: [], favoriteBaseSpirit: [], favoriteColor: [], favoriteDegree: [])
	
	private let path = Firestore.firestore().collection("UserInfo")
	
	// MARK: - read User Info
	/// - Parameter in: Auth.auth().currentUser.uid
	@MainActor
	public func requestUserInfo(in userId: String?) async {
		guard let userId else { return }
		do {
			let requestedDocData = try await path.document(userId).getDocument().data()
			if let requestedDocData {
				let id = requestedDocData["id"] as? String ?? ""
				let userName = requestedDocData["userName"] as? String ?? ""
				let userEmail = requestedDocData["userEmail"] as? String ?? ""
				let userBirthday = requestedDocData["userBirthday"] as? Timestamp ?? Timestamp(date: .now)
				
				// SurveyAnswer
				let surveyAnswer = requestedDocData["surveyAnswer"] as? [String: Any] ?? [:]
				
				let answerId : String = surveyAnswer["answerId"] as? String ?? ""
				let favoriteTaste: [String] = surveyAnswer["favoriteTaste"] as? [String] ?? [""]
				let favoriteScent: [String] = surveyAnswer["favoriteScent"] as? [String] ?? [""]
				let favoriteBaseSpirit: [String] = surveyAnswer["favoriteBaseSpirit"] as? [String] ?? [""]
				let favoriteColor: [String] = surveyAnswer["favoriteColor"] as? [String] ?? [""]
				let favoriteDegree: [String] = surveyAnswer["favoriteDegree"] as? [String] ?? [""]
				
				let requestedSurveyAnswer = SurveyAnswer(id: answerId, favoriteTaste: favoriteTaste, favoriteScent: favoriteScent, favoriteBaseSpirit: favoriteBaseSpirit, favoriteColor: favoriteColor, favoriteDegree: favoriteDegree)
				
				// UserShelf
				let userShelf = requestedDocData["userShelf"] as? [[String: Any]] ?? [[:]]
				
				var userShelfArray: [Shelf] = []
				
				for shelfItems in userShelf {
					let shelfId  = shelfItems["id"] as? String ?? ""
					let cocktailName = shelfItems["cocktailName"] as? String ?? ""
					let uploadDate  = shelfItems["uploadDate"] as? Timestamp ?? Timestamp(date: .now)
                    let cocktailNameEnumRawValue = CocktailName(rawValue: cocktailName)
                    print("++++++++++", cocktailNameEnumRawValue?.rawValue)
                    let userShelf = Shelf(id: shelfId, cocktailName: cocktailNameEnumRawValue ?? .absinthe, uploadDate: uploadDate.dateValue())
					userShelfArray.append(userShelf)
				}
				
				let userInfoResult = UserInfo(id: id, userName: userName, userEmail: userEmail, userBirthday: userBirthday.dateValue(), surveyAnswer: requestedSurveyAnswer, userShelf: userShelfArray)
				self.userInfo = userInfoResult
			}
		}
		catch {
			dump("\(#function) - DEBUG \(error.localizedDescription)")
		}
		
	}
	
	// MARK: - Update User Info
	public func updateUserInfo(in userId: String?,
							   with newValue: UserInfoUpdateEnum...) async -> Void {
		guard let userId else { return }
		
		do {
			for updateValue in newValue {
				switch updateValue {
				case .userName(key: let key, value: let value),
						.userEmail(key: let key, value: let value):
					try await path.document(userId).updateData([
						key: value
					])
				case .userBirthday(key: let key, value: let value):
					try await path.document(userId).updateData([
						key: value
					])
				case .userSurveyAnswer(key: let key, value: let value):
					switch value {
					case .id(key: let key, value: let value):
						try await path.document(userId).setData([
							"surveyAnswer": [
								key: value
							]
						], merge: true)
					case .favoriteTaste(key: let key, value: let value),
						.favoriteScent(key: let key, value: let value),
						.favoriteBaseSpirit(key: let key, value: let value),
						.favoriteColor(key: let key, value: let value),
						.favoriteDegree(key: let key, value: let value):
						try await path.document(userId).setData([
							"surveyAnswer": [
								key: value
							]
						], merge: true)
					}
				case .userShelf(key: let shelfKey, value: let shelves):
					// 배열을 초기화 하고 새로 업데이트
//					try await path.document(userId).updateData([
//						shelfKey : FieldValue.delete()
//					])
					
					for shelf in shelves {
						try await path.document(userId).updateData([
							shelfKey : FieldValue.arrayUnion([
								[
									"id": shelf.id,
									"cocktailName": shelf.cocktailName.rawValue,
									"uploadDate": Timestamp(date: shelf.uploadDate)
								]
							])
						])
					}
				}
			}
			await requestUserInfo(in: userId)
		} catch {
			dump("\(#function) - DEBUG \(error.localizedDescription)")
		}
		
		
	}
}
