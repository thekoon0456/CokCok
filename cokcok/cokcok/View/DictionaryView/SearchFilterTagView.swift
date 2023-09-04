//
//  SearchFilterTagView.swift
//  cokcok
//
//  Created by 정예슬 on 2023/01/05.
//

import SwiftUI

enum firstTag {
    case allSelected, tasteSelected, degreeSelected, colorSelected, baseSelected, scentSeleted
}
enum tasteTag {
    case allSelected, sweety, fresh, bitter, fragrant
}
enum degreeTag {
    case allSelected, low, mid, high
}
enum colorTag {
    case allSelected, red, yellow, orange, brown, black, green, clear, blue
}
enum baseTag {
    case allSelected, brandy, whiskey, gin, rum, vodka, tequila, liquor
}
enum scentTag {
    case allSelected, fruit, tropical, lemon, lime, coffee, chocolate, herb, sweet
}


struct SearchFilterTagView: View {
    @State var firstTag: firstTag = .allSelected
    @State var tasteTag: tasteTag = .allSelected
    @State var degreeTag: degreeTag = .allSelected
    @State var colorTag: colorTag = .allSelected
    @State var baseTag: baseTag = .allSelected
    @State var scentTag: scentTag = .allSelected

    @EnvironmentObject var cocktailStore: CocktailStore
    
    
    var body: some View {
        VStack{
//            Text("키워드를 선택해주세요.")
//                .frame(maxWidth: .infinity, alignment: .leading)
//                .font(.callout)
            ScrollView(.horizontal, showsIndicators : false){
                HStack(spacing : 8){
                    firstTagButtons(firstTag: $firstTag)
                }
            }
            switch self.firstTag {
            case .allSelected:
                Text("모든 특성이 선택되었습니다.")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(.footnote)
            case .tasteSelected:
                tasteTagButtons(tasteTag: $tasteTag)
            case .degreeSelected:
                degreeTagButtons(degreeTag: $degreeTag)
            case .colorSelected:
                colorTagButtons(colorTag: $colorTag)
            case .baseSelected:
                baseTagButtons(baseTag: $baseTag)
            case .scentSeleted:
                scentTagButtons(scentTag: $scentTag)
            }
        }
    }
}
struct firstTagButtons: View {
    @Binding var firstTag: firstTag
    @EnvironmentObject var cocktailStore: CocktailStore
    
    var body: some View{
        Group {
            Button {
                firstTag = .allSelected
                cocktailStore.filteredCocktails = cocktailStore.cocktails
            } label: { Text("전체") }
            Button { firstTag = .tasteSelected } label: { Text("맛") }
            Button { firstTag = .degreeSelected } label: { Text("도수") }
            Button { firstTag = .colorSelected } label: { Text("색상") }
            Button { firstTag = .baseSelected } label: { Text("베이스") }
            Button { firstTag = .scentSeleted } label: { Text("향") }
        }
        .buttonStyle(FirstButton())
    }
}
struct tasteTagButtons: View {
    @Binding var tasteTag: tasteTag
    @EnvironmentObject var cocktailStore: CocktailStore
    
