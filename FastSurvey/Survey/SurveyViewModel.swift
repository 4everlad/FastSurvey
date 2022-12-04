//
//  SurveyViewModel.swift
//  FastSurvey
//
//  Created by Dmitry Bakulin on 17.11.2022.
//

import Foundation

class SurveyViewModel: ObservableObject {
    
    private let accountManager = AccountManager.shared
    private let networkClient = NetworkClient()
    
    @Published var survey: Survey = Survey() {
        didSet {
            setVoteCounters()
        }
    }
    
    @Published var saveSurveyState = SaveSurveyState()
    
    @Published var isLoading = false
    @Published var showModal = false
    
    @Published var upCounter = 0
    @Published var downCounter = 0
    
    init(surveyID: String) {
        getSurvey(by: surveyID)
    }
    
    func getSurvey(by id: String) {
        guard let token = accountManager.token else {
            return
        }
        
        isLoading = true
        
        networkClient.getSurvey(token: token, id: id, completion: { [weak self] (survey, error) in
            
            if let json = survey {
                DispatchQueue.main.async {
                    self?.survey = Survey(with: json)
                    self?.isLoading = false
                }
            } else if let error = error {
                print(error.localizedDescription)
            }
        })
        
    }
    
    func updateSurvey(title: String, description: String, surveyId: String) {
        guard !isLoading else { return }
        guard let token = accountManager.token else { return }
        
        let params = SurveyParams(title: title, desc: description)
        
        isLoading = true
        
        networkClient.updateSurvey(token: token, params: params, id: surveyId, completion: { [weak self] (survey, error) in
            
            if let json = survey {
                let survey = Survey(with: json)
                
                DispatchQueue.main.async {
                    self?.isLoading = false
                    self?.survey = survey
                }
                
            } else if let error = error {
                print(error.localizedDescription)
            }
        })
    }
    
    func removeSurvey(completion: @escaping () -> Void) {
        guard !isLoading else { return }
        guard let token = accountManager.token else { return }
        
        isLoading = true
        
        networkClient.removeSurvey(token: token, id: survey.id, completion: { [weak self] result, message in
            
            guard result == true else {
                self?.isLoading = false
                return
            }
            
            DispatchQueue.main.async {
                self?.isLoading = false
                completion()
            }
        })
    }
    
    func setVoteCounters() {
        self.upCounter = survey.upVotes.count
        self.downCounter = survey.downVotes.count
    }
    
}
