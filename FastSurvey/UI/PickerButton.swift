//
//  PickerButton.swift
//  FastSurvey
//
//  Created by Dmitry Bakulin on 05.11.2022.
//

import Foundation
import SwiftUI

struct PickerButton: View {
    
    @Binding var text: String
    var placeholder: String
    var clicked: (() -> Void)
    
    var body: some View {
        Button(action: clicked) {
            VStack(alignment: .leading) {
                HStack {
                    Text(placeholder)
                        .bold()
                        .font(.system(size: 13, design: .rounded))
                    
                    Image(systemName: "chevron.down")
                        .font(.system(size: 10, weight: .bold))
                    
                }
                
                Text(text)
                    .font(.headline)
            }
        }
        .buttonStyle(.bordered)
    }
}
