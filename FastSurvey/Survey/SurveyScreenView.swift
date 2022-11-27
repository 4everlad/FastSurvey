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
                    Section {
                        Text(viewModel.survey.title)
                            .font(.title)
                        Text(viewModel.survey.description)
                    }
                    
                    Section {
                        VStack {
                            HStack {
                                Image(systemName: "hand.thumbsup")
                                    .foregroundColor(Constants.Colors.goodColor)
                                Text("\(viewModel.upCounter)")
                                    .foregroundColor(Constants.Colors.goodColor)
                            }
                            
                            HStack {
                                Image(systemName: "hand.thumbsdown")
                                    .foregroundColor(Constants.Colors.badColor)
                                Text("\(viewModel.downCounter)")
                                    .foregroundColor(Constants.Colors.badColor)
                            }
                        }
                    }
                }
                .navigationBarTitle(Text("Survey"))
                .navigationBarTitleDisplayMode(.inline)
                .padding()
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button {
                            listener?.pop()
                        } label: {
                            HStack {
                                Image(systemName: "chevron.backward")
                                Text("Back")
                            }
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
                                    
                                    viewModel.updateSurvey(title: title, description: description, surveyId: surveyId)
                                    viewModel.saveSurveyState.reset()
                                })
                            } // .sheet
                    }
                }
            } // LoadingView
        } // NavigationView
    }
    
}

//struct SurveyScreenView_Previews: PreviewProvider {
//    static var previews: some View {
//        SurveyScreenView()
//    }
//}
