//
//  FastSurveyApp.swift
//  FastSurvey
//
//  Created by Dmitry Bakulin on 31.10.2022.
//

import SwiftUI
import SwiftUINavigator

@main
struct FastSurveyApp: App {
    
    init() {
        AccountManager.shared.loadAccount()
    }
    
    var body: some Scene {
        WindowGroup {
            NavigationContainerView(transition: Transition.custom(.scale)) {
                AuthScreenView()
            }
            .environmentObject(AccountManager.shared.router)
            .environmentObject(AccountManager.shared.userModel)
        }
    }
}
