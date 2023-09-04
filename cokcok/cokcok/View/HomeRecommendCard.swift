//
//  HomeRecommendCard.swift
//  cokcok
//
//  Created by Donghoon Bae on 2023/01/05.
//

import SwiftUI
import UIKit
import SwiftUIFlowLayout

struct HomeRecommendCard: View {
    let cocktail: Cocktail
    var cocktailHashTags: [String] {
        get {
            let hashBaseSpirit: String = "#" + cocktail.baseSpirit
            return [hashBaseSpirit] + cocktail.scent.map { "#" + $0 } + cocktail.taste.map { "#" + $0 } + cocktail.color.map { "#" + $0 }
        }
    }
    
    
    var body: some View {
        VStack(alignment: .leading) {
            Group {
                VStack(alignment: .leading) {
                    Text("\(cocktail.cocktailIcon)").modifier(TitleModifier()).padding(.top, 10)
                    FlowLayout(mode: .scrollable, items: cocktailHashTags, itemSpacing: 3) {
                        Text("\($0)")
                            .foregroundColor(.black)
                            .padding(6)
                            .padding(.horizontal, 4)
//                            .frame(height: 22)
                            .border(.clear, width: 1)
                            .background(.white)
                            .cornerRadius(10)
                    }.padding(-3).padding(.bottom, 15)
                    HStack(alignment: .top) {
                        //                        AsyncImage(url: URL(string: cocktail.cocktailImageUrl)) { image in
                        //                            image
                        //                                .resizable()
                        //                                .aspectRatio(1, contentMode: .fit)
                        //                        } placeholder: {
                        //                            ProgressView()
                        //                        }
                        Image(cocktail.cocktailIcon)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 76, height: 76)
                            .cornerRadius(10)
                        Text("\(cocktail.description)")
                            .modifier(BodyTextModifier())
                    }.padding(.bottom, 5)
                }
            }
            .padding()
        }
        .foregroundColor(.white)
        //        .frame(height: 224)
        .border(.clear, width: 1)
        .background(Color(.systemGray4))
        .cornerRadius(7)
    }
}

//struct HomeRecommendCard_Previews: PreviewProvider {
//    static var previews: some View {
//        HomeRecommendCard(cocktail: Cocktail(id: "jkfdlsajfkld", cocktailName: "애플 모히또", cocktailImageUrl: "http://meloncoffee.com/wp-content/uploads/2021/12/cocktail-gf3d8fe9af_1280.jpg", description: "달콤한 사과가 들어간 모히또!", degree: 8, taste: ["상큼한 맛", "달달한 맛"], scent: ["라임향", "허브향", "과일향"], baseSpirit: "럼", isSparkling: true, color: ["투명", "초록", "빨강"]))
//    }
//}
