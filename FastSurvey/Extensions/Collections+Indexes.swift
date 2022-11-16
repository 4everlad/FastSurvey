//
//  Collections+Indexes.swift
//  FastSurvey
//
//  Created by Dmitry Bakulin on 10.11.2022.
//

import Foundation

extension RandomAccessCollection where Self.Element: Identifiable {
    func isLast<Item: Identifiable>(_ elem: Item) -> Bool {
        guard isEmpty == false else { return false }
        guard let itemIndex = firstIndex(where: { AnyHashable($0.id) == AnyHashable(elem.id) }) else {
            return false
        }
        let distance = self.distance(from: itemIndex, to: endIndex)

        return distance == 1
    }
}

extension Collection {
    subscript (safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
