//
//  SurveyFeedListView.swift
//  FastSurvey
//
//  Created by Dmitry Bakulin on 31.10.2022.
//

import Foundation
import SwiftUI
import SwiftUINavigator

struct SurveysListView: View, IItemView {
    var listener: INavigationContainer?
    
    @EnvironmentObject var viewModel: SurveyFeedViewModel
    
    var body: some View {
        List {
            VStack {
                ForEach(viewModel.surveys) { item in
                    SurveyCellView(survey: item)
                        .onTapGesture {
                            listener?.push(view: SurveyScreenView(survey: item))
                        }
                        .listRowSeparator(.hidden)
                }
            }
        }
        .listStyle(.plain)
    }
}
