//
//  ViewController.swift
//  Fork
//
//  Created by Keith C on 1/29/20.
//  Copyright © 2020 Keith C. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import FirebaseAuth
import SkyFloatingLabelTextField


let screenWidth  = UIScreen.main.fixedCoordinateSpace.bounds.width
let screenHeight = UIScreen.main.fixedCoordinateSpace.bounds.height

class CreateController: UIViewController, UITextFieldDelegate {
    
    var username = ""
    var password = ""
    var email = ""

    
    let userField = SkyFloatingLabelTextFieldWithIcon(frame: CGRect(x: (screenWidth/2) - 100, y: (screenHeight/2) - 200, width: 200, height: 45))
    let emailField = SkyFloatingLabelTextFieldWithIcon(frame: CGRect(x: (screenWidth/2) - 100, y: (screenHeight/2) - 150, width: 200, height: 45))
    let passField = SkyFloatingLabelTextFieldWithIcon(frame: CGRect(x: (screenWidth/2) - 100, y: (screenHeight/2) - 100, width: 200, height: 45))
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

    //    let lightGreyColor = UIColor(red: 197/255, green: 205/255, blue: 205/255, alpha: 1.0)
        let purple = UIColor(red: 148/255, green: 125/255, blue: 162/255, alpha: 1.0)
        
        
        userField.tintColor = purple
        userField.textColor = purple
        userField.lineColor = purple
        userField.selectedTitleColor = purple
        userField.selectedLineColor = purple
        userField.placeholder = "Username"
        userField.title = "Username"
        userField.returnKeyType = UIReturnKeyType.done
        userField.delegate = self
        userField.iconType = .font
        userField.iconColor = UIColor(red: 148/255, green: 125/255, blue: 162/255, alpha: 1.0)
        userField.selectedIconColor = purple
        userField.iconFont = UIFont(name: "Font Awesome 5 Free", size: 15)
        userField.iconText = "\u{f007}"
        userField.iconMarginBottom = 4.0
        userField.iconMarginLeft = 2.0
        self.view.addSubview(userField)
        
        emailField.tintColor = purple
        emailField.textColor = purple
        emailField.lineColor = purple
        emailField.selectedTitleColor = purple
        emailField.selectedLineColor = purple
        emailField.placeholder = "Email"
        emailField.title = "Email"
        emailField.returnKeyType = UIReturnKeyType.done
        emailField.delegate = self
        emailField.iconType = .font
        emailField.iconColor = UIColor(red: 148/255, green: 125/255, blue: 162/255, alpha: 1.0)
        emailField.selectedIconColor = purple
        emailField.iconFont = UIFont(name: "Font Awesome 5 Free", size: 15)
        emailField.iconText = "\u{f1fa}"
        emailField.iconMarginBottom = 4.0
        emailField.iconMarginLeft = 2.0
        self.view.addSubview(emailField)
        
        passField.tintColor = purple
        passField.textColor = purple
        passField.lineColor = purple
        passField.selectedTitleColor = purple
        passField.selectedLineColor = purple
        passField.placeholder = "Password"
        passField.title = "Password"
        passField.isSecureTextEntry = true
        passField.returnKeyType = UIReturnKeyType.done
        passField.delegate = self
        passField.iconType = .font
        passField.iconColor = UIColor(red: 148/255, green: 125/255, blue: 162/255, alpha: 1.0)
        passField.selectedIconColor = purple
        passField.iconFont = UIFont(name: "Font Awesome 5 Free", size: 15)
        passField.iconText = "\u{f023}"
        passField.iconMarginBottom = 4.0
        passField.iconMarginLeft = 2.0
        self.view.addSubview(passField)
         
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        submit()
        textField.resignFirstResponder()
        return true
    }
    
    
    func submit() {
        if (userField.text != "" && passField.text != "" && emailField.text != "") {
                
                username = userField.text!
                password = passField.text!
                email = emailField.text!
                
            
            Auth.auth().createUser(withEmail: email, password: password) { username, error in
                if error == nil && username != nil {
                    print("user created")
                    self.transitionToFork()
                }
                else {
                    print("error:  \(error!.localizedDescription)")
                }
            }
            
        }
    }
    
    func transitionToFork() {
        
        let mainStoryboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        if let viewController = mainStoryboard.instantiateViewController(withIdentifier: "TabBarController") as? UIViewController {
            self.present(viewController, animated: true, completion: nil)
        }
    }

}

