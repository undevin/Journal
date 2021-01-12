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
    
    private func fileURL() -> URL {
     let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
     let documentsDirectoryURL = urls[0].appendingPathComponent("Journal.json")
     return documentsDirectoryURL
    }
    
    func saveToPersistentStorage() {
        do {
            let data = try JSONEncoder().encode(entries)
            try data.write(to: fileURL())
        } catch {
            print(error)
            print(error.localizedDescription)
        }
    }
    
    func loadFromPersistentStorage() {
        do {
            let data = try Data(contentsOf: fileURL())
            entries = try JSONDecoder().decode([Entry].self, from: data)
        } catch {
            print(error)
            print(error.localizedDescription)
        }
    }
}//End of Class
