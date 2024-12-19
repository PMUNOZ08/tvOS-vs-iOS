//
//  TextFiledsController.swift
//  NSCoder_tvOS_UIKit
//
//  Created by Pedro on 3/11/24.
//

import UIKit

class TextFiledsController: UIViewController {

    @IBOutlet weak var txtUsername: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func btnAcceptTapped(_ sender: Any) {
        let alert = UIAlertController(title: "NSCoder tvOS", message: "This is a sample of Alert in tvOS", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default))
        
        present(alert, animated: true)
    }
}
