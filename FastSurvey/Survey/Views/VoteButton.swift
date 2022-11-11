//
//  VoteButton.swift
//  FastSurvey
//
//  Created by Dmitry Bakulin on 02.11.2022.
//

import Foundation
import SwiftUI

struct VoteButton: View {
    
    @Binding var isVoted: Bool
    var counter: Int = 0
    var text: String = ""
    var clicked: (() -> Void)

    var body: some View {
        Button(action: clicked) {
            VStack(alignment: .center, spacing: 5) {
                Text(text)
                    .font(.headline)
                Text("\(counter)")
                    .font(.subheadline)
            }
            .padding(.vertical)
            .frame(minWidth: 0, maxWidth: .infinity)
            .frame(minHeight: 0, maxHeight: 60)
            .foregroundColor(isVoted ? .white : .blue)
            .background(isVoted ? .blue : .white)
            .overlay(RoundedRectangle(cornerRadius: 30).stroke(Color.blue, lineWidth: 3))
            .cornerRadius(30)
            .fixedSize(horizontal: false, vertical: true)
        }
    }
}
