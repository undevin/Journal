//
//  EntryDetailViewController.swift
//  Journal
//
//  Created by Cameron Stuart on 12/30/20.
//

import UIKit

class EntryDetailViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var bodyTextView: UITextView!
    
    var entry: Entry?

    override func viewDidLoad() {
        super.viewDidLoad()
        titleTextField.delegate = self
        updateViews()
    }
    
    @IBAction func clearAllButtonTapped(_ sender: Any) {
        titleTextField.text = ""
        bodyTextView.text = ""
    }
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        guard let title = titleTextField.text, !title.isEmpty,
              let body = bodyTextView.text, !body.isEmpty else { return }
        if let entry = entry {
            print("Cant update \(entry.title) jsut yet. We will handle this tomorrow.")
        } else {
            EntryController.shared.createEntryWith(title: title, body: body)
        }
        navigationController?.popViewController(animated: true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
    
    func updateViews() {
        guard let entry = entry else { return }
        titleTextField.text = entry.title
        bodyTextView.text = entry.body
    }
}
