//
//  VoteSurveyViewModel.swift
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

class VoteSurveyViewModel: ObservableObject {
    
    let accountManager = AccountManager.shared
    @Published var survey: Survey = Survey() {
        didSet {
            setVoteType()
            setVoteCounters()
        }
    }
    
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
            return
        }
        
        isLoading = true
        
        NetworkClient().getSurvey(token: token, id: id, completion: { [weak self] (survey, error) in
            
            if let json = survey {
                DispatchQueue.main.async {
                    self?.survey = Survey(with: json)
                }
            } else if let error = error {
                print(error.localizedDescription)
            }
            
            DispatchQueue.main.async {
                self?.isLoading = false
            }
        })
        
    }
    
    func makeVote(vote: VoteType) {
        guard let token = accountManager.token else {
            return
        }
        
        guard survey.id != "-1" else { return }
        
        let params = VoteParams(surveyId: survey.id, vote: vote.rawValue)
        
        isLoading = true
        
        NetworkClient().makeVote(token: token, params: params, completion: { [weak self] (survey, error) in
            
            if let json = survey {
                DispatchQueue.main.async {
                    self?.survey = Survey(with: json)
                }
            } else if let error = error {
                print(error.localizedDescription)
            }
            
            DispatchQueue.main.async {
                self?.isLoading = false
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
        print("setVoteCounters: \(self.stateButton.upCounter)")
        self.stateButton.downCounter = survey.downVotes.count
    }
}
