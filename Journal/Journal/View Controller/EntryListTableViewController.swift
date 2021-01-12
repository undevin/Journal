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

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return EntryController.shared.entries.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "entryCell", for: indexPath)
        let entry = EntryController.shared.entries[indexPath.row]
        
        cell.textLabel?.text = entry.title
        return cell
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let entryToDelete = EntryController.shared.entries[indexPath.row]
            EntryController.shared.deleteEntry(entryToDelete: entryToDelete)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "toEntryDetailsVC" {
            
            guard let indexPath = tableView.indexPathForSelectedRow,
                  let destinationVC = segue.destination as? EntryDetailViewController else { return }
            
            let entryToSend = EntryController.shared.entries[indexPath.row]
            destinationVC.entry = entryToSend
        }
        
    }
}
