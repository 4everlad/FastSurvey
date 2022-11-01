//
//  SurveyFeedViewModel.swift
//  FastSurvey
//
//  Created by Dmitry Bakulin on 31.10.2022.
//

import Foundation

class SurveyFeedViewModel: ObservableObject {
    @Published var surveys: [Survey] = [
        Survey(title: "How does society sees you as a soldier?", description: "At one point, I was leaving Army basic to go back home. I had purchased a pack of darts (like for a dart board) during my time there, and had them in my luggage.", upVotes: 3, downVotes: 4),
        Survey(title: "How does society sees you as a soldier?", description: "At one point, I was leaving Army basic to go back home. I had purchased a pack of darts (like for a dart board) during my time there, and had them in my luggage.", upVotes: 3, downVotes: 4),
        Survey(title: "Is Putin admired and respected in Eastern European countries like Poland, Czechia, etc.??", description: "Dear author, once again, both mentioned countries are Central European.I know that Russian propaganda likes to claim a lot of nonsense. But Putin is a joke to most people here, and at the same time the vast majority of people consider him a criminal and kleptocratic crazy man.", upVotes: 3, downVotes: 100),
        Survey(title: "What do Greeks think of Turks?", description: "Oh that's a good question. I'm coming from a quite progressive family. My father always told me “don't listen to the media” when it was about Turkey", upVotes: 50, downVotes: 50),
        Survey(title: "What makes you think how technologically backward your country is?", description: "It is not even a new technology just installed. It is already an old technology that people had for many years. This was invented before 'smart phones' and other smart electronic devices. It is already a relic technology.", upVotes: 25, downVotes: 15)
        
    ]
    
}
