//
//  CreateUserSurveyView.swift
//  FastSurvey
//
//  Created by Dmitry Bakulin on 15.11.2022.
//

import SwiftUI

struct CreateSurveyView: View {
    
    var title: String
    @State var surveyTitle: String = ""
    @State var description: String = ""
    @State var errorMessage: String = ""
    
    var saveClicked: ((String, String) -> ())
    
    var body: some View {
        VStack {
            Text(title)
                .font(.headline)
                .padding(16)
            
            VStack(alignment: .leading) {
                Text("Enter title")
                    .font(.subheadline)
                TextEditor(text: $surveyTitle)
                    .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.blue, lineWidth: 1))
                    .frame(maxWidth: .infinity)
                    .frame(minHeight: 80, maxHeight: 100)
                    
            }
            .padding([.bottom])
            
            VStack(alignment: .leading) {
                Text("Enter description")
                    .font(.subheadline)
                TextEditor(text: $description)
                    .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.blue, lineWidth: 1))
            }
            .padding([.bottom])
            
            Spacer()
            
            VStack  {
                Text(errorMessage)
                    .foregroundColor(.red)
                    .padding()
                Button {
                    saveClicked(surveyTitle, description)
                } label: {
                    Text("Save")
                }
                .buttonStyle(.bordered)
                .buttonBorderShape(.capsule)
                .tint(.blue)
                .font(.title2)
            }
            
        }.padding()
    }
}

//struct UserSurveyScreenView_Previews: PreviewProvider {
//    static var previews: some View {
//        UserSurveysScreenView()
//    }
//}

