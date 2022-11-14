//
//  LoginView.swift
//  FastSurvey
//
//  Created by Dmitry Bakulin on 05.11.2022.
//

import SwiftUI

struct LoginView: View {
    
    @Binding var authType: AuthType
    @Binding var isAuthed: Bool
    @StateObject var viewModel: LoginViewModel = .init()
    
    var body: some View {
        LoadingView(isShowing: $viewModel.isLoading) {
            VStack(spacing: 16) {
                Text("Please log in to continue")
                    .font(.headline)
                IconTextField(text: $viewModel.email, iconName: "envelope.fill", placeholder: "Enter your email")
                IconSecureField(text: $viewModel.password, iconName: "key.fill", placeholder: "Enter your password")
                
                Text(viewModel.errorMessage)
                
                Button {
                    viewModel.makeLogin(completion: {
                        self.isAuthed = true
                    })
                } label: {
                    if !viewModel.isLoading {
                        Text("Sign Up")
                    } else {
                        ProgressView()
                            .tint(.white)
                            .scaleEffect(1.5, anchor: .center)
                    }
                }
                .padding(.vertical)
                .frame(minWidth: 0, maxWidth: .infinity)
                .frame(minHeight: 0, maxHeight: 60)
                .buttonStyle(.borderedProminent)
                .buttonBorderShape(.capsule)
                
                Spacer()
                
                VStack {
                    Text("Already have an a account?")
                        .font(.system(size: 12))
                    
                    Button {
                        authType = .signup
                    } label: {
                        Text("Sign up")
                    }
                    .tint(.blue)
                    .font(.system(size: 12, weight: .bold))
                    
                }.padding()
            }.padding()
        } // LoadingView
    }
}

//struct LoginView_Previews: PreviewProvider {
//    static var previews: some View {
//        LoginView()
//    }
//}
