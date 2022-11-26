//
//  SignupView.swift
//  FastSurvey
//
//  Created by Dmitry Bakulin on 05.11.2022.
//

import Foundation
import SwiftUI
import SwiftUINavigator

struct SignupView: View {
    
    @StateObject var viewModel: SignupViewModel = .init()
    @EnvironmentObject var router: Router
    @Binding var authType: AuthType
    
    var body: some View {
        LoadingView(isShowing: $viewModel.isLoading) {
            VStack(spacing: 16) {
                Text("Please sign up to continue")
                    .font(.headline)
                IconTextField(text: $viewModel.username, iconName: "person.fill", placeholder: "Enter your name")
                IconTextField(text: $viewModel.email, iconName: "envelope.fill", placeholder: "Enter your email")
                IconSecureField(text: $viewModel.password, iconName: "key.fill", placeholder: "Enter your password")
                
                HStack(spacing: 16) {
                    PickerButton(text: $viewModel.age.string, placeholder: "Age") {
                        self.viewModel.showBottomAge.toggle()
                    }
                    .halfSheet(showSheet: $viewModel.showBottomAge) {
                        let ages = viewModel.allAges.map { String($0) }
                        BottomPickerView(title: "Choose age", currentValue: String(viewModel.age), items: ages, saveClicked: { age in
                            self.viewModel.age = Int(age) ?? -1
                            self.viewModel.showBottomAge.toggle()
                        })
                        
                    } onEnd: {
                        print("Dismiss halfsheet")
                    }
                    
                    
                    PickerButton(text: $viewModel.gender, placeholder: "Gender") {
                        self.viewModel.showBottomGender.toggle()
                    }
                    .halfSheet(showSheet: $viewModel.showBottomGender) {
                        BottomPickerView(title: "Choose gender", currentValue: viewModel.gender, items: viewModel.allGenders, saveClicked: { gender in
                            self.viewModel.gender = gender
                            self.viewModel.showBottomGender.toggle()
                        })
                        
                    } onEnd: {
                        print("Dismiss halfsheet")
                    }
                    
                    PickerButton(text: $viewModel.country, placeholder: "Country") {
                        self.viewModel.showBottomCountry.toggle()
                    }
                    .halfSheet(showSheet: $viewModel.showBottomCountry) {
                        BottomPickerView(title: "Choose country", currentValue: viewModel.country, items: viewModel.allCountries, saveClicked: { country in
                            self.viewModel.country = country
                            self.viewModel.showBottomCountry.toggle()
                        })
                    } onEnd: {
                        print("Dismiss halfsheet")
                    }
                    
                }
                
                Text(viewModel.errorMessage)
                    .foregroundColor(.red)
                    .padding()
                
                Button {
                    viewModel.makeSignup(completion: { result in
                        DispatchQueue.main.async {
                            self.router.isAuthed = result
                        }
                    })
                } label: {
                    Text("Sign Up")
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
                    Text("Already have an a account?")
                        .font(.system(size: 12))
                    
                    Button {
                        authType = .login
                    } label: {
                        Text("Sign in")
                    }
                    .tint(.blue)
                    .font(.system(size: 12, weight: .bold))
                }.padding()
                
            }.padding()
        } //LoadingView
    }
}
