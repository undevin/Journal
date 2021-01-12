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
    }
    
    // MARK: - Properties
    var entry: Entry?
    
    // MARK: - Actions
    @IBAction func clearTextButtonTapped(_ sender: UIButton) {
        titleTextField.text = ""
        bodyTextView.text = ""
    }
    @IBAction func saveButtonTapped(_ sender: Any) {
        if let entry = titleTextField.text?.isEmpty, let body = bodyTextView.text?.isEmpty {
            print("To be implemented tomorrow")
        } else {
            EntryController.shared
        }
        
    }
    
    func updateView() {
        guard let entry = entry else { return }
        titleTextField.text = entry.title
        bodyTextView.text = entry.body
    }
    
    func textFieldShouldReturn() {
        let titleField = titleTextField
        titleField?.resignFirstResponder()
    }
}
