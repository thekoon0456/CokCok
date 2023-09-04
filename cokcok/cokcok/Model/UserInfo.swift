//
//  UserInfo.swift
//  cokcok
//
//  Created by 원태영 on 2023/01/05.
//

import Foundation
import FirebaseFirestore

struct UserInfo : Identifiable, Codable {
    var id: String
    var userName: String
    var userEmail: String
    var userBirthday: Date
    var surveyAnswer: SurveyAnswer?
    var userShelf: [Shelf]
}

enum UserInfoUpdateEnum {
	case userName(key: String = "userName", value: String)
	case userEmail(key: String = "userEmail", value: String)
	case userBirthday(key: String = "userBirthday", value: Date)
	case userSurveyAnswer(key: String = "userSurveyAnswer", value: SurveyAnswerUpdateType)
	case userShelf(key: String = "userShelf", value: [Shelf])
}
