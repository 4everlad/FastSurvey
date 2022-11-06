//
//  LoginViewModel.swift
//  FastSurvey
//
//  Created by Dmitry Bakulin on 06.11.2022.
//

import Foundation

final class LoginViewModel: ObservableObject {
    
    @Published var username: String = ""
    @Published var email: String = ""
    
}
