//
//  EntryDetailViewController.swift
//  Journal
//
//  Created by Devin Flora on 1/11/21.
//

import UIKit

class EntryDetailViewController: UIViewController, UITextFieldDelegate {
    
    // MARK: - Outlets
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var bodyTextView: UITextView!
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        updateView()
        titleTextField.delegate = self
    }
    
    // MARK: - Properties
    var entry: Entry?
    var journal: Journal?
    
    // MARK: - Actions
    @IBAction func clearTextButtonTapped(_ sender: UIButton) {
        titleTextField.text = ""
        bodyTextView.text = ""
    }
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        guard let title = titleTextField.text, !title.isEmpty,
              let body = bodyTextView.text, !body.isEmpty,
              let journal = journal else { return }
        if let entry = entry {
            EntryController.update(title: title, body: body, entry: entry)
        } else {
            EntryController.createEntryWith(title: title, body: body, journal: journal)
        }
        navigationController?.popViewController(animated: true)
    }
    
    func updateView() {
        guard let entry = entry else { return }
        titleTextField.text = entry.title
        bodyTextView.text = entry.body
    }
    
    func textFieldShouldReturn() {
        titleTextField.resignFirstResponder()
    }
}
