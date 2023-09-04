//
//  CocktailData.swift
//  cokcok
//
//  Created by 정예슬 on 2023/01/06.
//

import SwiftUI

var cocktailData: [Cocktail] = loadJson("cokcok.json")

func loadJson<T: Decodable>(_ filename: String) -> T {
    let data: Data
    
    guard let file = Bundle.main.url(forResource: filename, withExtension: nil) else {
        fatalError("\(filename) not found")
    }
    
    // 예외처리: 파일이 있는가?
    do {
        data = try Data(contentsOf: file)
    } catch {
        fatalError("Could not load \(filename) : \(error)")
    }
    
    // 예외처리: 디코딩이 잘 완료되었는가?
    do {
        return try JSONDecoder().decode(T.self, from: data)
    } catch {
        fatalError("Unable to prase \(filename) : \(error)")
    }
}

