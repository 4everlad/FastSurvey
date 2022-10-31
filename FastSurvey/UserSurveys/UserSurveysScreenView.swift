//
//  UserSurveyScreenView.swift
//  FastSurvey
//
//  Created by Dmitry Bakulin on 31.10.2022.
//

import SwiftUI
import SwiftUINavigator

struct UserSurveysScreenView: View, IItemView {
    var listener: INavigationContainer?
    
    var body: some View {
        Text("UserSurveyScreenView")
    }
}

struct UserSurveyScreenView_Previews: PreviewProvider {
    static var previews: some View {
        UserSurveysScreenView()
    }
}
