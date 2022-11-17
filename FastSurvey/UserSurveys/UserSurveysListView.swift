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
                    .onTapGesture {
                        listener?.push(view: SurveyScreenView(surveyID: item.sid))
                    }
                    .contextMenu {
                        VStack {
                            Button (action: {
                                viewModel.saveSurveyState.set(with: item)
                                viewModel.showModal.toggle()
                            }) {
                                HStack {
                                    Text("Edit")
                                    Image(systemName: "pencil.circle")
                                }
                            }
                            
                            Button (role: .destructive) {
                                viewModel.removeSurvey(item)
                            } label: {
                                HStack {
                                    Text("Remove")
                                    Image(systemName: "trash")
                                }
                            }
                        }
                    } // .contextMenu
                    .listRowSeparator(.hidden)
            }
        }
        .listStyle(.plain)
        .refreshable {
            viewModel.getSurveys()
        }
    }
    
}
