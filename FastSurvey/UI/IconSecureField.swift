//
//  IconSecureField.swift
//  FastSurvey
//
//  Created by Dmitry Bakulin on 05.11.2022.
//

import Foundation
import SwiftUI

struct IconSecureField: View {
    
    @Binding var text: String
    var iconName: String
    var placeholder: String
    
    var body: some View {
        HStack {
            SecureField(placeholder, text: $text)
                .textFieldStyle(.plain)
            Image(systemName: iconName).foregroundColor(.blue)
        }
        .padding()
        .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.blue, lineWidth: 1))
    }
}
