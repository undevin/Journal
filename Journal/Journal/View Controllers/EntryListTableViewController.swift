//
//  EntryListTableViewController.swift
//  Journal
//
//  Created by Devin Flora on 1/11/21.
//

import UIKit

class EntryListTableViewController: UITableViewController {
    
    
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    // MARK: - Properties
    var journal: Journal?
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return journal?.entries.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "entryCell", for: indexPath)
        
        guard let entry = journal?.entries[indexPath.row] else { return UITableViewCell() }
        
        cell.textLabel?.text = entry.title
        
        //        if let formatter = DateFormatter() {
        //        formatter.dateFormat = "MMM d, yyyy"
        //        cell.detailTextLabel?.text = formatter.string(from: journal?.entries[indexPath.row])
        //        cell.detailTextLabel?.text = formatter.string(from: journal?.entries[indexPath.row].timestamp)
        //        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            guard let entryToDelete = journal?.entries[indexPath.row],
                  let journal = journal else { return }
            EntryController.deleteEntry(journal: journal, entryToDelete: entryToDelete)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let journal = journal,
              let destination = segue.destination as? EntryDetailViewController else { return }
        
        if segue.identifier == "toEntryDetails" {
            guard let indexPath = tableView.indexPathForSelectedRow else { return }
                  
            let entryToSend = journal.entries[indexPath.row]
            destination.journal = journal
            destination.entry = entryToSend
        } else if segue.identifier == "toNewEntry" {
            destination.journal = journal
        }
    }
}
