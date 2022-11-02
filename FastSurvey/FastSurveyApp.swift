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
    
    var body: some Scene {
        WindowGroup {
            NavigationContainerView(transition: Transition.custom(.slide), content: {
                TabController()
            })
            .environmentObject(SurveyFeedViewModel())
        }
    }
}
