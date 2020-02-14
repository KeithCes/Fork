//
//  SettingsController.swift
//  Fork
//
//  Created by Keith C on 2/6/20.
//  Copyright © 2020 Keith C. All rights reserved.
//

import Foundation
import Firebase
import FirebaseAuth


class SettingsController: UIViewController {
    
      @IBAction func logout(_ sender: Any) {
        try! Auth.auth().signOut()
        
        print("logged out")
        
        self.dismiss(animated: true, completion: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
}
