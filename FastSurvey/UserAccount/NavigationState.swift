//
//  Router.swift
//  FastSurvey
//
//  Created by Dmitry Bakulin on 21.11.2022.
//

import Foundation

class NavigationState : ObservableObject {
    @Published var tabSelection: Int = 0
    @Published var isAuthed = false
    @Published var isCheckingLogin = false
}
