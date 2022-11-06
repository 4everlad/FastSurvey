//
//  AuthScreenView.swift
//  FastSurvey
//
//  Created by Dmitry Bakulin on 05.11.2022.
//

import Foundation
import SwiftUI

enum AuthType {
    case signup
    case login
}

struct AuthScreenView: View {
    
    @State var authType: AuthType = .signup
    
    var body: some View {
        switch authType {
        case .signup:
            SignupView(authType: $authType)
        case .login:
            LoginView(authType: $authType)
        }
    }
}
