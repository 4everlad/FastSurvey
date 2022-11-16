//
//  UserSurveysListView.swift
//  FastSurvey
//
//  Created by Dmitry Bakulin on 15.11.2022.
//

import Foundation
import SwiftUI
import SwiftUINavigator

struct UserSurveysListView: View, IItemView {
    var listener: INavigationContainer?
    
    @ObservedObject var viewModel: UserSurveysViewModel

    var body: some View {
        List {
            ForEach(viewModel.surveys) { item in
                SurveyCellView(survey: item)
                    .contentShape(Rectangle())
                    .listRowSeparator(.hidden)
            }
        }
        .listStyle(.plain)
        .onAppear {
            viewModel.getSurveys()
        }
    }
}
