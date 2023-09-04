//
//  DictionaryDetailView.swift
//  cokcok
//
//  Created by Donghoon Bae on 2023/01/06.
//

import SwiftUI
import FirebaseAuth

struct DictionaryDetailView: View {
    @EnvironmentObject var vm: ProfileViewModel
    
    var cocktail: Cocktail
    var cocktailHashTags: [String] {
        get {
            let hashBaseSpirit: String = "#" + cocktail.baseSpirit
            return [hashBaseSpirit] + cocktail.scent.map { "#" + $0 } + cocktail.taste.map { "#" + $0 } + cocktail.color.map { "#" + $0 }
        }
    }
    
    var body: some View {
        ScrollView {
            CocktailDetailView(cocktail: cocktail)
            
            Button {
                Task {
                    await vm.updateUserInfo(in: Auth.auth().currentUser?.uid, with: .userShelf(value: [Shelf(id: UUID().uuidString, cocktailName: CocktailName(rawValue: cocktail.cocktailName) ?? .emptyCocktail1, uploadDate: Date())]))
                }
            } label: {
                Rectangle()
                    .frame(width: 218, height: 43)
                    .foregroundColor(Color.cokcokPink)
                    .cornerRadius(10)
                    .overlay {
                        Text("내 술장에 추가하기")
                            .foregroundColor(.black)
                    }
            }
            .padding(.top, 20)
        }
        .navigationBarTitleDisplayMode(.inline)
       
    }
}

struct DictionaryDetailView_Previews: PreviewProvider {
    static var previews: some View {
        DictionaryDetailView(cocktail: Cocktail(id: 12318, cocktailName: "apple martini", cocktailImageUrl: "", description: "fdjsakfjdklsafjklsa", degree: 13, taste: [], scent: [], baseSpirit: "", isSparkling: true, color: [], cocktailIcon: ""))
            .environmentObject(ProfileViewModel())
    }
}
