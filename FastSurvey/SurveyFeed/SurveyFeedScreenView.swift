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
    
    @StateObject var viewModel: SurveyFeedViewModel = .init()
    
    var body: some View {
        NavigationView {
            VStack {
                SurveysListView(listener: listener, viewModel: viewModel)
            }
            .navigationTitle(Text("Survey Feed"))
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct SurveyFeedScreenView_Previews: PreviewProvider {
    static var previews: some View {
        SurveyFeedScreenView()
    }
}
