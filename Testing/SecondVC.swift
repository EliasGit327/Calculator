//
//  2ViewController.swift
//  Testing
//
//  Created by Elias on 3/18/19.
//  Copyright © 2019 Elias Smith. All rights reserved.
//

import UIKit

class SecondVC: UIViewController {
  @IBOutlet weak var textView: UITextView!
  @IBOutlet weak var secondLabel: UITextField!
  
  var textViewString = ""
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    secondLabel.text = NSLocalizedString("data title", comment: "")
    textView.text = textViewString
    
  }
  
  
  @IBAction func didTapBackButton(_ sender: UIButton) {
    self.dismiss(animated: true, completion: nil)
  }
  
}
