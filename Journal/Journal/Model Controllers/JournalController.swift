//
//  JournalController.swift
//  Journal
//
//  Created by Devin Flora on 1/12/21.
//

import Foundation

class JournalController {
    
    // MARK: - Shared Instance
    static let shared = JournalController()
    
    // MARK: - Source of Truth
    var journals: [Journal] = []
    
    // MARK: - Create Method
    func createJournalWith(title: String) {
        let journal = Journal(title: title)
        journals.append(journal)
        saveToPersistentStorage()
    }
    
    // MARK: - Delete Method
    func deleteJournal(journalToDelete: Journal) {
        guard let index = journals.firstIndex(of: journalToDelete) else { return }
        journals.remove(at: index)
        saveToPersistentStorage()
    }
    
    func addEntryTo(journal: Journal, entry: Entry) {
        journal.entries.append(entry)
        saveToPersistentStorage()
    }
    
    func removeEntryFrom(journal: Journal, entry: Entry) {
        guard let index = journal.entries.firstIndex(of: entry) else { return }
        journal.entries.remove(at: index)
        saveToPersistentStorage()
    }
    
    // MARK: - Persistence
    private func fileURL() -> URL {
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentsDirectoryURL = urls[0].appendingPathComponent("Journal.json")
        return documentsDirectoryURL
    }
    
    func saveToPersistentStorage() {
        do {
            let data = try JSONEncoder().encode(journals)
            try data.write(to: fileURL())
        } catch {
            print(error)
            print(error.localizedDescription)
        }
    }
    
    func loadFromPersistentStorage() {
        do {
            let data = try Data(contentsOf: fileURL())
            journals = try JSONDecoder().decode([Journal].self, from: data)
        } catch {
            print(error)
            print(error.localizedDescription)
        }
    }
}
