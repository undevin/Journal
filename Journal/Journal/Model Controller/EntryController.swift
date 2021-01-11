//
//  EntryController.swift
//  Journal
//
//  Created by Devin Flora on 1/11/21.
//

import Foundation

class EntryController {
    
    static let shared = EntryController()
    
    var entries: [Entry] = []
    
    func createEntryWith(title: String, body: String, timestamp: Date) {
        let entry = Entry(title: title, body: body, timestamp: Date())
        entries.append(entry)
        
    }
    
    func deleteEntry(entryToDelete: Entry) {
        guard let index = entries.firstIndex(of: entryToDelete) else { return }
        entries.remove(at: index)
    }
}
