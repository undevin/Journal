//
//  EntryController.swift
//  Journal
//
//  Created by Devin Flora on 1/11/21.
//

import Foundation

class EntryController {
    
    static func createEntryWith(title: String, body: String, timestamp: Date = Date(), journal: Journal) {
        let entry = Entry(title: title, body: body)
        JournalController.shared.addEntryTo(journal: journal, entry: entry)
    }
    
    static func deleteEntry(journal: Journal, entryToDelete: Entry) {
        JournalController.shared.removeEntryFrom(journal: journal, entry: entryToDelete)
    }
    
    static func update(title: String, body: String, entry: Entry) {
        entry.title = title
        entry.body = body
        JournalController.shared.saveToPersistentStorage()
    }
}//End of Class
