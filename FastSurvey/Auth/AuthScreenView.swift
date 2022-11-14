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
    @State var authType: AuthType = .signup
    @State var isAuthed: Bool = false
    
    var body: some View {
        switch authType {
        case .signup:
            SignupView(isAuthed: $isAuthed, authType: $authType)
                .onChange(of: isAuthed) { newValue in
                    if newValue == true {
                        listener?.push(view: TabController(listener: listener))
                        isAuthed = false
                    }
                }
        case .login:
            LoginView(authType: $authType, isAuthed: $isAuthed)
                .onChange(of: isAuthed) { newValue in
                    if newValue == true {
                        listener?.push(view: TabController(listener: listener))
                        isAuthed = false
                    }
                }
        }
    }
}
