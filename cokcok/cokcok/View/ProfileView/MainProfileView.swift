//
//  MainProfileView.swift
//  cokcok
//
//  Created by 이승준 on 2023/01/05.
//

import SwiftUI
import FirebaseFirestore
import FirebaseAuth

struct MainProfileView: View {
	@EnvironmentObject var vm: ProfileViewModel
	@EnvironmentObject var vm2: MissionViewModel
	
	@State private var isToastDisplayed = false
	@State private var isCleared: Bool = false
	@State private var isColorOpacity: Double = 0.5
	@State private var eachMission: Mission?
	@State private var missionArrayIndex = 0
	@State var refresh: Bool = false
	
    var body: some View {
		ZStack {
			ScrollView(showsIndicators: false) {
				if let userInfo = vm.userInfo,
				   let missionsArray = vm2.userMissionTable?.missions {
					// 헤더 안내인사 뷰
					sectionHeaderHelloView
					
					HStack {
						Text("나의 칵테일 도전과제")
							.font(.title2)
							.bold()
							.padding()
						
						Spacer()
					}
					
					LazyVGrid(columns: vm2.gridSystem) {
						ForEach(0..<missionsArray.count, id: \.self) { idx in
							ChallengeCell(missions: missionsArray[idx], iconNameArray: vm2.missionIconName,
										  isToastDisplayed: $isToastDisplayed,
										  isCleared: $isCleared,
										  missionArrayIndex: $missionArrayIndex,
										  index: idx)
							.frame(width: UIScreen.main.bounds.width / 3 - 27)
						}
						.onChange(of: isToastDisplayed) { _ in
							self.eachMission = missionsArray[missionArrayIndex]
							print("bbbbb", self.eachMission)
						}
						.padding(.horizontal, 27)
					}
					
					VStack {
						Text("Copyright @cokcok")
							.font(.caption)
							.foregroundColor(.gray)
					}
				} else {
					ProgressView()
				}
			}
			
			if isToastDisplayed, isCleared {
				RoundedRectangle(cornerRadius: 10)
					.frame(width: 300, height: 400)
					.overlay {
						VStack(alignment: .center) {
							Group {
								Text("\(eachMission?.missionName ?? "") \n 챌린지 달성을 축하합니다!")
									.multilineTextAlignment(.center)
									.bold()
									.foregroundColor(.black)
								
								Text("\"\(eachMission?.missionCondition ?? "") \" 을 달성하여 스탬프를 획득하셨습니다.")
									.bold()
									.foregroundColor(.black)
								
								Text("다음에는 다른 스탬프를 모아볼까요?")
									.foregroundColor(.black)
								
								Text("\(eachMission?.completedAt?.getKoreanDate() ?? "NOTIME")")
									.foregroundColor(.gray)
							}
							.frame(alignment: .center)
							.padding(.horizontal, 10)
							.padding(.vertical, 5)
							.padding(.bottom, 15)
														
							Button {
								self.isToastDisplayed.toggle()
							} label: {
								Color.gray
									.clipShape(RoundedRectangle(cornerRadius: 10))
									.frame(width: 100, height: 50)
									.overlay {
										Text("확인")
											.foregroundColor(.white)
											.bold()
									}
							}
							.padding(.top, 35)
						}
					}
					.foregroundColor(.white.opacity(isColorOpacity))
					.onAppear {
						withAnimation(.easeInOut(duration: 0.3)) {
							isColorOpacity = 1.0
						}
					}
					.onDisappear {
							isColorOpacity = 0.5
					}
			}
		}
		.navigationBarTitleDisplayMode(.inline)
		.toolbar {
			ToolbarItem(placement: .navigationBarTrailing) {
				NavigationLink {
					ProfileSettngView()
				} label: {
					Image(systemName: "gear")
						.foregroundColor(.accentColor)
				}
			}
		}
		.task {
			await vm.requestUserInfo(in: Auth.auth().currentUser?.uid)
			await vm2.updateMissionTable(with: vm.userInfo!, byMission: MissionEnum.allCases, byMissionCondition: MissionCondition.allCases)
			await vm2.requestMissionTable(with: Auth.auth().currentUser?.uid)
		}
    }
	
	// MARK: - 상단 로고 + 인사말
	private var sectionHeaderHelloView: some View {
		VStack {
			HStack {
				Text("콕콕🍷")
					.font(.largeTitle)
					.bold()
				
				Spacer()
				
				VStack(alignment: .trailing) {
					Text("\(vm.userInfo?.userName ?? "")")
						.bold()
					 + Text(" 님 \n안녕하세요!")
				}
			}
			.bold()
			.padding()
		}
	}
}

struct ChallengeCell: View {
	@State var missions: Mission
	@State var iconNameArray: [String]
	
	@Binding var isToastDisplayed: Bool
	@Binding var isCleared: Bool
	@Binding var missionArrayIndex: Int
	public var index: Int
	
	var body: some View {
		ZStack {
			VStack {
				HStack {
					VStack(alignment: .center) {
						Image(missions.isClear ? iconNameArray[index] : iconNameArray[index] + "_disabled")
							.resizable()
							.cornerRadius(10)
							.frame(minWidth: 100, minHeight: 100)
							.aspectRatio(1, contentMode: .fit)
							.overlay {
								if missions.isClear {
									Image("getStamp")
										.resizable()
										.frame(minWidth: 39, minHeight: 39)
								}
							}
						Text("\(missions.missionName)")
							.font(.subheadline)
							.bold()
					}
					.padding()
				}
				Divider()
			}
		}
		.onAppear {
			print("111", self.missions.missionName, self.missions.isClear)
		}
		.onTapGesture {
			missionArrayIndex = index
			isToastDisplayed.toggle()
			isCleared = missions.isClear
		}
	}
}
