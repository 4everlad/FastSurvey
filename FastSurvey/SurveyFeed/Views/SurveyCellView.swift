//
//  SurveyCell.swift
//  FastSurvey
//
//  Created by Dmitry Bakulin on 01.11.2022.
//

import Foundation
import SwiftUI

struct SurveyCellView: View {
    
    let survey: Survey
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(survey.title)
                    .font(.headline)
                Spacer()
                
                Text(survey.description)
                    .font(.subheadline)
                Spacer()
                
                Text("Upvoted: \(survey.upVotes)")
                    .font(.system(size: 12, design: .rounded))
                Text("Downvoted: \(survey.downVotes)")
                    .font(.system(size: 12, design: .rounded))
            }
            
            EmptyView()
        }
        .padding(16)
        .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.blue, lineWidth: 1))
        
    }
}

//struct NewsCellView_Previews: PreviewProvider {
//    static var previews: some View {
//        NewsCellView(name: "Fuck")
//    }
//}
