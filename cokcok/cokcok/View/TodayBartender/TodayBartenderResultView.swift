//
//  TodayBartenderResultView.swift
//  cokcok
//
//  Created by Da Hae Lee on 2023/01/05.
//

import SwiftUI
import FirebaseAuth

/// 컨텐츠의 좌우 여백
let horizontalSpace: CGFloat = 27
let targetCocktailList : [(image : String, name : String)] = [
    ("",""),
    ("sideCar","사이드카"),
    ("dirtyMother","더티마더"),
    ("oldFashioned","올드패션드")
]


struct TodayBartenderResultView: View {
    @EnvironmentObject var profileViewModel: ProfileViewModel
    @EnvironmentObject var cocktailStore: CocktailStore
    @Binding var isShowing: Bool    // TodayBartender뷰를 닫기 위한 Bool 타입 변수
    
    var cocktailTagList: [String] = []
    let cocktailName: String = "애플 마티니"
    let cocktailImage: String = "TestCocktailImage"
    let cocktailDescription: String = "애플 마티니는 어쩌구 저저구 아주 자세한 설명입니다~ 마티니 블루웅 우우아아아아아 ㅇㅇ 설명입니다. 애플 마티니는 어쩌구 저저구 아주 자세한 설명입니다~ 마티니 블루웅 우우아아아아아 ㅇㅇ 설명입니다."
    
    let beforeAnswer: String

    var body: some View {
        VStack {
            ScrollView {
                
                CocktailDetailView(cocktail: cocktailStore.todayBartenerResult ?? Cocktail(id: 1, cocktailName: "더티마더", cocktailImageUrl: "https://w.namu.la/s/11cc356e3c1dc51471ec972952394ce95c1d5e48e88595fb77df2cdc7f1465e0864b65a0e13a88ec51c489b6968bdf1e6d20f484b2e9c301cef9aafcd3245074cc1bb9e5231fe13220fda7d33a34050dfb9b00299fffc5f0fce5e87c38a8f88aa6f725e3c42ab560cecbbe1ef485dfd5", description: "향긋한 커피 향의 칵테일", degree: 33, taste: ["달달한 맛"], scent: ["커피향"], baseSpirit: "브랜디", isSparkling: false, color: ["커피향"], cocktailIcon: "dirtyMother"))
                
//                Button {
//                    /* 내 술장에 해당 칵테일을 추가하는 메서드를 호출합니다. */
//                    print("내 술장에 추가합니다.")
//                } label: {
//                    Text("내 술장에 추가하기")
//                        .bold()
//                        .padding(.vertical, 15)
//                        .frame(width: 218)
//                        .background(Color(.systemGray3))
//                        .foregroundColor(.white)
//                        .cornerRadius(10)
//                }
//                .padding()
                
                Divider()
                    .background(Color.gray)
                    .padding(.horizontal, horizontalSpace)
                    .padding(.vertical, 20)
                
                // 추천된 칵테일과 비슷한 칵테일 추천 탭
                Text("\(cocktailStore.todayBartenerResult?.cocktailName ?? "더티마더")와(과) 비슷한 칵테일")
                    .frame(width: UIScreen.screenWidth - horizontalSpace*2, alignment: .leading)
                    .modifier(CategoryTextModifier())
                    .padding()
                
                HStack {
                    ForEach(1...3, id:\.self) { index in
                        VStack {
                            Image(targetCocktailList[index].0)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 76, height: 76)
                                .cornerRadius(10).frame(width: 100, height: 100) // 양쪽 여백 27
                            
//                            AsyncImage(url : URL(string : targetCocktailList[index].0))
//
//                            Image("TestCocktailImage")
//                                .resizable()
//                                .aspectRatio(contentMode: .fill)
//                                .frame(width: 100, height: 100)
//                                .cornerRadius(10)
                            Text(targetCocktailList[index].name)
                                .frame(width: 100)
                                .modifier(BodyTextModifier())
                                .padding(.top, 10)
                        }
                    }
                }
                
                Divider()
                    .background(Color.gray)
                    .padding(.horizontal, horizontalSpace)
                    .padding(.vertical, 20)

                Button {
                    isShowing.toggle()
                    print("홈으로 가기")
                } label: {
                    Text("홈으로 가기")
                        .modifier(BasicButtonModifier())
                }
                
                
                Button {
                    /* 다시 오늘의 칵테일 기능으로 가는 메서드를 추가합니다. */
                    print("다시 추천받기")
                } label: {
                    Text("다시 추천받기")
                        .bold()
                        .padding(.vertical, 25)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                
            }
        }
        .navigationBarBackButtonHidden()
        .navigationBarTitleDisplayMode(NavigationBarItem.TitleDisplayMode.inline)
        .onAppear {
            print("\(beforeAnswer)")
            profileViewModel.surveyAnswer.favoriteBaseSpirit.append(beforeAnswer)
            /* 설문 결과를 받는 함수를 호출한다. */
            cocktailStore.getTodayBartenerResult(surveyAnswer: profileViewModel.surveyAnswer)
            Task {
                await profileViewModel.updateUserInfo(in: Auth.auth().currentUser?.uid, with: .userSurveyAnswer(value: .favoriteBaseSpirit(value: [beforeAnswer])))
            }
        }
    }
        
}


struct TodayBartenderResultView_Previews: PreviewProvider {
    @State static var isShowing: Bool = true
    static var previews: some View {
        TodayBartenderResultView(isShowing: $isShowing, beforeAnswer: "")
    }
}
