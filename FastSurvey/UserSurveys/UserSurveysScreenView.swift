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
    
    @State var showModal: Bool = false
    
    @StateObject var viewModel: UserSurveysViewModel = .init()
    
    var body: some View {
        NavigationView {
            LoadingView(isShowing: $viewModel.isLoading) {
                VStack {
                    UserSurveysListView(listener: listener, viewModel: viewModel)
                }
                .navigationBarTitleDisplayMode(.inline)
                .navigationTitle(Text("My Surveys"))
                .navigationBarItems(trailing:
                                        Button(action: {
                    showModal.toggle()
                }, label: {
                    Image(systemName: "square.and.pencil")
                })
                                        .sheet(isPresented: $showModal) {
                    SaveSurveyView(title: "Create Survey", saveClicked: { title, description in
                        showModal.toggle()
                        viewModel.makeSurvey(title: title, description: description)
                    })
                }
                )
            }
        } // NavigationView
//        .onChange(of: viewModel.surveys, perform: {newValue in
//            viewModel.sortSurveys()
//        })
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
