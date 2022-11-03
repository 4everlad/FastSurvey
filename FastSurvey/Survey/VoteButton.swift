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
        if isVoted {
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
                .foregroundColor(.white)
                .background(.blue)
                .cornerRadius(8)
                .fixedSize(horizontal: false, vertical: true)
            }

        } else {
            Button(action: clicked)  {
                VStack(alignment: .center, spacing: 5) {
                    Text(text)
                        .font(.headline)
                    Text("\(counter)")
                        .font(.subheadline)
                }
                .padding(.vertical)
                .frame(minWidth: 0, maxWidth: .infinity)
                .frame(minHeight: 0, maxHeight: 60)
                .foregroundColor(.blue)
                .background(.white)
                .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.blue, lineWidth: 2))
                .fixedSize(horizontal: false, vertical: true)
            }
        }
    }
}
