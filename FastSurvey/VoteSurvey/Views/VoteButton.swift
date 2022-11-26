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
    @Binding var counter: Int
    var imageName: String
    var clicked: (() -> Void)

    var body: some View {
        Button(action: clicked) {
            HStack(alignment: .center, spacing: 16) {
                Image(systemName: imageName)
                    .resizable()
                    .frame(width: 25.0, height: 25.0)
                Text("\(counter)")
                    .font(.headline)
            }
            .padding(.vertical)
            .frame(minWidth: 0, maxWidth: .infinity)
            .frame(minHeight: 0, maxHeight: 60)
            .foregroundColor(isVoted ? .blue : .white)
            .background(isVoted ? .white : .blue)
            .overlay(RoundedRectangle(cornerRadius: 30).stroke(Color.blue, lineWidth: 3))
            .cornerRadius(30)
            .fixedSize(horizontal: false, vertical: true)
        }
    }
}
