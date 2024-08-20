//
//  TextFieldViewController.swift
//  Rx Counter
//
//  Created by Nikos Galinos,   on 5/9/23.
//  

import UIKit

class TextFieldViewController: UIViewController {

    let inputTextField = UITextField()
    @IBOutlet weak var displayTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Set up the input text field as hidden or transparent
        inputTextField.isHidden = true
        view.addSubview(inputTextField)
        // Set up display text field
        displayTextField.text = "Tap here to enter text"
        displayTextField.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(displayTextFieldTapped))
        displayTextField.addGestureRecognizer(tapGesture)
    }
    @objc func displayTextFieldTapped() {
        // When the user taps on the display text field, make the input text field active
        inputTextField.isHidden = false
        inputTextField.becomeFirstResponder()
    }

}
