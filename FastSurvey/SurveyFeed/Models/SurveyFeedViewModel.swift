//
//  SurveyFeedViewModel.swift
//  FastSurvey
//
//  Created by Dmitry Bakulin on 31.10.2022.
//

import Foundation
import SwiftUI

class SurveyFeedViewModel: ObservableObject {
    @Published var surveys: [Survey] = []
    
    private let accountManager = AccountManager.shared
    private let networkClient = NetworkClient()
    
    var canLoad = true
    var currentSurveysCount: Int = 0
    
    func getSurveys() {
        
        guard canLoad == true else { return }
        guard currentSurveysCount == self.surveys.count else { return } 
        
        guard let token = accountManager.token else {
            return
        }
        
        var startAfterId: String?
        if let survey = surveys.last {
            startAfterId = survey.sid
        }
        
        canLoad = false
        
        networkClient.getSurveyFeed(token: token, count: 10, startAfter: startAfterId, completion: { [weak self] (feed, error) in
            if let surveys = feed {
                let surveyFeed: [Survey] = surveys.compactMap {
                    let survey = Survey(with: $0)
                    return survey
                }
                DispatchQueue.main.async {
                    if !surveyFeed.isEmpty {
                        self?.surveys.append(contentsOf: surveyFeed)
                        self?.currentSurveysCount += surveyFeed.count
                    }
                }
            } else if let error = error {
                print(error.localizedDescription)
            }
            
            DispatchQueue.main.async {
                self?.canLoad = true
            }
        })
    }
    
}
