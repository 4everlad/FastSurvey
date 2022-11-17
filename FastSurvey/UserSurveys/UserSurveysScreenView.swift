//
//  UserSurveyScreenView.swift
//  FastSurvey
//
//  Created by Dmitry Bakulin on 31.10.2022.
//

import SwiftUI
import SwiftUINavigator

struct UserSurveysScreenView: View, IItemView {
    var listener: INavigationContainer?
    
    @StateObject var viewModel: UserSurveysViewModel = .init()
    
    var body: some View {
        NavigationView {
            LoadingView(isShowing: $viewModel.isLoading) {
                VStack {
                    UserSurveysListView(listener: listener, viewModel: viewModel)
                }
                .padding([.top])
                .navigationBarTitleDisplayMode(.inline)
                .navigationTitle(Text("My Surveys"))
                .navigationBarItems(trailing:
                                        Button(action: {
                    viewModel.showModal.toggle()
                }, label: {
                    Image(systemName: "square.and.pencil")
                })
                                        .sheet(isPresented: $viewModel.showModal) {
                    SaveSurveyView(saveSurveyState: $viewModel.saveSurveyState,
                                   saveClicked: {
                        viewModel.showModal.toggle()
                        let title = viewModel.saveSurveyState.title
                        let description = viewModel.saveSurveyState.description
                        let surveyId = viewModel.saveSurveyState.surveyId
                        
                        switch viewModel.saveSurveyState.operationType {
                        case .add:
                            viewModel.makeSurvey(title: title, description: description)
                        case .update:
                            viewModel.updateSurvey(title: title, description: description, surveyId: surveyId)
                        }
                        
                        viewModel.saveSurveyState.reset()
                        
                    })
                }
                )
            } // LoadingView
        }
        .onAppear {
            viewModel.getSurveys()
        }
    }
}

struct UserSurveyScreenView_Previews: PreviewProvider {
    static var previews: some View {
        UserSurveysScreenView()
    }
}
