//
//  HomeView.swift
//  cokcok
//
//  Created by Donghoon Bae on 2023/01/05.
//

import SwiftUI

struct HomeView: View {
    
    @EnvironmentObject var vm: ProfileViewModel
    @EnvironmentObject var auth: AuthStore
    @EnvironmentObject var cs: CocktailStore
    
    @State private var selection: Int = 0
    @Binding var isShowing: Bool
    
    let timer = Timer.publish(every: 3, on: .main, in: .common).autoconnect()
    
    var userInfo: UserInfo? {
        get {
            return vm.userInfo
        }
    }
    
    var cocktail: Cocktail? {
        get {
            return cs.todayBartenerResult
        }
    }
    
    
    let images = ["ad1", "ad2", "ad3"]
    
    var body: some View {
        VStack {
            HStack{
                Text("콕콕🍸")
                    .font(.largeTitle)
                    .bold()
                Spacer()
            }
            .padding()
            Spacer()
            if cocktail != nil {
                VStack {
                    HStack {
                        Text("\(userInfo?.userName ?? "UserInfo 아직 없음")님에게 추천하는 칵테일")
                            .modifier(CategoryTextModifier())
                            .padding(.leading, horizontalSpace)
                        Spacer()
                    }
                    //            HomeRecommendCard(cocktail: Cocktail(id: "jkfdlsajfkld", cocktailName: "애플 모히또", cocktailImageUrl: "http://meloncoffee.com/wp-content/uploads/2021/12/cocktail-gf3d8fe9af_1280.jpg", description: "달콤한 사과가 들어간 모히또!", degree: 8, taste: ["상큼한 맛", "달달한 맛"], scent: ["라임향", "허브향", "과일향"], baseSpirit: "럼", isSparkling: true, color: ["투명", "초록", "빨강"]))
                    HomeRecommendCard(cocktail: cocktail!)
                        .frame(width: UIScreen.screenWidth - horizontalSpace*2)
                }
                Spacer()
                Button {
                    isShowing = true
                } label: {
                    Rectangle()
                        .frame(width: 218, height: 43)
                        .foregroundColor(Color.cokcokPink)
                        .cornerRadius(10)
                        .overlay {
                            Text("칵테일 다시 추천받기")
                                .foregroundColor(.black)
                        }
                }
            } else {
                VStack {
                    Image("speechBubble1")
                        .resizable()
                        .renderingMode(.original)
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 80)
                        .overlay {
                            Text("오늘 추천받은 칵테일이 없어요.").bold()
                        }
                        .padding(.vertical, 10)
                    Image("speechBubble2")
                        .resizable()
                        .renderingMode(.original)
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 160)
                        .overlay {
                            VStack {
                                Spacer()
                                Text("바텐더님,\n칵테일 추천해주세요!")
                                    .foregroundColor(.black)
                                Spacer()
                                Button {
                                    isShowing = true
                                } label: {
                                    Text("추천 바로가기 ->")
                                        .foregroundColor(.black)
                                        .underline()
                                }
                                Spacer()
                            }
                        }
                        .padding(.vertical, 10)
                }
            }
            
            Spacer()
            TabView(selection: $selection) {
                ForEach(0 ..< images.count, id: \.self) { index in
                    Image(images[index]).resizable().tag(index)
                }
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
            .frame(height: 66)
            .onReceive(timer) { t in
                selection += 1
                
                if selection == 4 {
                    selection = 0
                }
            }
            .task {
                await vm.requestUserInfo(in: auth.currentUser?.uid)
            }
            .animation(.easeIn, value: selection)
            .padding(.horizontal, 27)
            .padding(.bottom, 20)
        }
    }
}


//struct HomeView_Previews: PreviewProvider {
//    static var previews: some View {
//        NavigationStack {
//            HomeView(userInfo: UserInfo(id: "", userName: "ㅇㅇ", userEmail: "", userBirthday: Date(), surveyAnswer: [], userShelf: Shelf(id: "", cocktailName: "", uploadDate: Date())))
//        }
//    }
//}

