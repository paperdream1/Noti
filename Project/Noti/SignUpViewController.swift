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
            
            if err != nil{
                
                if(err.debugDescription.contains("The email address is badly formatted"))
                {
                
                let alert = UIAlertController(title: "이메일 형식이 맞지 않습니다", message: "다시 입력해 주세요", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "확인", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion:nil)
                }
                else if(err.debugDescription.contains("The password must be 6 characters long or more"))
                {
                    let alert = UIAlertController(title: "비밀번호는 6자 이상이어야 합니다", message: "", preferredStyle: UIAlertControllerStyle.alert)
                    alert.addAction(UIAlertAction(title: "확인", style: UIAlertActionStyle.default, handler: nil))
                    self.present(alert, animated: true, completion:nil)
                }
                else{
                    let alert = UIAlertController(title: "회원가입에 문제가 있습니다", message: "잠시 후 다시 시도해 주세요", preferredStyle: UIAlertControllerStyle.alert)
                    alert.addAction(UIAlertAction(title: "확인", style: UIAlertActionStyle.default, handler: nil))
                    self.present(alert, animated: true, completion:nil)
                }
                
                return
            }
            
            print("hello: "+String(describing: err))
            self.dismiss(animated: true, completion: nil)
        })
    }
}
