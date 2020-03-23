//
//  ForkController.swift
//  Fork
//
//  Created by Keith C on 2/5/20.
//  Copyright © 2020 Keith C. All rights reserved.
//

import Foundation
import Firebase
import FirebaseAuth
import SkyFloatingLabelTextField


class ForkController: UIViewController, UITextFieldDelegate {
    
    let message = SkyFloatingLabelTextFieldWithIcon(frame: CGRect(x: (screenWidth/2) - 100, y: (screenHeight/2) - 100, width: 200, height: 45))
    
    let db = Firestore.firestore()
    
    
    var userPicked = ""
    var messageSent = ""
    

    @IBAction func fork(_ sender: Any) {
        var allUsers = [String]()
        db.collection("users").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                
                //adds all users to an array
                for document in querySnapshot!.documents {
                    allUsers.append(document.documentID)
                }
                
                //randomly picks a user that is not the current user
                var userPickedInd = Int.random(in: 0 ..< allUsers.count)
                while allUsers[userPickedInd] == userEmail {
                    userPickedInd = Int.random(in: 0 ..< allUsers.count)
                }
                self.userPicked = allUsers[userPickedInd]
                if self.message.text! != "" {
                    self.messageSent = self.message.text!
                }
                
                //adds the message from the current user to a random users database in collection "forksReceived"
                self.db.collection("users").document(self.userPicked).collection("forksReceived").addDocument(data: ([
                    "userSent": userUsername!,
                    "message": self.messageSent
                ]))
            }
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        dismissKeyboard()
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    //    let purple = UIColor(red: 148/255, green: 125/255, blue: 162/255, alpha: 1.0)
        
        message.tintColor = UIColor.darkGray
        message.textColor = UIColor.darkGray
        message.lineColor = UIColor.darkGray
        message.selectedTitleColor = UIColor.darkGray
        message.selectedLineColor = UIColor.darkGray
        message.placeholder = "Message Text"
        message.title = "Message Text"
        message.returnKeyType = UIReturnKeyType.done
        message.delegate = self
        message.iconType = .font
        message.iconColor = UIColor.darkGray
        message.selectedIconColor = UIColor.darkGray
        message.iconFont = UIFont(name: "Font Awesome 5 Free", size: 15)
        message.iconText = "\u{f0e0}"
        message.iconMarginBottom = 4.0
        message.iconMarginLeft = 2.0
        self.view.addSubview(message)
        
        
        //dismissing keyboard tech
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
            view.addGestureRecognizer(tap)
        }
        @objc func dismissKeyboard() {
            view.endEditing(true)
        }
    
    
}
