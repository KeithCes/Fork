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
        if Auth.auth().currentUser != nil {
            let mainStoryboard = UIStoryboard(name: "Main", bundle: Bundle.main)
            if let viewController = mainStoryboard.instantiateViewController(withIdentifier: "TabBarController") as? UIViewController {
                self.present(viewController, animated: true, completion: nil)
            }
        }
    }
    
    
}
