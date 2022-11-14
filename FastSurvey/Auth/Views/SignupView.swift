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
    @Binding var isAuthed: Bool
    @Binding var authType: AuthType
    
    @State private var showingBottomAge = false
    @State private var showingBottomGender = false
    @State private var showingBottomCountry = false
    
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
                        showingBottomAge.toggle()
                    }
                    .halfSheet(showSheet: $showingBottomAge) {
                        let ages = viewModel.allAges.map { String($0) }
                        BottomPickerView(title: "Choose age", currentValue: String(viewModel.age), items: ages, saveClicked: { age in
                            self.viewModel.age = Int(age) ?? -1
                            showingBottomAge.toggle()
                        })
                        
                    } onEnd: {
                        print("Dismiss")
                    }
                    
                    
                    PickerButton(text: $viewModel.gender, placeholder: "Gender", clicked: {
                        showingBottomGender.toggle()
                    })
                        .halfSheet(showSheet: $showingBottomGender) {
                            BottomPickerView(title: "Choose gender", currentValue: viewModel.gender, items: viewModel.allGenders, saveClicked: { gender in
                                self.viewModel.gender = gender
                                showingBottomGender.toggle()
                            })
                            
                        } onEnd: {
                            print("Dismiss")
                        }
                    
                    PickerButton(text: $viewModel.country, placeholder: "Country", clicked: {
                        showingBottomCountry.toggle()
                    })
                        .halfSheet(showSheet: $showingBottomCountry) {
                            BottomPickerView(title: "Choose country", currentValue: viewModel.country, items: viewModel.allCountries, saveClicked: { country in
                                self.viewModel.country = country
                                showingBottomCountry.toggle()
                            })
                        } onEnd: {
                            print("Dismiss")
                        }
                    
                }
                
                Text(viewModel.errorMessage)
                
                Button {
                    viewModel.makeSignup(completion: {
                        self.isAuthed = true
                    })
                } label: {
                    Text("Sign In")
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
