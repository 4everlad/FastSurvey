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
                    .foregroundColor(.red)
                    .padding()
                
                Button {
                    viewModel.makeLogin(completion: { result in
                        DispatchQueue.main.async {
                            self.isAuthed = result
                        }
                    })
                } label: {
                    Text("Sign In")
                        .font(.title2)
                        .frame(maxWidth: .infinity)
                        .frame(minHeight: 50, maxHeight: 50)
                }
                .padding(.vertical)
                .frame(minWidth: 0, maxWidth: .infinity)
                .frame(minHeight: 50, maxHeight: 50)
                .buttonStyle(.borderedProminent)
                
                Spacer()
                
                VStack {
                    Text("Don't have an account?")
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
