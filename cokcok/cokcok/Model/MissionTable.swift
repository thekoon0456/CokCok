//
//  MissionTable.swift
//  cokcok
//
//  Created by 원태영 on 2023/01/05.
//

import Foundation

struct MissionTable : Identifiable {
    var id : String
    var userId : String
    var round : Int
    var isClear : Bool
    var missions : [Mission]
}
