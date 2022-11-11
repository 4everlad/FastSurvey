//
//  Binding+Extension.swift
//  FastSurvey
//
//  Created by Dmitry Bakulin on 11.11.2022.
//

import Foundation
import SwiftUI

extension Binding {
    func optionalBinding<T>(defaultValue: T) -> Binding<T> where Value == Optional<T> {
        Binding<T>(get: { self.wrappedValue ?? defaultValue }, set: { self.wrappedValue = $0 })
    }
}
