//
//  cokcokApp.swift
//  cokcok
//
//  Created by 원태영 on 2023/01/05.
//

import SwiftUI
import FirebaseCore

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        
        return true
    }
}

@main
struct cokcokApp: App {
    // register app delegate for Firebase setup
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(AuthStore())
                .environmentObject(ProfileViewModel())
                .environmentObject(MissionViewModel())
                .environmentObject(CocktailStore(cocktails: cocktailData))
        }
    }
}
