//
//  ContentView.swift
//  cokcok
//
//  Created by 원태영 on 2023/01/05.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var authStore : AuthStore
    @State private var isShowing: Bool = true
    @State private var isLoginTried : Bool = false
    
    var body: some View {
        Group {
            if authStore.isLogin {
                TabView {
                    NavigationStack {
                        HomeView(isShowing : $isShowing) // HomeView
                    }
                    .modifier(NavigationTitleModifier(title: "홈"))
                    .tabItem {
                        Image(systemName: "house")
                    }
                    
                    NavigationStack {
                        DictionaryView() // DictionaryView
                    }
                    .modifier(NavigationTitleModifier(title: "칵테일 사전"))
                    .tabItem {
                        Image(systemName: "book.closed")
                    }
                    
                    NavigationStack {
                        ShelfView() // ShelfView
                    }
                    .modifier(NavigationTitleModifier(title: "내 술장"))
                    .tabItem {
                        Image(systemName: "cabinet")
                    }
                    
                    NavigationStack {
                        MainProfileView() // ProfileView
                    }
                    .modifier(NavigationTitleModifier(title: "프로필"))
                    .tabItem {
                        Image(systemName: "person.circle")
                    }
                }
                .fullScreenCover(isPresented: $isShowing) {
                    NavigationStack {
                        TodayBartenerView(isShowing: $isShowing)
                    }
                }
            } else {
                NavigationView {
                    LoginView()
                        .modifier(NavigationTitleModifier(title: "로그인"))
                }
            }
        }
        .task {
            // 시나리오 확인을 위해 앱 실행 시 무조건 로그인 시킴
//            if !isLoginTried {
//                authStore.logout()
//                isLoginTried = true
//            }
            if authStore.currentUser != nil {
                authStore.isLogin = true
            }
        }
    }
}
