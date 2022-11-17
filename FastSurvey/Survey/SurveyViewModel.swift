//
//  SurveyViewModel.swift
//  FastSurvey
//
//  Created by Dmitry Bakulin on 17.11.2022.
//

import Foundation

class SurveyViewModel: ObservableObject {
    
    let accountManager = AccountManager.shared
    
    @Published var survey: Survey = Survey() {
        didSet {
            setVoteCounters()
        }
    }
    @Published var isLoading = false
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
        
        NetworkClient().getSurvey(token: token, id: id, completion: { [weak self] (survey, error) in
            
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
    
    func setVoteCounters() {
        self.upCounter = survey.upVotes.count
        self.downCounter = survey.downVotes.count
    }
    
}
