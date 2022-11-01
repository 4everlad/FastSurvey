//
//  SurveyFeedScreenView.swift
//  FastSurvey
//
//  Created by Dmitry Bakulin on 31.10.2022.
//

import SwiftUI
import SwiftUINavigator

struct SurveyFeedScreenView: View, IItemView {
    var listener: INavigationContainer?
    
    var body: some View {
        VStack {
            
            SurveysListView(listener: listener)
    
        }
        .navigationTitle(Text("Survey Feed"))
    }
}

struct SurveyFeedScreenView_Previews: PreviewProvider {
    static var previews: some View {
        SurveyFeedScreenView()
    }
}
