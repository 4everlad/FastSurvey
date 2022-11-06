//
//  LoginView.swift
//  FastSurvey
//
//  Created by Dmitry Bakulin on 05.11.2022.
//

import SwiftUI

struct LoginView: View {
    
    @Binding var authType: AuthType
    @StateObject var viewModel: SignupViewModel = .init()
    
    var body: some View {
        VStack(spacing: 16) {
            Text("Please login in to continue")
                .font(.headline)
            IconTextField(text: $viewModel.email, iconName: "envelope.fill", placeholder: "Enter your email")
            IconSecureField(text: $viewModel.password, iconName: "key.fill", placeholder: "Enter your password")
            
            Button {
                authType = .signup
            } label: {
                Text("Signup")
            }
            .buttonStyle(.bordered)
            .buttonBorderShape(.capsule)
            .tint(.blue)
            
        }.padding()
        
    }
}

//struct LoginView_Previews: PreviewProvider {
//    static var previews: some View {
//        LoginView()
//    }
//}