    var body: some View{
        ScrollView(.horizontal, showsIndicators: false){
            HStack{
                Button {
                    tasteTag = .allSelected
                    cocktailStore.filteredCocktails = cocktailStore.returnTasteTagCocktails(tasteTag: tasteTag)
                } label: { Text("맛 전체") }
                Button {
                    tasteTag = .sweety
                    cocktailStore.filteredCocktails = cocktailStore.returnTasteTagCocktails(tasteTag: tasteTag)
                } label: { Text("달달한 맛") }
                Button {
                    tasteTag = .bitter
                    cocktailStore.filteredCocktails = cocktailStore.returnTasteTagCocktails(tasteTag: tasteTag)
                } label: { Text("쓴맛") }
                Button {
                    tasteTag = .fragrant
                    cocktailStore.filteredCocktails = cocktailStore.returnTasteTagCocktails(tasteTag: tasteTag)
                } label: { Text("향긋한 맛") }
                Button {
                    tasteTag = .fresh
                    cocktailStore.filteredCocktails = cocktailStore.returnTasteTagCocktails(tasteTag: tasteTag)
                } label: { Text("상큼한 맛") }
            }
        }
        .buttonStyle(SecondButton())
    }
}
struct degreeTagButtons: View {
    @Binding var degreeTag: degreeTag
    @EnvironmentObject var cocktailStore: CocktailStore
    var body: some View{
        ScrollView(.horizontal, showsIndicators: false){
            HStack{
                Button {
                    degreeTag = .allSelected
                    cocktailStore.filteredCocktails = cocktailStore.returnDegreeTagCocktails(degreeTag: degreeTag)
                } label: { Text("도수 전체") }
                Button {
                    degreeTag = .low
                    cocktailStore.filteredCocktails = cocktailStore.returnDegreeTagCocktails(degreeTag: degreeTag)
                } label: { Text("10도 이하") }
                Button {
                    degreeTag = .mid
                    cocktailStore.filteredCocktails = cocktailStore.returnDegreeTagCocktails(degreeTag: degreeTag)
                } label: { Text("10도 ~ 29도 이하") }
                Button {
                    degreeTag = .high
                    cocktailStore.filteredCocktails = cocktailStore.returnDegreeTagCocktails(degreeTag: degreeTag)
                } label: { Text("30도 이상") }
            }
        }
        .buttonStyle(SecondButton())
    }
}
struct colorTagButtons: View {
    @Binding var colorTag: colorTag
    @EnvironmentObject var cocktailStore: CocktailStore
    var body: some View{
        ScrollView(.horizontal, showsIndicators: false){
            HStack{
                Button {
                    colorTag = .allSelected
                    cocktailStore.filteredCocktails = cocktailStore.returnColorTagCocktails(colorTag: colorTag)
                } label: { Text("색상 전체") }
                Button {
                    colorTag = .black
                    cocktailStore.filteredCocktails = cocktailStore.returnColorTagCocktails(colorTag: colorTag)
                } label: { Text("검정") }
                Button {
                    colorTag = .blue
                    cocktailStore.filteredCocktails = cocktailStore.returnColorTagCocktails(colorTag: colorTag)
                } label: { Text("파랑") }
                Button {
                    colorTag = .brown
                    cocktailStore.filteredCocktails = cocktailStore.returnColorTagCocktails(colorTag: colorTag)
                } label: { Text("갈색") }
                Button {
                    colorTag = .clear
                    cocktailStore.filteredCocktails = cocktailStore.returnColorTagCocktails(colorTag: colorTag)
                } label: { Text("투명") }
                Button {
                    colorTag = .green
                    cocktailStore.filteredCocktails = cocktailStore.returnColorTagCocktails(colorTag: colorTag)
                } label: { Text("초록") }
                Button {
                    colorTag = .orange
                    cocktailStore.filteredCocktails = cocktailStore.returnColorTagCocktails(colorTag: colorTag)
                } label: { Text("주황") }
                Button {
                    colorTag = .red
                    cocktailStore.filteredCocktails = cocktailStore.returnColorTagCocktails(colorTag: colorTag)
                } label: { Text("빨강") }
                Button {
                    colorTag = .yellow
                    cocktailStore.filteredCocktails = cocktailStore.returnColorTagCocktails(colorTag: colorTag)
                } label: { Text("노랑") }
            }
        }
        .buttonStyle(SecondButton())
    }
}
struct baseTagButtons: View {
    @Binding var baseTag: baseTag
    @EnvironmentObject var cocktailStore: CocktailStore
    var body: some View{
        ScrollView(.horizontal, showsIndicators: false){
            HStack{
                Button {
                    baseTag = .allSelected
                    cocktailStore.filteredCocktails = cocktailStore.returnBaseTagCocktails(baseTag: baseTag)
                } label: { Text("베이스 전체") }
                Button {
                    baseTag = .brandy
                    cocktailStore.filteredCocktails = cocktailStore.returnBaseTagCocktails(baseTag: baseTag)
                } label: { Text("브랜디") }
                Button {
                    baseTag = .gin
                    cocktailStore.filteredCocktails = cocktailStore.returnBaseTagCocktails(baseTag: baseTag)
                } label: { Text("진") }
                Button {
                    baseTag = .liquor
                    cocktailStore.filteredCocktails = cocktailStore.returnBaseTagCocktails(baseTag: baseTag)
                } label: { Text("리큐르") }
                Button {
                    baseTag = .rum
                    cocktailStore.filteredCocktails = cocktailStore.returnBaseTagCocktails(baseTag: baseTag)
                } label: { Text("럼") }
                Button {
                    baseTag = .tequila
                    cocktailStore.filteredCocktails = cocktailStore.returnBaseTagCocktails(baseTag: baseTag)
                } label: { Text("데킬라") }
                Button {
                    baseTag = .vodka
                    cocktailStore.filteredCocktails = cocktailStore.returnBaseTagCocktails(baseTag: baseTag)
                } label: { Text("보드카") }
                Button {
                    baseTag = .whiskey
                    cocktailStore.filteredCocktails = cocktailStore.returnBaseTagCocktails(baseTag: baseTag)
                } label: { Text("위스키") }
            }
        }
        .buttonStyle(SecondButton())
    }
}
struct scentTagButtons: View {
    @Binding var scentTag: scentTag
    @EnvironmentObject var cocktailStore: CocktailStore
    var body: some View{
        ScrollView(.horizontal, showsIndicators: false){
            HStack{
                Button {
                    scentTag = .allSelected
                    cocktailStore.filteredCocktails = cocktailStore.returnScentTagCocktails(scentTag: scentTag)
                } label: { Text("향 전체") }
                Button {
                    scentTag = .fruit
                    cocktailStore.filteredCocktails = cocktailStore.returnScentTagCocktails(scentTag: scentTag)
                } label: { Text("과일향") }
                Button {
                    scentTag = .chocolate
                    cocktailStore.filteredCocktails = cocktailStore.returnScentTagCocktails(scentTag: scentTag)
                } label: { Text("초코향") }
                Button {
                    scentTag = .coffee
                    cocktailStore.filteredCocktails = cocktailStore.returnScentTagCocktails(scentTag: scentTag)
                } label: { Text("커피향") }
                Button {
                    scentTag = .herb
                    cocktailStore.filteredCocktails = cocktailStore.returnScentTagCocktails(scentTag: scentTag)
                } label: { Text("허브향") }
                Button {
                    scentTag = .lemon
                    cocktailStore.filteredCocktails = cocktailStore.returnScentTagCocktails(scentTag: scentTag)
                } label: { Text("레몬향") }
                Button {
                    scentTag = .lime
                    cocktailStore.filteredCocktails = cocktailStore.returnScentTagCocktails(scentTag: scentTag)
                } label: { Text("라임향") }
                Button {
                    scentTag = .sweet
                    cocktailStore.filteredCocktails = cocktailStore.returnScentTagCocktails(scentTag: scentTag)
                } label: { Text("달콤한 향") }
                Button {
                    scentTag = .tropical
                    cocktailStore.filteredCocktails = cocktailStore.returnScentTagCocktails(scentTag: scentTag)
                } label: { Text("열대과일향") }
            }
        }
        .buttonStyle(SecondButton())
    }
}

struct FirstButton: ButtonStyle {

    func makeBody(configuration: Configuration) -> some View {
        configuration
            .label
            .font(.callout)
            .foregroundColor(configuration.isPressed ? .gray : .white)
            .padding(.horizontal, 10)
            .frame(minWidth: 50, minHeight: 30)
            .background(Color(hex : "323232"))
            .cornerRadius(5)
    }
}

struct SecondButton: ButtonStyle {

    func makeBody(configuration: Configuration) -> some View {
        configuration
            .label
            .font(.caption)
            .foregroundColor(configuration.isPressed ? .gray : .white)
            .frame(minWidth: 50, minHeight: 25)
            .padding(.horizontal, 10)
            .background(Color(hex : "323232"))
            .cornerRadius(5)
    }
}

struct SearchFilterTagView_Previews: PreviewProvider {
    static var previews: some View {
        SearchFilterTagView()
    }
}
