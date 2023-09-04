//
//  SurveyAnswer.swift
//  cokcok
//
//  Created by 원태영 on 2023/01/05.
//

import Foundation

struct SurveyAnswer : Identifiable, Codable {
    var id : String
    var favoriteTaste: [String] // [“단맛",”쓴맛", “떫은맛" ... etc]
    var favoriteScent: [String] // [”라임향", “커피향" ... etc]
    var favoriteBaseSpirit: [String] // [“럼”, “위스키", “보드카" ... etc]
    var favoriteColor: [String] // [“붉은색”, “초록색" ... etc]
    var favoriteDegree: [String] // [컨텐츠 잡히면 도수 정리해서 그룹화]
}

enum SurveyAnswerUpdateType {
	case id(key: String = "id", value: String)
	case favoriteTaste(key: String = "favoriteTaste", value: [String])
	case favoriteScent(key: String = "favoriteScent", value: [String])
	case favoriteBaseSpirit(key: String = "favoriteBaseSpirit", value: [String])
	case favoriteColor(key: String = "favoriteColor", value: [String])
	case favoriteDegree(key: String = "favoriteDegree", value: [String])
}
