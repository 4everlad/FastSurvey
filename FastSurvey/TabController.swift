//
//  TabController.swift
//  FastSurvey
//
//  Created by Dmitry Bakulin on 31.10.2022.
//

import SwiftUI
import SwiftUINavigator

struct TabController: View, IItemView {
    
    var listener: INavigationContainer?
    
    @EnvironmentObject var router: NavigationState
    
    var body: some View {
        
        TabView(selection: $router.tabSelection) {
            SurveyFeedScreenView(listener: listener)
                .tag(0)
                .tabItem {
                    Label("Survey Feed", systemImage: "list.bullet.rectangle.fill")
                }
            
            UserSurveysScreenView(listener: listener)
                .tag(1)
                .tabItem {
                    Label("My Surveys", systemImage: "tray.full.fill")
                }
            
            UserAccountScreenView(listener: listener)
                .tag(2)
                .tabItem {
                    Label("Profile", systemImage: "person.crop.circle.fill")
                }
            
        }
    }
}
