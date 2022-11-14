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
    
    var body: some View {
        NavigationView {
            VStack {
                Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
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
        
    }
}

struct UserAccountScreenView_Previews: PreviewProvider {
    static var previews: some View {
        UserAccountScreenView()
    }
}
