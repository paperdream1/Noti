//
//  ViewController.swift
//  Noti
//
//  Created by 이채원 on 2016. 10. 19..
//  Copyright © 2016년 이채원. All rights reserved.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {
    
    //var ref: Firebase?
    @IBOutlet var IDTextField: UITextField!
    @IBOutlet var PWTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var ref = FIRDatabase.database().reference()
        
        //ref.child("no").child("assr").setValue(["username": "fuck"])
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func login(_ sender: AnyObject) {
        
        /*
        FIRAuth.auth()?.signInAnonymously(completion:{ (user, error) in // 2
            if let err = error { // 3
                //print(err.localizedDescription)
                print("***********************")
                return
            }
            
            //self.performSegue(withIdentifier: "LoginToChat", sender: nil) // 4
        })*/
        
        FIRAuth.auth()?.signIn(withEmail: IDTextField.text!, password: PWTextField.text!, completion: {(user,error) in
            
            if let err = error { // 3
                //print(err.localizedDescription)
                print("***********************")
                return
            }
            
            let toVC = self.storyboard?.instantiateViewController(withIdentifier: "MyNotiRoomNavigationController")
            
            self.present(toVC!, animated: true, completion: nil)
        })
    }
}

