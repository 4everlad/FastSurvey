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
            ForEach(viewModel.surveys) { item in
                let isElementLast = viewModel.surveys.isLast(item)
                SurveyCellView(survey: item)
                    .onTapGesture {
                        listener?.push(view: SurveyScreenView(survey: item))
                    }
                    .onAppear {
                        if viewModel.canLoad && isElementLast {
                            viewModel.getSurveys()
                        }
                    }
                    .progressBar(isLoading: isElementLast && viewModel.canLoad == false)
                    .listRowSeparator(.hidden)
            }
        }
        .listStyle(.plain)
        .onAppear {
            viewModel.getSurveys()
        }
    }
}
