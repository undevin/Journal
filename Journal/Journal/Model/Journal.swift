//
//  Journal.swift
//  Journal
//
//  Created by Cameron Stuart on 12/30/20.
//

import Foundation

class Journal: Codable {
    let title: String
    var entries: [Entry]
    
    init(title: String, entries: [Entry] = []) {
        self.title = title
        self.entries = entries
    }
}

extension Journal: Equatable {
    static func == (lhs: Journal, rhs: Journal) -> Bool {
        return lhs.title == rhs.title && lhs.entries == rhs.entries
    }
}
