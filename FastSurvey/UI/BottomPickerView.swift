//
//  BottomPickerView.swift
//  FastSurvey
//
//  Created by Dmitry Bakulin on 05.11.2022.
//

import Foundation
import SwiftUI

struct BottomPickerView: View {
    
    @State var pickerChoise: String
    var title: String
    var items: [String]
    var saveClicked: ((String) -> ())
    
    init(title: String, currentValue: String, items: [String], saveClicked: @escaping ((String) -> ())) {
        self.saveClicked = saveClicked
        self.title = title
        self.items = items
        
        self.pickerChoise = items.first { $0 == currentValue } ?? items.first ?? ""
    }
    
    var body: some View {
        VStack {
            Text(title)
                .font(.headline)
            
            Picker("Items", selection: $pickerChoise) {
                ForEach(items, id:\.self) { item in
                    Text(item)
                        .tag(item)
                }
            }.pickerStyle(WheelPickerStyle())
            
            
            Button {
                saveClicked(pickerChoise)
            } label: {
                Text("Save")
            }
            .buttonStyle(.bordered)
            .buttonBorderShape(.capsule)
            .tint(.blue)
            .font(.title2)
        }
    }
}
