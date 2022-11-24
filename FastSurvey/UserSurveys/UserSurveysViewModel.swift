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
    @Published var showModal: Bool = false
    @Published var saveSurveyState = SaveSurveyState()
    
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
                        self?.isLoading = false
                        self?.surveys.insert(survey, at: 0)
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
                    self?.surveys = userSurveys.sorted { $0.id > $1.id }
                }
            } else if let error = error as? CustomError {
                print(error.message)
            } else if let error = error {
                print(error)
            }
        })
        
    }
    
    func removeSurvey(_ survey: Survey) {
        guard !isLoading else { return }
        guard let token = accountManager.token else { return }
        
        isLoading = true
        
        Task {
            do {
                let result = await NetworkClient().removeSurveyAsync(token: token, id: survey.id)
                guard result == true else { return }
                guard let index = self.surveys.firstIndex(where: {$0.sid == survey.sid}) else { return }
                
                DispatchQueue.main.async {
                    self.isLoading = false
                    self.surveys.remove(at: index)
                }
            } catch {
                print("async remove error")
            }
        }
    }
    
    func updateSurvey(title: String, description: String, surveyId: String) {
        guard !isLoading else { return }
        guard let token = accountManager.token else { return }
        
        let params = SurveyParams(title: title, desc: description)
        
        isLoading = true
        
        NetworkClient().updateSurvey(token: token, params: params, id: surveyId, completion: { [weak self] (survey, error) in
            
            if let json = survey {
                let survey = Survey(with: json)
                
                guard let index = self?.surveys.firstIndex(where: {$0.sid == surveyId}) else {
                    return
                }
                
                DispatchQueue.main.async {
                    self?.isLoading = false
                    self?.surveys[index] = survey
                }
                
            } else if let error = error {
                print(error.localizedDescription)
            }
        })
    }
    
}
