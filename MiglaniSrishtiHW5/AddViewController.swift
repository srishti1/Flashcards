//
//  AddViewController.swift
//  MiglaniSrishtiHW5
//
//  Created by Srishti on 04/11/18.
//  Copyright © 2018 Srishti Miglani. All rights reserved.
//
import UIKit
import Foundation

class AddViewController: UIViewController, UITextFieldDelegate, UITextViewDelegate{
    var sharedFlashcardsModel = FlashcardsModel.sharedInstance
    @IBOutlet weak var questionTextView:UITextView!
    @IBOutlet weak var answerTextField:UITextField!
    @IBOutlet weak var SaveButton: UIButton!
    
    @IBOutlet weak var InfoLabel: UILabel!
    var saveButtonOriginalColor: UIColor!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        questionTextView.becomeFirstResponder()
        InfoLabel.text = message
        //instrlabel.text = msg
    }
    @IBAction func TapDidPress(_ sender: UITapGestureRecognizer) {
        answerTextField.resignFirstResponder()
        questionTextView.resignFirstResponder()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        SaveButton.isEnabled = false
        saveButtonOriginalColor = SaveButton.backgroundColor
        SaveButton.backgroundColor = UIColor.gray

    }
    
    var completionHandler: ((_ question: String?,_ answer: String?) ->Void)?
    var message = ""
    
    @IBAction func SaveButtonDidPress(_ sender: UIButton) {
        if let question = questionTextView.text, let answer = answerTextField.text, !question.isEmpty, !answer.isEmpty, let completionHandler = completionHandler{
            completionHandler(question, answer)
            questionTextView.text = nil
            answerTextField.text = nil
            self.navigationController?.popViewController(animated: true)
            
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        answerTextField.resignFirstResponder()
        return true
        //answerTextField.becomeFirstResponder()
    }
    func textField(_ textField: UITextField,shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool{
        let changedString = (textField.text! as NSString).replacingCharacters(in: range, with: string)
        enableSaveButton(question: questionTextView.text!, answer: changedString)
        return true
    }
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let changedString = (textView.text! as NSString).replacingCharacters(in: range, with: text)
        enableSaveButton(question: changedString, answer: answerTextField.text!)
        if (text == "\n") {
            answerTextField.becomeFirstResponder()
            //questionTextView.resignFirstResponder()
            return false
        }
        return true
    }
    
    // MARK: - Private Functions
    
    private func enableSaveButton(question: String, answer: String){
        
        // If either textview or textfield is empty, thne disable button
        if question.isEmpty || answer.isEmpty{
            SaveButton.isEnabled = false
            SaveButton.backgroundColor = UIColor.gray
        } else{
            SaveButton.isEnabled = true
            SaveButton.backgroundColor = saveButtonOriginalColor
        }
        
    }

}
