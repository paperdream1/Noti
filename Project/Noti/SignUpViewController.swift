//
//  SignUpViewController.swift
//  Noti
//
//  Created by 이채원 on 2016. 11. 9..
//  Copyright © 2016년 이채원. All rights reserved.
//

import Foundation
import UIKit
import Firebase

class SignUpViewController: UIViewController {
    
    @IBOutlet var pwTextField: UITextField!
    @IBOutlet var emailTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func cancelButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func signUpButton(_ sender: Any) {
        
        if(pwTextField.text == nil)
        {
            let alert = UIAlertController(title: "", message: "비밀번호를 입력하세요", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "확인", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion:nil)
        }
        else if(emailTextField.text == nil)
        {
            let alert = UIAlertController(title: "", message: "이메일을 입력하세요", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "확인", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion:nil)
        }

        
        FIRAuth.auth()?.createUser(withEmail: emailTextField.text!, password: pwTextField.text!, completion: {(user,err) in
            print("hello: "+String(describing: err))
            self.dismiss(animated: true, completion: nil)
        })
    }
}
