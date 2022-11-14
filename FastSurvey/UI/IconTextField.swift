//
//  IconTextField.swift
//  FastSurvey
//
//  Created by Dmitry Bakulin on 05.11.2022.
//

import Foundation
import SwiftUI

struct IconTextField: View {
    
    @Binding var text: String
    var iconName: String
    var placeholder: String
    
    var body: some View {
        HStack {
            TextField(placeholder, text: $text)
                .textFieldStyle(.plain)
                .disableAutocorrection(true)
                .autocapitalization(.none)
            Image(systemName: iconName).foregroundColor(.blue)
        }
        .padding()
        .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.blue, lineWidth: 1))
    }
}
