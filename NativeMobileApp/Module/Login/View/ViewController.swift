//
//  ViewController.swift
//  NativeMobileApp
//
//  Created by Issac on 12/06/22.
//

import UIKit

class ViewController: BaseVC {
    
    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var palindromeTF: UITextField!
    @IBOutlet weak var checkBtnView: UIButton!
    @IBOutlet weak var nextBtnView: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func setupView() {
        nameTF.layer.cornerRadius = 12
        palindromeTF.layer.cornerRadius = 12
        checkBtnView.layer.cornerRadius = 12
        nextBtnView.layer.cornerRadius = 12
        nameTF.layer.masksToBounds = true
        palindromeTF.layer.masksToBounds = true
        checkBtnView.layer.masksToBounds = true
        nextBtnView.layer.masksToBounds = true
    }

    @IBAction func checkBtn(_ sender: Any) {
        if palindromeTF.text != "" {
            let currentText = palindromeTF.text!.replacingOccurrences(of: " ", with: "")
            if currentText == String(currentText.reversed()) {
                showError(msg: "isPalindrome")
            } else {
                showError(msg: "not Palindrome")
            }
        } else {
            showError(msg: "Palindrome text field empty")
        }
    }
    
    @IBAction func nextBtn(_ sender: Any) {
        if nameTF.text != "" {
            let vc = (UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "HomeVC") as? HomeVC)!
            pushVC(vc)
        } else {
            showError(msg: "Name must be filled")
        }
    }
}

