//
//  UserAccountScreenView.swift
//  FastSurvey
//
//  Created by Dmitry Bakulin on 14.11.2022.
//

import SwiftUI
import SwiftUINavigator
import Introspect

struct UserAccountScreenView: View, IItemView {
    
    var listener: INavigationContainer?
    @EnvironmentObject var viewModel: UserAccountViewModel
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    Section {
                        VStack {
                            HStack{
                                Text("Name")
                                    .font(.subheadline)
                                Spacer()
                                Text(viewModel.user.name)
                                    .font(.subheadline)
                                    .fontWeight(.semibold)
                                    .foregroundColor(.blue)
                            }
                            .padding(8)
                            Divider()
                                .overlay(.blue)
                            
                            HStack {
                                Text("Email")
                                    .font(.subheadline)
                                Spacer()
                                Text(viewModel.user.email)
                                    .font(.subheadline)
                                    .fontWeight(.semibold)
                                    .foregroundColor(.blue)
                            }
                            .padding(8)
                            Divider()
                                .overlay(.blue)
                            
                            HStack {
                                Text("Age")
                                    .font(.subheadline)
                                Spacer()
                                Text(viewModel.user.age)
                                    .font(.subheadline)
                                    .fontWeight(.semibold)
                                    .foregroundColor(.blue)
                            }
                            .padding(8)
                            Divider()
                                .overlay(.blue)
                            
                            HStack {
                                Text("Gender")
                                    .font(.subheadline)
                                Spacer()
                                Text(viewModel.user.sex)
                                    .font(.subheadline)
                                    .fontWeight(.semibold)
                                    .foregroundColor(.blue)
                            }
                            .padding(8)
                            Divider()
                                .overlay(.blue)
                            
                            HStack {
                                Text("Country")
                                    .font(.subheadline)
                                Spacer()
                                Text(viewModel.user.countryCode)
                                    .font(.subheadline)
                                    .fontWeight(.semibold)
                                    .foregroundColor(.blue)
                            }
                            .padding(8)
                        }
                        .background(.blue.opacity(0.1))
                        .overlay(RoundedRectangle(cornerRadius: 10, style: .circular).stroke(.blue.opacity(0.1)))
                        .listRowSeparator(.hidden)
                    }
                    
                }
                .listStyle(InsetListStyle())
                .onAppear {
                    UITableView.appearance().backgroundColor = .clear
                }
            }
            .navigationBarItems(trailing:
                                    Button(action: {
                listener?.popToRoot()
                viewModel.logOut()
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
