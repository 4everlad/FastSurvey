//
//  SurveyScreenView.swift
//  FastSurvey
//
//  Created by Dmitry Bakulin on 02.11.2022.
//

import Foundation
import SwiftUI
import SwiftUINavigator

struct SurveyScreenView: View, IItemView {
    
    var listener: INavigationContainer?
    var survey: Survey
    @State var isUp = false
    @State var isDown = false
    
    @State var widthButton: CGFloat = 100
    @State var heightButton: CGFloat = 50
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 32) {
                Text(survey.title)
                    .font(.title)
                Text(survey.description)
                
                HStack(alignment: .center, spacing: 64) {
                    VoteButton (
                        isVoted: $isUp,
                        counter: survey.upVotes,
                        text: "YES"
                    ) {
                        self.isUp.toggle()
                        if isUp == isDown {
                            self.isDown.toggle()
                        }
                    }
                    .frame(maxHeight: .infinity)
                    
                    VoteButton (
                        isVoted: $isDown,
                        counter: survey.downVotes,
                        text: "NO"
                    ) {
                        self.isDown.toggle()
                        if isUp == isDown {
                            self.isUp.toggle()
                        }
                    }
                    .frame(maxHeight: .infinity)
                    
                }
                .fixedSize(horizontal: false, vertical: true)
                .frame(maxHeight: 100)
                
                Spacer()
            }
            .navigationBarItems(leading:
                Button(action: {
                    listener?.pop()
                }, label: {
                    Text("Feed")
                })
            )
            .navigationBarTitle(Text("Survey"))
            .navigationBarTitleDisplayMode(.inline)
            .padding()
        }
    }
}

//struct SurveyScreenView_Previews: PreviewProvider {
//    static var previews: some View {
//        SurveyScreenView()
//    }
//}
