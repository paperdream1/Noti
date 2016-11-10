//
//  ViewController.swift
//  Noti
//
//  Created by 이채원 on 2016. 10. 19..
//  Copyright © 2016년 이채원. All rights reserved.
//

import UIKit
import Firebase
import Reductio

class LoginViewController: UIViewController {
    
    //var ref: Firebase?
    @IBOutlet var IDTextField: UITextField!
    @IBOutlet var PWTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var ref = FIRDatabase.database().reference()
        
        //ref.child("no").child("assr").setValue(["username": "fuck"])
        
        // Do any additional setup after loading the view, typically from a nib.
        
        let text = "학술제 오는 11월 10일, 11일에 서울여대와 함께 진행하는 연합 학술제가 진행됩니다! 자세한 일정 및 안내는 포스터를 참고하시기 바랍니다. 신청은 아래 링크를 통해 신청해주시면 됩니다. 신청을 따로 하지 않고, 당일 참석도 가능하니 이 점 알아두시기 바랍니다!"
        
        Reductio.keywords(from: text, count: 1) { words in
            print(words)
        }
        
        Reductio.summarize(text: text, compression: 0.2) { phrases in
            print(phrases)
        }
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
            
            let toVC = self.storyboard?.instantiateViewController(withIdentifier: "NotiTabbarController")
            
            self.present(toVC!, animated: true, completion: nil)
        })
    }
}

