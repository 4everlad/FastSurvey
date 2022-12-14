//
//  CreateUserSurveyView.swift
//  FastSurvey
//
//  Created by Dmitry Bakulin on 15.11.2022.
//

import SwiftUI

struct SaveSurveyState {
    var surveyId: String = ""
    var title: String = ""
    var description: String = ""
    var operationType: OperationType = .add
    
    enum OperationType: String {
        case add = "Create survey"
        case update = "Update survey"
    }
    
    mutating func set(with survey: Survey) {
        self.surveyId = survey.sid
        self.title = survey.title
        self.description = survey.description
        self.operationType = .update
    }
    
    mutating func reset() {
        self.surveyId = ""
        self.title = ""
        self.description = ""
        self.operationType = .add
    }
}

struct SaveSurveyView: View {
    
    @Binding var saveSurveyState: SaveSurveyState
    @State var errorMessage: String = ""
    
    var saveClicked: (() -> ())
    
    func validateData() -> Bool {
        guard saveSurveyState.title.count > 0 else {
            errorMessage = "Enter title"
            return false
        }
        
        guard saveSurveyState.description.count > 0 else {
            errorMessage = "Enter description"
            return false
        }
        
        errorMessage = ""
        return true
    }
    
    var body: some View {
        VStack {
            Text(saveSurveyState.operationType.rawValue)
                .font(.headline)
                .padding(16)
            
            VStack(alignment: .leading) {
                Text("Enter title")
                    .font(.subheadline)
                TextEditor(text: $saveSurveyState.title)
                    .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.blue, lineWidth: 1))
                    .frame(maxWidth: .infinity)
                    .frame(minHeight: 80, maxHeight: 100)
                    .onChange(of: saveSurveyState.title, perform: { newValue in
                        errorMessage = ""
                    })
                    
            }
            .padding([.bottom])
            
            VStack(alignment: .leading) {
                Text("Enter description")
                    .font(.subheadline)
                TextEditor(text: $saveSurveyState.description)
                    .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.blue, lineWidth: 1))
                    .onChange(of: saveSurveyState.description, perform: { newValue in
                        errorMessage = ""
                    })
            }
            .padding([.bottom])
            
            Spacer()
            
            VStack  {
                Text(errorMessage)
                    .foregroundColor(.red)
                    .padding()
                Button {
                    guard validateData() else { return }
                    saveClicked()
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

