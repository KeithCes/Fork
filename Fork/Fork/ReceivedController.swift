//
//  ReceivedController.swift
//  Fork
//
//  Created by Keith C on 3/21/20.
//  Copyright © 2020 Keith C. All rights reserved.
//

import Foundation
import Firebase
import FirebaseAuth


class ReceivedController: UIViewController {
    
    let db = Firestore.firestore()
    
    @IBOutlet weak var sender: UILabel!
    @IBOutlet weak var message: UILabel!
    
    @IBAction func next(_ sender: Any) {
        self.db.collection("users").document(userEmail).collection("forksReceived").getDocuments()  { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
               
                //only continues if there are more received messages
                if querySnapshot!.documents.count > 0 {
                    //deletes first received message in database
                self.db.collection("users").document(userEmail).collection("forksReceived").document(querySnapshot!.documents[0].documentID).delete() { err in
                        if let err = err {
                            print("Error removing document: \(err)")
                        } else {
                            print("Document successfully removed!")
                        }
                    }
                    
                    //changes label to next received message
                    self.message.text = (querySnapshot!.documents[0]["message"] as! String)
                    self.sender.text = (querySnapshot!.documents[0]["userSent"] as! String)
                }
                else {
                    self.message.text = "..."
                    self.sender.text = "..."
                }
            }
        }
    }
                        
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        db.collection("users").document(userEmail).collection("forksReceived").getDocuments()  { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                //only continues if there are more received messages
                if querySnapshot!.documents.count > 0 {
                    
                    self.message.text = (querySnapshot!.documents[0]["message"] as! String)
                    self.sender.text = (querySnapshot!.documents[0]["userSent"] as! String)
                    
                    //deletes first received message in database
                self.db.collection("users").document(userEmail).collection("forksReceived").document(querySnapshot!.documents[0].documentID).delete() { err in
                        if let err = err {
                            print("Error removing document: \(err)")
                        } else {
                            print("Document successfully removed!")
                        }
                    }
                    
                }
                
            }
        }
    }
    
    
}
