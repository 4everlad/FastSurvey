//
//  VoteView.swift
//  FastSurvey
//
//  Created by Dmitry Bakulin on 02.11.2022.
//

import Foundation
import SwiftUI

struct VoteView: View {
    
    var viewModel: SurveyViewModel
    
    var body: some View {
        HStack(spacing: 64) {
            VoteButton (
                isVoted: viewModel.stateButton.isUp,
                counter: viewModel.stateButton.upCounter,
                text: "YES"
            ) {
                viewModel.makeVote(vote: .up)
            }
            
            VoteButton (
                isVoted: viewModel.stateButton.isDown,
                counter: viewModel.stateButton.downCounter,
                text: "NO"
            ) {
                viewModel.makeVote(vote: .up)
            }
        }
    }
}



