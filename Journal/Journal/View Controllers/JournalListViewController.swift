//
//  JournalListViewController.swift
//  Journal
//
//  Created by Devin Flora on 1/12/21.
//

import UIKit

class JournalListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // MARK: - Outlets
    @IBOutlet weak var journalTitleTextField: UITextField!
    @IBOutlet weak var journalListTableView: UITableView!
    
    
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        journalListTableView.delegate = self
        journalListTableView.dataSource = self
        JournalController.shared.loadFromPersistentStorage()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        journalListTableView.reloadData()
    }
    
    // MARK: - Actions
    @IBAction func createNewJournalButtonTapped(_ sender: Any) {
        guard let title = journalTitleTextField.text else { return }
        JournalController.shared.createJournalWith(title: title)
        journalListTableView.reloadData()
        journalTitleTextField.text = ""
    }
    
    // MARK: - Table View Data Source
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return JournalController.shared.journals.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = journalListTableView.dequeueReusableCell(withIdentifier: "journalCell", for: indexPath)
        let journal = JournalController.shared.journals[indexPath.row]
        
        cell.textLabel?.text = journal.title
        cell.detailTextLabel?.text = ""
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let journalToDelete = JournalController.shared.journals[indexPath.row]
        JournalController.shared.deleteJournal(journalToDelete: journalToDelete)
        tableView.deleteRows(at: [indexPath], with: .fade)
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "toEntryList" {
            guard let indexPath = journalListTableView.indexPathForSelectedRow,
                  let destination = segue.destination as? EntryListTableViewController else { return }
            let journalToSend = JournalController.shared.journals[indexPath.row]
            destination.journal = journalToSend
        }
    }
}
