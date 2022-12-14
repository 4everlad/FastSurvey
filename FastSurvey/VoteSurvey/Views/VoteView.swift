//
//  VoteView.swift
//  FastSurvey
//
//  Created by Dmitry Bakulin on 02.11.2022.
//

import Foundation
import SwiftUI

struct VoteView: View {
    
    @ObservedObject var viewModel: VoteSurveyViewModel
    
    var body: some View {
        HStack(spacing: 64) {
            VoteButton (
                isVoted: $viewModel.stateButton.isUp,
                counter: $viewModel.stateButton.upCounter,
                imageName: "hand.thumbsup.fill"
            ) {
                viewModel.makeVote(vote: .up)
            }
            
            VoteButton (
                isVoted: $viewModel.stateButton.isDown,
                counter: $viewModel.stateButton.downCounter,
                imageName: "hand.thumbsdown.fill"
            ) {
                viewModel.makeVote(vote: .down)
            }
        }
    }
}



