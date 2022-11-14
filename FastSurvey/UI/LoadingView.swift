//
//  LoadingView.swift
//  FastSurvey
//
//  Created by Dmitry Bakulin on 13.11.2022.
//

import Foundation
import SwiftUI

struct LoadingView<Content>: View where Content: View {

    @Binding var isShowing: Bool
    var content: () -> Content
    var text: String?

    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .center) {
                content()
                    .disabled(isShowing)
                    .blur(radius: isShowing ? 2 : 0)
                    
                if isShowing {
                    Rectangle()
                        .fill(Color.black).opacity(isShowing ? 0.6 : 0)
                        .edgesIgnoringSafeArea(.all)

                    VStack(spacing: 16) {
                        ProgressView().scaleEffect(1.5, anchor: .center).tint(.blue)
                            
                        Text(text ?? "Please Wait...")
                            .font(.headline)
                            .fontWeight(.semibold)
                    }
                    .frame(width: geometry.size.width / 2,
                                           height: geometry.size.height / 5)
                    .background(Color.white)
                    .foregroundColor(Color.primary)
                    .cornerRadius(16)
                }
            }
        }
    }
}
