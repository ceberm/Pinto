//
//  Array+Identifiable.swift
//  TopinApp
//
//  Created by Cesar on 26/6/21.
//

import Foundation

extension Array where Element: Identifiable {
    func firstIndex(matching: Element) -> Int? {
        for index in 0..<self.count {
            if self[index].id == matching.id {
                return index
            }
        }
        return nil
    }
    
    /// Removes Elements at a random position
    mutating func randomDrop() -> Element {
        return self.remove(at: self.firstIndex(matching:  self.randomElement()!)!)
    }
}
