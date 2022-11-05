//
//  SignupView.swift
//  FastSurvey
//
//  Created by Dmitry Bakulin on 05.11.2022.
//

import Foundation
import SwiftUI

enum Gender: String, CaseIterable {
    case male = "Male"
    case female = "Female"
}

struct SignupView: View {
    
    @State private var username: String = ""
    @State var email: String = ""
    @State var password: String = ""
    @State var birthDate: Date = Date()
    @State var age: Int = 18
    var allAges: [Int] = Array<Int>(18...99)
    @State var gender: String = "Female"
    var allGenders: [String] = Gender.allCases.map { $0.rawValue }
    @State var country: String = "ru"
    var allCountries = ["ru", "en", "us"]
    
    @State private var showingBottomAge = false
    @State private var showingBottomGender = false
    @State private var showingBottomCountry = false
    
    var body: some View {
        VStack(spacing: 16) {
            Text("Please sign up to continue")
                .font(.headline)
            IconTextField(text: $username, iconName: "person.fill", placeholder: "Enter your name")
            IconTextField(text: $username, iconName: "envelope.fill", placeholder: "Enter your email")
            IconSecureField(text: $username, iconName: "key.fill", placeholder: "Enter your password")
            
            HStack(spacing: 16) {
                PickerButton(text: $age.string, placeholder: "Age") {
                    showingBottomAge.toggle()
                }
                .halfSheet(showSheet: $showingBottomAge) {
                    let ages = allAges.map { String($0) }
                    BottomPickerView(title: "Choose age", currentValue: String(age), items: ages, saveClicked: { age in
                        self.age = Int(age) ?? -1
                        showingBottomAge.toggle()
                    })
                    
                } onEnd: {
                    print("Dismiss")
                }
                
                
                PickerButton(text: $gender, placeholder: "Gender", clicked: {
                    showingBottomGender.toggle()
                })
                .halfSheet(showSheet: $showingBottomGender) {
                    BottomPickerView(title: "Choose gender", currentValue: gender, items: allGenders, saveClicked: { gender in
                        self.gender = gender
                        showingBottomGender.toggle()
                    })

                } onEnd: {
                    print("Dismiss")
                }
                
                PickerButton(text: $country, placeholder: "Country", clicked: {
                    showingBottomCountry.toggle()
                })
                .halfSheet(showSheet: $showingBottomCountry) {
                    BottomPickerView(title: "Choose country", currentValue: country, items: allCountries, saveClicked: { country in
                        self.country = country
                        showingBottomCountry.toggle()
                    })
                } onEnd: {
                    print("Dismiss")
                }
                
            }
            
           
        }.padding()
    }
}
