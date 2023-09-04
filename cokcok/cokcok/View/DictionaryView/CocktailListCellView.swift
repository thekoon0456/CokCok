//
//  CocktailListCellView.swift
//  cokcok
//
//  Created by 정예슬 on 2023/01/05.
//

import SwiftUI

struct CocktailListCellView: View {
    var cocktail: Cocktail
    let columnLayout = Array(repeating: GridItem(), count: 2)
    
    
    var body: some View {
        VStack(alignment: .leading){
            Group{
                Text(cocktail.cocktailName)
                    .foregroundColor(.white)
                    .font(.title2)
                    .fontWeight(.heavy)
                    .padding(.bottom, -30)
                HStack{
                    Image(cocktail.cocktailIcon)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 100)
                    LazyVGrid(columns: columnLayout, alignment: .leading) {
                        Text("#\(cocktail.scent[0])")
                            .modifier(FrameToText())
                        Text("#\(cocktail.baseSpirit)")
                            .modifier(FrameToText())
                        Text("#\(cocktail.taste[0])")
                            .modifier(FrameToText())
                        Text("#\(cocktail.color[0])")
                            .modifier(FrameToText())
                        Text("#도수\(cocktail.degree)")
                            .modifier(FrameToText())
                        cocktail.isSparkling ? Text("#탄산있음")
                            .modifier(FrameToText())
                        : Text("#탄산없음")
                            .modifier(FrameToText())
                        
                    }
                    .font(.callout)
                    .fontWeight(.heavy)
                }
                
            }
            .padding(15)
            .padding(.horizontal, -40)
        }
        .frame(width: UIScreen.screenWidth - horizontalSpace * 2)
        .background(Color(hex: "323232"))
        .cornerRadius(5)
        
    }
    
}

struct FrameToText: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding(.vertical, 5)
            .padding(.horizontal, 8)
            //.frame(minWidth: 90)
            .overlay(
                RoundedRectangle(cornerRadius: 5)
                    .stroke(Color.accentColor, lineWidth: 1)
            )
        
    }
}


struct CocktailListCellView_Previews: PreviewProvider {
    
    
    static var previews: some View {
        CocktailListCellView(cocktail: Cocktail(id: 1, cocktailName: "더티마더", cocktailImageUrl: "https://w.namu.la/s/11cc356e3c1dc51471ec972952394ce95c1d5e48e88595fb77df2cdc7f1465e0864b65a0e13a88ec51c489b6968bdf1e6d20f484b2e9c301cef9aafcd3245074cc1bb9e5231fe13220fda7d33a34050dfb9b00299fffc5f0fce5e87c38a8f88aa6f725e3c42ab560cecbbe1ef485dfd5", description: "향긋한 커피 향의 칵테일", degree: 33, taste: ["달달한 맛"], scent: ["커피향"], baseSpirit: "브랜디", isSparkling: false, color: ["커피향"], cocktailIcon: "dirtyMother"))
    }
}
