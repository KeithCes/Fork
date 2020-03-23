//
//  MainController.swift
//  Fork
//
//  Created by Keith C on 2/6/20.
//  Copyright © 2020 Keith C. All rights reserved.
//

import Foundation
import Firebase
import FirebaseAuth


class MainController: UIViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        //logs user in if they are authed already (remember me)
        if Auth.auth().currentUser != nil {
            let mainStoryboard = UIStoryboard(name: "Main", bundle: Bundle.main)
            if let viewController = mainStoryboard.instantiateViewController(withIdentifier: "TabBarController") as? UIViewController {
                self.present(viewController, animated: true, completion: nil)
                
                //sets authed email to userEmail var
                userEmail = String((Auth.auth().currentUser?.email)!)
                
                
                let db = Firestore.firestore()
                let docRef = db.collection("users").document(userEmail)

                docRef.getDocument { (document, error) in
                    if let document = document, document.exists {
                        userUsername = document.data()!["username"]! as? String
                    } else {
                        print("Document does not exist")
                    }
                }
                
                
            }
        }
    }
    
    
}
