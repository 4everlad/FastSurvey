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
    var surveyID: String
    
    @StateObject var viewModel: SurveyViewModel = .init()
    
//    @State var widthButton: CGFloat = 100
//    @State var heightButton: CGFloat = 50
    
    var body: some View {
        NavigationView {
//            if let viewModel.survey = Survey
            VStack(alignment: .leading, spacing: 32) {
                if viewModel.survey != nil {
                    Text(viewModel.survey!.title)
                        .font(.title)
                    Text(viewModel.survey!.description)
                    VoteView(survey: $viewModel.survey.optionalBinding(defaultValue: Survey()), isUp: $viewModel.isUp, isDown: $viewModel.isDown)
                    Spacer()
                } else {
                    Text("Is Loading...")
                }
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
        .onAppear {
            viewModel.getSurvey(by: surveyID)
        }
    }
}

//struct SurveyScreenView_Previews: PreviewProvider {
//    static var previews: some View {
//        SurveyScreenView()
//    }
//}
