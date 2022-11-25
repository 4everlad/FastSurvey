//
//  UserAccountScreenView.swift
//  FastSurvey
//
//  Created by Dmitry Bakulin on 14.11.2022.
//

import SwiftUI
import SwiftUINavigator

struct UserAccountScreenView: View, IItemView {
    
    var listener: INavigationContainer?
    @EnvironmentObject var viewModel: UserAccountViewModel
    
    var body: some View {
        NavigationView {
            VStack {
                Form {
                    HStack {
                        Text("Name")
                        Spacer()
                        Text(viewModel.user.name)
                    }
                    
                    HStack {
                        Text("Email")
                        Spacer()
                        Text(viewModel.user.email)
                    }
                    
                    HStack {
                        Text("Age")
                        Spacer()
                        Text(viewModel.user.age)
                    }
                    
                    HStack {
                        Text("Gender")
                        Spacer()
                        Text(viewModel.user.sex)
                    }
                    
                    HStack {
                        Text("Country")
                        Spacer()
                        Text(viewModel.user.countryCode)
                    }
                }
            }
            .navigationBarItems(trailing:
                                    Button(action: {
                listener?.popToRoot()
            }, label: {
                Image(systemName: "rectangle.portrait.and.arrow.right")
            })
            )
            .navigationTitle(Text("Profile"))
            .navigationBarTitleDisplayMode(.inline)
        }
        .onAppear {
            viewModel.getUser()
        }
        
    }
}

//struct UserAccountScreenView_Previews: PreviewProvider {
//    static var previews: some View {
//        UserAccountScreenView()
//    }
//}
