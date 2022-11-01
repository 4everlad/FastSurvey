//
//  SurveyFeedListView.swift
//  FastSurvey
//
//  Created by Dmitry Bakulin on 31.10.2022.
//

import Foundation
import SwiftUI
import SwiftUINavigator

//struct MaxWidthPreferenceKey: PreferenceKey {
//    static var defaultValue: CGFloat = .zero
//    
//    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
//        let nextValue = nextValue()
//        
//        guard nextValue > value else { return }
//        
//        value = nextValue
//    }
//}
//
//struct ItemGeometry: View {
//    var body: some View {
//        GeometryReader { geometry in
//            Color.clear
//                .preference(key: MaxWidthPreferenceKey.self, value: geometry.size.width)
//        }
//        .scaledToFill()
//    }
//}

struct SurveysListView: View, IItemView {
    var listener: INavigationContainer?
    
    @EnvironmentObject var viewModel: SurveyFeedViewModel
    
    var body: some View {
        List {
            VStack {
                ForEach(viewModel.surveys) { item in
                    SurveyCellView(survey: item)
                        .listRowSeparator(.hidden)
                }
            }
        }
        .listStyle(.plain)
    }
}
