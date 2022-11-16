//
//  UserSurveysViewModel.swift
//  FastSurvey
//
//  Created by Dmitry Bakulin on 15.11.2022.
//

import Foundation

class UserSurveysViewModel: ObservableObject {
    
    let accountManager = AccountManager.shared
    
    @Published var surveys: [Survey] = []
    @Published var isLoading: Bool = false
    
    func makeSurvey(title: String, description: String) {
        
        guard !isLoading else { return }
        guard let token = accountManager.token else {
            return
        }
        
        let params = SurveyParams(title: title, desc: description)

        isLoading = true
        
        NetworkClient().createSurvey(token: token, params: params, completion: { [weak self] (survey, error) in
                
                if let json = survey {
                    let survey = Survey(with: json)
                    DispatchQueue.main.async {
                        self?.surveys.append(survey)
                        self?.isLoading = false
                    }
                } else if let error = error {
                    print(error.localizedDescription)
                }
            print("ffffff make survey")
        })
        
    }
    
    func getSurveys() {
        guard !isLoading else { return }
        guard let token = accountManager.token else {
            return
        }
        
        NetworkClient().getUserSurveys(token: token, completion: { [weak self] (surveysJson, error) in
            if let surveys = surveysJson {
                let userSurveys: [Survey] = surveys.compactMap {
                    let survey = Survey(with: $0)
                    return survey
                }
                DispatchQueue.main.async {
                    self?.surveys = userSurveys
                }
            } else if let error = error as? CustomError {
                print(error.message)
            } else if let error = error {
                print(error)
            }
        })
        
    }
    
}
