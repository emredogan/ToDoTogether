//
//  GoogleLoginViewController.swift
//  ToDoTogether
//
//  Created by Emre Dogan on 07/04/2022.
//

import UIKit
import GoogleSignIn
class GoogleLoginViewController: UIViewController {
    let signInConfig = GIDConfiguration.init(clientID: "97477077722-6p250130lo0blbe2g76cmmrmb0c18tel.apps.googleusercontent.com")

    
    @IBOutlet weak var loginButton: GIDSignInButton!
    
    @IBAction func googleTapped(_ sender: GIDSignInButton) {
        login()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if GIDSignIn.sharedInstance.currentUser != nil {
            self.performSegue(withIdentifier: "SegueToMain", sender: self)

        } else {
            print("User is nil")
        }
    }

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(login))
        loginButton.addGestureRecognizer(tapGesture)
        
        
        
    }
    
    @objc func login() {
        print("LOGINN")
        GIDSignIn.sharedInstance.signIn(with: signInConfig, presenting: self) { user, error in
          guard error == nil else { return }
            print(user!.userID!)
            
            self.performSegue(withIdentifier: "SegueToMain", sender: self)





          // If sign in succeeded, display the app's main content View.
        }
        
    }
    
}
