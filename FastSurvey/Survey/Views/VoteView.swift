//
//  VoteView.swift
//  FastSurvey
//
//  Created by Dmitry Bakulin on 02.11.2022.
//

import Foundation
import SwiftUI

struct VoteView: View {
    
    @Binding var survey: Survey
    @Binding var isUp: Bool
    @Binding var isDown: Bool
    
    var body: some View {
        HStack(spacing: 64) {
            VoteButton (
                isVoted: $isUp,
                counter: survey.upVotes.count,
                text: "YES"
            ) {
                self.isUp.toggle()
                if isUp == isDown {
                    self.isDown.toggle()
                }
            }
            
            VoteButton (
                isVoted: $isDown,
                counter: survey.downVotes.count,
                text: "NO"
            ) {
                self.isDown.toggle()
                if isUp == isDown {
                    self.isUp.toggle()
                }
            }
        }
    }
}



