//
//  SurveyViewModel.swift
//  FastSurvey
//
//  Created by Dmitry Bakulin on 11.11.2022.
//

import Foundation

enum VoteType: String {
    case up = "Up"
    case down = "Down"
    case none
}

struct StateButton {
    var isUp: Bool = false
    var isDown: Bool = false

    var upCounter = 0
    var downCounter = 0
}

class SurveyViewModel: ObservableObject {
    
    let accountManager = AccountManager.shared
    @Published var survey: Survey = Survey()
    
    @Published var voteType: VoteType = .none {
        didSet {
            switch voteType {
            case .none:
                stateButton.isUp = false
                stateButton.isDown = false
            case .up:
                stateButton.isUp = true
                stateButton.isDown = false
            case .down:
                stateButton.isUp = false
                stateButton.isDown = true
            }
        }
    }
    
    @Published var stateButton = StateButton()
    @Published var isLoading = false
    
    init(surveyID: String) {
        getSurvey(by: surveyID)
    }
    
    func getSurvey(by id: String) {
        
        guard let token = accountManager.token else {
            print("ffffff no token")
            return
        }
        
        isLoading = true
        
        NetworkClient().getSurvey(token: token, id: id, completion: { [weak self] (survey, error) in
            
            if let json = survey {
                DispatchQueue.main.async {
                    self?.survey = Survey(with: json)
                    self?.setVoteType()
                    self?.setVoteCounters()
                    self?.isLoading = false
                }
            } else if let error = error {
                print(error.localizedDescription)
            }
        })
        
    }
    
    func makeVote(vote: VoteType) {
        guard let token = accountManager.token else {
            print("ffffff no token")
            return
        }
        
        guard survey.id != "-1" else { return }
        
        let params = VoteParams(surveyId: survey.id, vote: vote.rawValue)
        
        NetworkClient().makeVote(token: token, params: params, completion: { [weak self] (survey, error) in
            
            if let json = survey {
                DispatchQueue.main.async {
                    self?.survey = Survey(with: json)
                    self?.setVoteType()
                    self?.setVoteCounters()
                }
            } else if let error = error {
                print(error.localizedDescription)
            }
        })
        
    }
    
    func setVoteType() {
        if survey.upVotes.contains(survey.ownerId) {
            voteType = .up
        } else if survey.downVotes.contains(survey.ownerId) {
            voteType = .down
        } else {
            voteType = .none
        }
    }
    
    func setVoteCounters() {
        self.stateButton.upCounter = survey.upVotes.count
        self.stateButton.downCounter = survey.downVotes.count
    }
}