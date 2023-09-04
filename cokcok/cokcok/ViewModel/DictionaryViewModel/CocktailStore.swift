//
//  CocktailStore.swift
//  cokcok
//
//  Created by 정예슬 on 2023/01/06.
//

import Foundation
import Combine

class CocktailStore: ObservableObject {
    @Published var cocktails: [Cocktail]
    @Published var filteredCocktails: [Cocktail]
    @Published var todayBartenerResult: Cocktail?
    
    init(cocktails: [Cocktail] = []) {
        self.cocktails = cocktails
        self.filteredCocktails = cocktails
    }
    
    func getTodayBartenerResult(surveyAnswer: SurveyAnswer){
        var resultCocktails = cocktailData
        resultCocktails = resultCocktails.filter { $0.taste.contains(surveyAnswer.favoriteTaste[0]) }
        resultCocktails = resultCocktails.filter { $0.scent.contains(surveyAnswer.favoriteScent[0]) }
        resultCocktails = resultCocktails.filter { $0.baseSpirit.contains(surveyAnswer.favoriteBaseSpirit[0]) }
        resultCocktails = resultCocktails.filter { $0.color.contains(surveyAnswer.favoriteColor[0]) }
//        resultCocktails = resultCocktails.filter { $0.degree.contains(surveyAnswer.favoriteDegree[0]) }
        print(resultCocktails)
        
        if resultCocktails.isEmpty {
            todayBartenerResult = cocktailData.filter { $0.taste.contains(surveyAnswer.favoriteTaste[0]) }.randomElement()
        } else {
            
            todayBartenerResult = resultCocktails.randomElement()
        }
//        return todayBartenerResult
    }
    
    func returnImagesByName(cocktailNames: [String]) -> [String] {
        var images: [String] = []
        if !cocktailNames.isEmpty{
            // UserShelf에 칵테일이 없는 경우, 반환해줄 아이콘 이미지 없음
            for name in cocktailNames {
                images.append(cocktails.first(where: { $0.cocktailName == name })?.cocktailIcon ?? "")
            }
        }
        return images
    }
    
    func returnDegreeTagCocktails(degreeTag: degreeTag) -> [Cocktail] {
        switch degreeTag {
        case .allSelected:
            return cocktails
        case .low:
            return filteredCocktails.filter { $0.degree <= 10 }
        case .mid:
            return filteredCocktails.filter { $0.degree > 10 && $0.degree < 30}
        case .high:
            return filteredCocktails.filter { $0.degree >= 30 }
        }
    }
    
    func returnColorTagCocktails(colorTag: colorTag) -> [Cocktail] {
        switch colorTag {
        case .allSelected:
            return cocktails
        case .red:
            return filteredCocktails.filter { $0.color[0] == "빨강" }
        case .yellow:
            return filteredCocktails.filter { $0.color[0] == "노랑" }
        case .orange:
            return filteredCocktails.filter { $0.color[0] == "주황" }
        case .brown:
            return filteredCocktails.filter { $0.color[0] == "갈색" }
        case .black:
            return filteredCocktails.filter { $0.color[0] == "검정" }
        case .green:
            return filteredCocktails.filter { $0.color[0] == "초록" }
        case .clear:
            return filteredCocktails.filter { $0.color[0] == "투명" }
        case .blue:
            return filteredCocktails.filter { $0.color[0] == "파랑" }
        }
    }
    
    func returnTasteTagCocktails(tasteTag: tasteTag) -> [Cocktail] {
        switch tasteTag {
        case .allSelected:
            return cocktails
        case .sweety:
            return filteredCocktails.filter { $0.taste[0] == "달달한 맛"}
        case .fresh:
            return filteredCocktails.filter { $0.taste[0] == "상큼한 맛"}
        case .bitter:
            return filteredCocktails.filter { $0.taste[0] == "쓴맛"}
        case .fragrant:
            return filteredCocktails.filter { $0.taste[0] == "향긋한 맛"}
        }
    }
    
    func returnBaseTagCocktails(baseTag: baseTag) -> [Cocktail] {
        switch baseTag {
        case .allSelected:
            return cocktails
        case .brandy:
            return filteredCocktails.filter { $0.baseSpirit == "브랜디" }
        case .whiskey:
            return filteredCocktails.filter { $0.baseSpirit == "위스키" }
        case .gin:
            return filteredCocktails.filter { $0.baseSpirit == "진" }
        case .rum:
            return filteredCocktails.filter { $0.baseSpirit == "럼" }
        case .vodka:
            return filteredCocktails.filter { $0.baseSpirit == "보드카" }
        case .tequila:
            return filteredCocktails.filter { $0.baseSpirit == "데킬라" }
        case .liquor:
            return filteredCocktails.filter { $0.baseSpirit == "리큐르" }
        }
    }
    
    func returnScentTagCocktails(scentTag: scentTag) -> [Cocktail] {
        switch scentTag {
        case .allSelected:
            return cocktails
        case .fruit:
            return filteredCocktails.filter { $0.scent[0] == "과일향"}
        case .chocolate:
            return filteredCocktails.filter { $0.scent[0] == "초코향"}
        case .coffee:
            return filteredCocktails.filter { $0.scent[0] == "커피향"}
        case .herb:
            return filteredCocktails.filter { $0.scent[0] == "허브향"}
        case .lemon:
            return filteredCocktails.filter { $0.scent[0] == "레몬향"}
        case .lime:
            return filteredCocktails.filter { $0.scent[0] == "라임향"}
        case .sweet:
            return filteredCocktails.filter { $0.scent[0] == "달콤한 향"}
        case .tropical:
            return filteredCocktails.filter { $0.scent[0] == "열대과일향"}
        }
    }
}
