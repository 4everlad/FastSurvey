//
//  TabController.swift
//  FastSurvey
//
//  Created by Dmitry Bakulin on 31.10.2022.
//

import SwiftUI

struct TabController: View {
    
    @State var tabSelection: Int = 0
    
    var body: some View {
        
        TabView(selection: $tabSelection) {
            SurveyFeedScreenView()
                .tag(0)
                .tabItem {
                    Label("Survey Feed", systemImage: "list.bullet.rectangle.fill")
                }
            
            UserSurveyScreenView()
                .tag(1)
                .tabItem {
                    Label("My Surveys", systemImage: "tray.full.fill")
                }
        }
        
    }
}
