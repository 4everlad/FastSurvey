//
//  AuthScreenView.swift
//  FastSurvey
//
//  Created by Dmitry Bakulin on 05.11.2022.
//

import Foundation
import SwiftUI
import SwiftUINavigator

enum AuthType {
    case signup
    case login
}

struct AuthScreenView: View, IItemView {
    
    var listener: INavigationContainer?
    @EnvironmentObject var router: Router
    @State var authType: AuthType = .login
    
    func pushToSurveys(isAuthed: Bool) {
        if isAuthed {
            listener?.push(view: TabController(listener: listener))
        }
    }
    
    var body: some View {
        switch authType {
        case .signup:
            LoadingView(isShowing: $router.isCheckingLogin) {
                SignupView(authType: $authType)
                    .onChange(of: router.isAuthed) { newValue in
                        pushToSurveys(isAuthed: newValue)
                    }
            }
        case .login:
            LoadingView(isShowing: $router.isCheckingLogin) {
                LoginView(authType: $authType)
                    .onChange(of: router.isAuthed) { newValue in
                        pushToSurveys(isAuthed: newValue)
                    }
            }
        }
    }
}
