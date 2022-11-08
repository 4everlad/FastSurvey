//
//  View+Loading.swift
//  FastSurvey
//
//  Created by Dmitry Bakulin on 08.11.2022.
//

import Foundation
import SwiftUI

extension View {
    func progressBar(isLoading: Bool) -> some View {
        self
            .modifier(LoadingProgressView(withLoading: isLoading))
    }
}
