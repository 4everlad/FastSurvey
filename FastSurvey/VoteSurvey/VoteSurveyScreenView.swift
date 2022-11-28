//
//  VoteSurveyScreenView.swift
//  FastSurvey
//
//  Created by Dmitry Bakulin on 02.11.2022.
//

import Foundation
import SwiftUI
import SwiftUINavigator

struct VoteSurveyScreenView: View, IItemView {
    
    var listener: INavigationContainer?
    
    @ObservedObject var viewModel: VoteSurveyViewModel
    
    init(surveyID: String) {
        self.viewModel = VoteSurveyViewModel(surveyID: surveyID)
    }
    
    var body: some View {
        NavigationView {
            LoadingView(isShowing: $viewModel.isLoading) {
                VStack(alignment: .leading, spacing: 32) {
                    Text(viewModel.survey.title)
                        .fontWeight(.bold)
                    Text(viewModel.survey.description)
                    VoteView(viewModel: viewModel)
                    Spacer()
                }
                .navigationBarItems(leading:
                                        Button(action: {
                    listener?.pop()
                }, label: {
                    HStack {
                        Image(systemName: "chevron.backward")
                        Text("Feed")
                    }
                })
                )
                .navigationBarTitle(Text("Survey"))
                .navigationBarTitleDisplayMode(.inline)
                .padding()
            }
        }
    }
}

//struct SurveyScreenView_Previews: PreviewProvider {
//    static var previews: some View {
//        SurveyScreenView()
//    }
//}
