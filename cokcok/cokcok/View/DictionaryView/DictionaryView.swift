//
//  DictionaryView.swift
//  cokcok
//
//  Created by 정예슬 on 2023/01/05.
//

//TODO:
//1. TextField 내부 마진 좀 주고, placeholder 색 수정
//2. 키워드 버튼이 기본 버튼인데 토글처럼 작동하도록 해야 함.
//3. 내부 로직 짜야함...
//4. 각 cell 클릭했을 때 디테일뷰로 넘어갈 수 있도록.
//5. 스크롤바 가리기

import SwiftUI

struct DictionaryView: View {
    @EnvironmentObject var cocktailStore: CocktailStore
	@EnvironmentObject var vm1: ProfileViewModel
	@EnvironmentObject var vm2: MissionViewModel
	
    @State var text: String = ""
    var body: some View {
        VStack{
            Text("어떤 칵테일이 있을까? 키워드를 선택해보세요!")
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.top, 20)
//            TextField("칵테일 이름 검색", text: $text)
//                .frame(height: 35)
//                .textFieldStyle(PlainTextFieldStyle())
//                .foregroundColor(.black)
//                .background(.white)
//                .cornerRadius(5)
            SearchFilterTagView()
                .padding(.vertical, 15)
            ScrollView {
                ForEach(cocktailStore.filteredCocktails) { cocktail in
                    NavigationLink {
                        DictionaryDetailView(cocktail: cocktail)
                    } label: {
                        CocktailListCellView(cocktail: cocktail)
                    }
                }
            }
            .padding(.bottom, 1)
            .navigationTitle("콕콕의 칵테일 사전")
			.onDisappear{
				Task {
					await vm2.updateMissionTable(with: vm1.userInfo!, byMission: MissionEnum.allCases, byMissionCondition: MissionCondition.allCases)
					
					await vm2.requestMissionTable(with: vm1.userInfo!.id)
				}
			}
        }
        .padding(.top, -20)
        .padding(.horizontal, 27)
        
    }
}

struct DictionaryView_Previews: PreviewProvider {
    static var previews: some View {
        DictionaryView(text: "")
    }
}
