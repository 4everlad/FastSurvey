//
//  SurveyScreenView.swift
//  FastSurvey
//
//  Created by Dmitry Bakulin on 02.11.2022.
//

import Foundation
import SwiftUI
import SwiftUINavigator

struct SurveyScreenView: View, IItemView {
    
    var listener: INavigationContainer?
    
    @ObservedObject var viewModel: SurveyViewModel
    
    init(surveyID: String) {
        self.viewModel = SurveyViewModel(surveyID: surveyID)
    }
    
    var body: some View {
        NavigationView {
            LoadingView(isShowing: $viewModel.isLoading) {
                VStack(alignment: .leading, spacing: 32) {
                        Text(viewModel.survey.title)
                            .font(.title)
                        Text(viewModel.survey.description)
                        VoteView(viewModel: viewModel)
                        Spacer()
                }
                .navigationBarItems(leading:
                    Button(action: {
                        listener?.pop()
                    }, label: {
                        Text("Feed")
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
