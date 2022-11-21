//
//  SurveyScreenView.swift
//  FastSurvey
//
//  Created by Dmitry Bakulin on 17.11.2022.
//

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
                    
                    HStack {
                        Text("Upvoted: \(viewModel.upCounter)")
                            .foregroundColor(.green)
                        
                        Spacer()
                        
                        Text("Downvoted: \(viewModel.downCounter)")
                            .foregroundColor(.red)
                    }
                    
                }
                .navigationBarTitle(Text("Survey"))
                .navigationBarTitleDisplayMode(.inline)
                .padding()
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button("Back") {
                            listener?.pop()
                        }
                    }
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Image(systemName: "ellipsis.circle")
                            .foregroundColor(.blue)
                            .contextMenu {
                                VStack {
                                    Button (action: {
                                        viewModel.saveSurveyState.set(with: viewModel.survey)
                                        viewModel.showModal.toggle()
                                    }) {
                                        HStack {
                                            Text("Edit")
                                            Image(systemName: "pencil.circle")
                                        }
                                    }
                                    
                                    Button (role: .destructive) {
                                        viewModel.removeSurvey(completion: {
                                            listener?.pop()
                                        })
                                    } label: {
                                        HStack {
                                            Text("Remove")
                                            Image(systemName: "trash")
                                        }
                                    }
                                }
                            } // .contextMenu
                            .sheet(isPresented: $viewModel.showModal) {
                                SaveSurveyView(saveSurveyState: $viewModel.saveSurveyState,
                                               saveClicked: {
                                    viewModel.showModal.toggle()
                                    let title = viewModel.saveSurveyState.title
                                    let description = viewModel.saveSurveyState.description
                                    let surveyId = viewModel.saveSurveyState.surveyId
                                    
                                    if viewModel.saveSurveyState.operationType == .update {
                                        viewModel.updateSurvey(title: title, description: description, surveyId: surveyId)
                                    }
                                    
                                    viewModel.saveSurveyState.reset()
                                })
                            } // .sheet
                    }
                }
            }
        }
    }
    
}

//struct SurveyScreenView_Previews: PreviewProvider {
//    static var previews: some View {
//        SurveyScreenView()
//    }
//}
