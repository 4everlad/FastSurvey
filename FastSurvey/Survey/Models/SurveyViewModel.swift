//
//  SurveyViewModel.swift
//  FastSurvey
//
//  Created by Dmitry Bakulin on 11.11.2022.
//

import Foundation

class SurveyViewModel: ObservableObject {
    
    let accountManager = AccountManager.shared
    @Published var survey: Survey? {
        didSet {
            guard let survey = survey else { return }
            self.isUp = false
            self.isDown = false
            if survey.upVotes.contains(survey.ownerId) {
                isUp = true
            }
            if survey.downVotes.contains(survey.ownerId) {
                isDown = true
            }
        }
    }
    
    @Published var isUp: Bool = false
    @Published var isDown: Bool = false
    
//    var canLoad = true
    
    func getSurvey(by id: String) {
        
//        guard canLoad == true else { return }
        
        guard let token = accountManager.token else {
            print("ffffff no token")
            return
        }
        
        NetworkClient().getSurvey(token: token, id: id, completion: { [weak self] (survey, error) in
            
            if let json = survey {
                DispatchQueue.main.async {
                    self?.survey = Survey(with: json)
                }
            } else if let error = error {
                print(error.localizedDescription)
            }
        })
        
    }
}
