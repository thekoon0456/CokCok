//
//  Shelf.swift
//  cokcok
//
//  Created by 원태영 on 2023/01/05.
//

import Foundation
import FirebaseFirestore

struct Shelf: Identifiable, Codable, Hashable {
    var id : String
    var cocktailName: CocktailName
    var uploadDate : Date
}
