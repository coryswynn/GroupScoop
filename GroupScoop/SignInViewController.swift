//
//  SignInViewController.swift
//  GroupScoop
//
//  Created by Cory Wynn on 5/6/15.
//  Copyright (c) 2015 Wynn. All rights reserved.
//

import UIKit
import Parse

class SignInViewController: UIViewController, UITextFieldDelegate, SwiftPromptsProtocol {
    
// HELPER FUNCTIONS
    //DisplayAlert helper functions 
    
    func promptWasDismissed() {
        self.prompt.dismissPrompt()
    }
    
    
    func clickedOnTheMainButton() {
        println("Clicked on the main button")
        self.prompt.dismissPrompt()
    
        if signUpScreen == true {
        
            PFUser.logInWithUsernameInBackground(self.username.text, password: self.password.text) {
                (user: PFUser?, signupError: NSError?) -> Void in
                
                self.performSegueWithIdentifier("signedUp", sender: self)
                
                println("Logged in")
                
            }
        } else {
            
            
        }
    
    
    }
    
    // Dismisses the keyboard when touched outside
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        
        self.view.endEditing(true)
    
    }
    
    
    // Dismisses Keyboard upon pushing of "Return"
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        
        return true
        
    }
    

    func displayAlert (title: String, textbody: String) {
        //Create an instance of SwiftPromptsView and assign its delegate
        prompt = SwiftPromptsView(frame: self.view.bounds)
        prompt.delegate = self
        
        //Set the properties for the background
        prompt.setBlurringLevel(2.0)
        prompt.setColorWithTransparency(UIColor(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 0.64))
    
        //Set the properties of the promt
        prompt.setPromtHeader(title)
        prompt.setPromptContentText(textbody)
        prompt.setPromptTopBarVisibility(true)
        prompt.setPromptBottomBarVisibility(false)
        prompt.setPromptTopLineVisibility(false)
        prompt.setPromptBottomLineVisibility(true)
        prompt.setPromptHeaderBarColor(UIColor(red: 59.0/255.0, green: 89.0/255.0, blue: 152.0/255.0, alpha: 0.67))
        prompt.setPromptHeaderTxtColor(UIColor.whiteColor())
        prompt.setPromptContentTxtColor(UIColor(red: 59.0/255.0, green: 89.0/255.0, blue: 152.0/255.0, alpha: 0.72))
        prompt.setPromptBottomLineColor(UIColor(red: 151.0/255.0, green: 151.0/255.0, blue: 151.0/255.0, alpha: 1.0))
        prompt.setMainButtonText("ok")
        
        
    self.view.addSubview(prompt)
    
    }
    
// OBJECTS
    
    var signUpScreen = true
    
    var prompt = SwiftPromptsView()
    
    @IBOutlet var username: UITextField!

    @IBOutlet var email: UITextField!
    
    @IBOutlet var phone: UITextField!
    
    @IBOutlet var password: UITextField!
    
// ACTIONS
    
    @IBAction func submitPressed(sender: AnyObject) {
    
        var error = ""
        
        if username.text == "" || password.text == "" {
            
            error = "Please enter a username and password"
            
        }
        
        if error != "" {
            
           // Display error here
            
        } else {
            
            // Record all of the information of users to parse
            
            var user = PFUser()
            user.username = username.text
            user.password = password.text
            user.email = email.text
            user["phone"] = phone.text
            
            user.signUpInBackgroundWithBlock {
                (succeeded: Bool, signupError: NSError?) -> Void in
                    
                if signupError == nil {
                    
                    // Display success message -- successfully logged in
                    
                    self.displayAlert("Success!", textbody: "You have successfully signed up for GroupScoop!")
                    
                    println("signed up")
                    
                } else {
                    if let errorString = signupError?.userInfo?["error"] as? NSString {
                        
                        error = String(errorString)
                            
                    } else {
                            
                        error = "Please try again later."
                            
                        }
                        
                    // Display could not sign up
                        
                }
            }
                
        }
    
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.username.delegate = self
        self.email.delegate = self
        self.phone.delegate = self
        self.password.delegate = self
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
