//
//  Mission.swift
//  cokcok
//
//  Created by 원태영 on 2023/01/05.
//

import Foundation
import FirebaseFirestore

struct Mission : Identifiable, Hashable {
    var id: String
    var tableId : String
	var missionName: String
	var missionCondition: String
	var isClear : Bool
    var completedAt: Date?
}

enum MissionCondition: String, CaseIterable {
	case firstCocktail = "첫번째 술을 등록했다!"
	case fizzCocktail = "탄산 칵테일을 2잔 이상 먹었다!"
	case sweetCocktail = "단 맛의 칵테일을 3개 이상 먹었다!"
	case russianCocktail = "러시안 칵테일 2개 클리어!"
	case tutorialComplete = "추천 설문조사 감사합니다!"
	case vanGogh = "반 고흐의 술! (압생트 3번 등록)"
	case classicCocktails = "클래식 칵테일 2잔 이상 등록"
	case mexicanSpirit = "테킬라 베이스 칵테일을 2잔 이상 먹었다!"
	case moreThanTen = "당신이 진정한 칵테일 러버, 10잔 이상을 술 선반에 저장했다!"
}

enum MissionEnum: String, CaseIterable {
	case firstCocktail = "나의 첫 칵테일" // 1, 첫번째 술을 등록했다!
	case fizzCocktail = "톡톡! 청량 칵테일"// 2, 칵테일에도 탄산이 있다. (탄산 칵테일 2잔 이상)
	case sweetCocktail = "달콤달달한 칵테일"// 3, 단 맛의 칵테일을 3개 이상 먹었다! (단 맛 칵테일 3개 이상 저장)
	case russianCocktail = "러시안 마스터" // 4, 러시안 칵테일 2개 클리어!(whiteRussian, blackRussian)
	case tutorialComplete = "추천 설문 클리어!" // 5, 설문조사 감사합니다! (if tutorialClear -> true)
	case vanGogh = "반 고흐의 술" // 6, 반고흐의 술! (압생트 3번 등록)
	case classicCocktails = "클래식 그 자체"// 7, 클래식 칵테일 2잔 이상 등록 (마티니, 러스티네일, 모스코뮬, )
	case mexicanSpirit = "스모키 멕시칸 스피릿" // 8, 스모키한 멕시칸 스피릿, (테킬라 베이스 칵테일을 2잔 이상 클리어!)
	case moreThanTen = "칵테일 러버" // 9, 칵테일 러버, (10잔 이상을 술 선반에 저장)
	
	// 9개의 로직을 짜서.. 도전과제.. 체크하기..
	// 클리어 하면 true 리턴, 그 리턴 값을 update해야 함
	public func checkUsersChallenge(with userInfo: UserInfo, byMission missionEnum: Self...) -> Bool {
		for eachMission in missionEnum {
			switch eachMission {
			case .firstCocktail:
				if userInfo.userShelf.isEmpty {
					return false
				} else {
					return true
				}
			case .fizzCocktail: // 탄산 2잔 이상
				var cnt = 0
				
				for spirit in userInfo.userShelf {
                    let cocktailName = spirit.cocktailName.rawValue
					if cocktailName == "잭콕" || cocktailName == "위스키 하이볼" || cocktailName == "진토닉" ||
						cocktailName == "핸드릭스 진토닉" || cocktailName == "진 피즈" || cocktailName == "라모스 진 피즈" || cocktailName == "쿠바 리브레" || cocktailName == "모히또" || cocktailName == "애플 모히또" || cocktailName == "모스코 뮬" || cocktailName == "보드카 토닉" || cocktailName == "마가리타" || cocktailName == "엘디아블로" {
						cnt += 1
					}
				}
				
				if cnt > 1 {
					return true
				}
			case .sweetCocktail:
				var cnt = 0
				
				for spirit in userInfo.userShelf {
                    let cocktailName = spirit.cocktailName.rawValue
					if cocktailName == "더티마더" || cocktailName == "잭 로즈" || cocktailName == "브랜디 알렉산더" ||
						cocktailName == "1920" || cocktailName == "올드패션드" || cocktailName == "러스티 네일" || cocktailName == "갓파더" || cocktailName == "위스키 핫 토디" || cocktailName == "잭콕" || cocktailName == "마이타이" || cocktailName == "프로즌 다이키리" || cocktailName == "쿠바 리브레" || cocktailName == "모히또" || cocktailName == "애플 모히또" || cocktailName == "모스코 뮬" || cocktailName == "코스모폴리탄" || cocktailName == "블랙 러시안" || cocktailName == "화이트 러시안" || cocktailName == "카미카제" || cocktailName == "애플 마티니" || cocktailName == "보드카 토닉" || cocktailName == "엘디아블로" || cocktailName == "데킬라 선라이즈" || cocktailName == "그래스호퍼" || cocktailName == "압생트" || cocktailName == "미도리 사워" || cocktailName == "생제르맹 사워" || cocktailName == "아마레또 사워" || cocktailName == "차이나 블루" {
						cnt += 1
					}
				}
				
				if cnt > 2 {
					return true
				}
			case .russianCocktail:
				var cnt = 0
				
				for spirit in userInfo.userShelf {
                    let cocktailName = spirit.cocktailName.rawValue
					if cocktailName == "블랙 러시안" || cocktailName == "화이트 러시안" {
						cnt += 1
					}
				}
				
				if cnt == 2 {
					return true
				}
			case .tutorialComplete:
				// 만약 설문 답변이 있다면
				if userInfo.surveyAnswer != nil {
					return true
				}
			case .vanGogh:
				var cnt = 0
				
				// 압생트를 마셨다면
				for spirit in userInfo.userShelf {
                    if spirit.cocktailName.rawValue == "압생트" {
						cnt += 1
					}
				}
				
				if cnt > 2 {
					return true
				}
			case .classicCocktails:
				// 클래식 칵테일 3개 이상이라면
				var cnt = 0
				
				for spirit in userInfo.userShelf {
                    let cocktailName = spirit.cocktailName.rawValue
					if cocktailName == "코스모폴리탄" || cocktailName == "올드패션드" || cocktailName == "갓파더" ||
						cocktailName == "마티니" || cocktailName == "모스코 뮬" || cocktailName == "김렛" {
						cnt += 1
					}
				}
				
				if cnt > 2 {
					return true
				}
			case .mexicanSpirit:
				var cnt = 0
				
				for spirit in userInfo.userShelf {
                    let cocktailName = spirit.cocktailName.rawValue
                    if cocktailName == "데킬라 선라이즈" || cocktailName == "마가리타" || cocktailName == "엘디아블로" {
						cnt += 1
					}
				}
				
				if cnt >= 2 {
					return true
				}
			case .moreThanTen:
				if userInfo.userShelf.count > 10 {
					return true
				}
			}
		}
		return false
	}
	
	public func getRawValue() -> String {
		self.rawValue
	}
}
