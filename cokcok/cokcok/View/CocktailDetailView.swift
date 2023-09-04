//
//  CocktailDetailView.swift
//  cokcok
//
//  Created by Da Hae Lee on 2023/01/05.
//

import Foundation
import SwiftUI

struct CocktailDetailView: View {
    @EnvironmentObject var cocktailStore: CocktailStore
    let cocktail: Cocktail

    var tagList: [String] {
        [cocktail.scent[0],
                 cocktail.taste[0],
                 cocktail.baseSpirit,
                 cocktail.color[0],
                 "도수 \(cocktail.degree)",
         String(cocktail.isSparkling ? "탄산있음" : "탄산없음")]
    }

    var body: some View {
        VStack {
            Text("콕콕의 바텐더가 추천드립니다.")
                .font(.title2)
                .padding(20)
                .padding(.top, 20)
            
            Text("\(cocktail.cocktailName)") // 칵테일 이름
                .font(.title)
                .bold()
 
            AsyncImage(url: URL(string: cocktail.cocktailImageUrl)) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: UIScreen.screenWidth - horizontalSpace*2, height: 300) // 양쪽 여백 27
                    .clipped()
                    .cornerRadius(25)
            } placeholder: {
                ProgressView()
            }.frame(width: UIScreen.screenWidth - horizontalSpace*2, height: 300) // 양쪽 여백 27
            
            
            ScrollView(.horizontal, showsIndicators : false) {
                // 태그 뷰
                HStack {
                    ForEach(tagList, id:\.self) { tag in
                        Text("#\(tag)")
                            .padding(.horizontal, 10)
                            .padding(.vertical, 5)
                            .background(Color(.systemGray4))
                            .cornerRadius(10)
                    }
                }
                .padding(27)
            }
            .scrollIndicators(.hidden)
            
            Text("\(cocktail.description)")
                .padding(.horizontal, horizontalSpace)
        }
    }
}

struct CocktailDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            CocktailDetailView(cocktail: Cocktail(id: 1, cocktailName: "더티마더", cocktailImageUrl: "https://w.namu.la/s/11cc356e3c1dc51471ec972952394ce95c1d5e48e88595fb77df2cdc7f1465e0864b65a0e13a88ec51c489b6968bdf1e6d20f484b2e9c301cef9aafcd3245074cc1bb9e5231fe13220fda7d33a34050dfb9b00299fffc5f0fce5e87c38a8f88aa6f725e3c42ab560cecbbe1ef485dfd5", description: "향긋한 커피 향의 칵테일", degree: 33, taste: ["달달한 맛"], scent: ["커피향"], baseSpirit: "브랜디", isSparkling: false, color: ["커피향"], cocktailIcon: "dirtyMother"))
        }
    }
}
