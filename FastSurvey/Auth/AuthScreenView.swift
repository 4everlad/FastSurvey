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
    case none
}

struct AuthScreenView: View, IItemView {
    
    var listener: INavigationContainer?
    @EnvironmentObject var router: Router
    @State var authType: AuthType = .login
    
    init() {
        if AccountManager.shared.router.isAuthed == true {
            authType = .none
            listener?.push(view: TabController(listener: listener))
        }
    }
    
    func pushToSurveys(isAuthed: Bool) {
        if isAuthed {
            listener?.push(view: TabController(listener: listener))
        }
    }
    
    var body: some View {
        switch authType {
        case .signup:
            SignupView(isAuthed: $router.isAuthed, authType: $authType)
                .onChange(of: router.isAuthed) { newValue in
                    pushToSurveys(isAuthed: newValue)
                }
        case .login:
            LoginView(authType: $authType, isAuthed: $router.isAuthed)
                .onChange(of: router.isAuthed) { newValue in
                    pushToSurveys(isAuthed: newValue)
                }
        case .none:
            EmptyView()
        }
    }
}
