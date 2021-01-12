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
    
    // MARK: - Actions
    @IBAction func clearTextButtonTapped(_ sender: UIButton) {
        titleTextField.text = ""
        bodyTextView.text = ""
    }
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        guard let title = titleTextField.text, !title.isEmpty,
              let body = bodyTextView.text, !body.isEmpty else { return }
        
        EntryController.shared.createEntryWith(title: title, body: body)
        EntryController.shared.saveToPersistentStorage()
        self.navigationController?.popToRootViewController(animated: true)
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
