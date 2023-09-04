//
//  ShelfView.swift
//  cokcok
//
//  Created by 이민경 on 2023/01/05.
//

import SwiftUI

struct ShelfView: View {
    @State private var selection: Int = 0
    @EnvironmentObject var vm: ProfileViewModel
    @EnvironmentObject var auth: AuthStore
    @EnvironmentObject var cocktailStore: CocktailStore
    
    let timer = Timer.publish(every: 3, on: .main, in: .common).autoconnect()
    let images = ["ad1", "ad2", "ad3"]
    var userInfo: UserInfo? {
        get {
            return vm.userInfo
        }
    }
    
    var body: some View {
        VStack{
            HStack{
                Text("콕콕🍹")
                    .font(.largeTitle)
                Spacer()
                // TODO: userName으로 변경
                Text("\(userInfo?.userName ?? "없음")님\n안녕하세요!")
            }
            .padding()
            Text("나의 칵테일 술장")
                .font(.title3)
            ScrollView(showsIndicators: false) {
                // 전체 칵테일 데이터 중 4개씩 잘라서 뷰에 매개변수로 넣어서 호출해주면 된다.
                MyShelfView(userShelfCocktails: userInfo?.userShelf ?? [])
            }
            .frame(maxWidth: .infinity)
            Spacer()
            TabView(selection: $selection) {
                ForEach(0 ..< images.count, id: \.self) { index in
                    Image(images[index]).resizable().tag(index)
                }
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
            .frame(height: 66)
            .padding(.horizontal, 27)
        }
        .bold()//VStack
        .onReceive(timer) { t in
            selection += 1
            
            if selection == 4 {
                selection = 0
            }
        }
        .animation(.easeIn, value: selection)
        .task {
            await vm.requestUserInfo(in: auth.currentUser?.uid)
        }
        
    }
}

// TODO: cocktail 배열의 cocktailName과 shelf의 cocktailName이 같은 이미지를 받아와야 함!!
struct MyShelfView: View {
    
    @EnvironmentObject var cocktailStore: CocktailStore
    /// UserInfo의 UserShelf에 접근해서 cocktailName을 받아온다
    /// cocktailJSON 데이터에서 해당하는 cocktailName의 flaticonImageURL을 받아와서 칵테일 아이콘 이미지와 레이블을 같이 표시한다
	
    // UserInfo의 UserShelf에 접근해서 받아온 cocktailName의 배열
	var userShelfCocktails: [Shelf]
    var userShelfCocktailsArr: [[Shelf]] {
        get {
            var result: [[Shelf]] = []
            var subArr: [Shelf] = []
            if !userShelfCocktails.isEmpty {
                for i in userShelfCocktails {
                    subArr.append(i)
                    if subArr.count == 4 {
                        result.append(subArr)
                        subArr.removeAll()
                    }
                }
                if subArr.count != 0 {
                    result.append(subArr)
                }
                return result
            } else {
                for i in 1 ... 4 {
                    subArr.append(Shelf(id: String(i + 100), cocktailName: CocktailName(rawValue: "emptyCocktail\(i)") ?? .emptyCocktail1, uploadDate: Date()))
                }
                for _ in 1 ... 3 {
                    result.append(subArr)
                }
                return result
            }
        }
    }

    var body: some View {
        VStack {
			ForEach(0 ..< 5, id: \.self) { index in
                HStack(spacing: 0) {
					switch index { // idx
					case 0:
						let _ = print("======", index, userShelfCocktails.count)
						
						ForEach(0 ..< userShelfCocktails.count, id: \.self) { idx in
							VStack(spacing: 0) {
								Image("\(String(describing: cocktailStore.cocktails.filter { $0.cocktailName == userShelfCocktails[idx].cocktailName.rawValue}.first!.cocktailIcon))")
									.resizable()
									.aspectRatio(contentMode: .fit)
									.frame(width: 60, height: 60)
								
								Image("WoodDivider")
									.resizable()
									.frame(width: 75, height: 5)
									.padding(.horizontal, -5)
								Text("\(userShelfCocktails[idx].cocktailName.rawValue)")
									.font(.footnote)
									.frame(width: 60, alignment: .center)
							}.padding(.vertical, 20)
						}
						
					case 1 ... 999:
						ForEach(0 ..< 10, id: \.self) { index in
							VStack(spacing: 0) {
								Image("\(["emptyCocktail1", "emptyCocktail2", "emptyCocktail3", "emptyCocktail4"].randomElement()!)")
									.resizable()
									.aspectRatio(contentMode: .fit)
									.frame(width: 60, height: 60)
								
								Image("WoodDivider")
									.resizable()
									.frame(width: 75, height: 5)
									.padding(.horizontal, -5)
								Text("")
									.font(.footnote)
									.frame(width: 60, alignment: .center)
							}.padding(.vertical, 20)
						}
					default:
						EmptyView().frame()
					}
                }
            }
        }
//        VStack(spacing: 0){
//            HStack(spacing: 20) {
//                ForEach(0..<4) {
//                    // TODO: 데이터 연결 후 칵테일 이미지 표시해야 함
//                    /// userShelfCocktails에서 하나씩 remove 하면서 remove 함수로 반환되는 칵테일 이름에 대한 flaticonImageURL을 이미지로 표시한다
//                    /// userShelfCocktails이 비어있으면 emptyCocktail을 표시한다.
//                    Image("emptyCocktail\($0 + 1)")
//                        .resizable()
//                    // FIXME: emptyCocktail1은 이미지 재가공해야 함
//                    //                        .aspectRatio(contentMode: .fit)
//                        .frame(width: 60, height: 60)
//                }
//            }
//            Image("WoodDivider")
//                .resizable()
//                .frame(maxWidth: .infinity, maxHeight: 15)
//            HStack(spacing: 20) {
//                ForEach(0..<4) { _ in
//                    // TODO: 데이터 연결 후 칵테일 이름 레이블 표시해야 함
//                    /// userShelfCocktails에서 하나씩 remove 하면서 remove 함수로 반환되는 칵테일 이름을 표시한다
//                    Text("파우스트")
//                        .font(.footnote)
//                        .frame(width: 60, alignment: .center)
//                }
//            }.padding()
//        }
//        .padding(.horizontal)
    }
}


struct ShelfView_Previews: PreviewProvider {
    static var previews: some View {
        ShelfView()
            .environmentObject(AuthStore())
            .environmentObject(ProfileViewModel())
            .environmentObject(CocktailStore())
    }
}
