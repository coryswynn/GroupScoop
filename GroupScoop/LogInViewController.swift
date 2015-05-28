//
//  LogInViewController.swift
//  GroupScoop
//
//  Created by Cory Wynn on 5/6/15.
//  Copyright (c) 2015 Wynn. All rights reserved.
//

import UIKit
import Parse

class LogInViewController: UIViewController, UITextFieldDelegate, SwiftPromptsProtocol {
    
    // HELPER FUNCTIONS
    //DisplayAlert helper functions
    
    func promptWasDismissed() {
        self.prompt.dismissPrompt()
    }
    
    
    func clickedOnTheMainButton() {
        println("Clicked on the main button")
        self.prompt.dismissPrompt()
        
        if signUpSuccessful == true {
        
            self.performSegueWithIdentifier("loggedIn", sender: self)
        
            println("Logged in")
        
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
        
        if signUpSuccessful == true {
            
            //Create an instance of SwiftPromptsView and assign its delegate
            prompt = SwiftPromptsView(frame: self.view.bounds)
            prompt.delegate = self
            
            //Set the properties for the background
            prompt.enableLightEffectView()
            
            //Set the properties of the promt
            prompt.setPromtHeader(title)
            prompt.setPromptContentText(textbody)
            prompt.setPromptTopLineVisibility(true)
            prompt.setPromptBottomLineVisibility(false)
            prompt.setPromptBottomBarVisibility(true)
            prompt.setPromptTopLineColor(UIColor(red: 151.0/255.0, green: 151.0/255.0, blue: 151.0/255.0, alpha: 1.0))
            prompt.setPromptBackgroundColor(UIColor(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 0.67))
            prompt.setPromptBottomBarColor(UIColor(red: 34.0/255.0, green: 139.0/255.0, blue: 34.0/255.0, alpha: 0.67))
            prompt.setMainButtonColor(UIColor.whiteColor())
            prompt.setMainButtonText("OK")
            
            self.view.addSubview(prompt)
            
        } else {
            
            //Create an instance of SwiftPromptsView and assign its delegate
            prompt = SwiftPromptsView(frame: self.view.bounds)
            prompt.delegate = self
            
            //Set the properties for the background
            prompt.enableExtraLightEffectView()
            
            //Set the properties of the promt
            prompt.setPromtHeader(title)
            prompt.setPromptContentText(textbody)
            prompt.setPromptTopLineVisibility(true)
            prompt.setPromptBottomLineVisibility(false)
            prompt.setPromptBottomBarVisibility(true)
            prompt.setPromptDismissIconVisibility(false)
            prompt.setPromptOutlineVisibility(true)
            prompt.setPromptHeaderTxtColor(UIColor(red: 255.0/255.0, green: 0.0/255.0, blue: 0.0/255.0, alpha: 1.0))
            prompt.setPromptOutlineColor(UIColor(red: 133.0/255.0, green: 133.0/255.0, blue: 133.0/255.0, alpha: 1.0))
            prompt.setPromptDismissIconColor(UIColor(red: 133.0/255.0, green: 133.0/255.0, blue: 133.0/255.0, alpha: 1.0))
            prompt.setPromptTopLineColor(UIColor(red: 151.0/255.0, green: 151.0/255.0, blue: 151.0/255.0, alpha: 1.0))
            prompt.setPromptBackgroundColor(UIColor(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 0.67))
            prompt.setPromptBottomBarColor(UIColor(red: 133.0/255.0, green: 133.0/255.0, blue: 133.0/255.0, alpha: 1.0))
            prompt.setMainButtonColor(UIColor.whiteColor())
            prompt.setMainButtonText("Try again")
            
            self.view.addSubview(prompt)
        }
        
    }
    
    // OBJECTS
    
    var timer = NSTimer()
    
    var error = ""
    
    var signUpSuccessful = false
    
    var prompt = SwiftPromptsView()
    
    var user = PFUser.currentUser()
   
    @IBOutlet var username: UITextField!
    
    @IBOutlet var password: UITextField!
    
    // ACTIONS
    
    @IBAction func submitPressed(sender: AnyObject) {
        PFUser.logInWithUsernameInBackground(self.username.text, password: self.password.text) {
                (user: PFUser?, signupError: NSError?) -> Void in
            
            if signupError == nil {
                
                var user = PFUser.currentUser()?.username!
            
                self.signUpSuccessful = true 
            
                self.displayAlert("Success!", textbody: "Welcome back, \(user!)!")
                
                self.timer = NSTimer.scheduledTimerWithTimeInterval(2, target: self, selector: "clickedOnTheMainButton", userInfo: nil, repeats: false)
                
            } else {
                
                if let errorString = signupError?.userInfo?["error"] as? NSString {
                    
                    self.error = String(errorString)
                    self.displayAlert("Uh Oh! Error!", textbody: self.error)
                
                } else {
                    
                    self.error = "Please try again later."
                    self.displayAlert("Uh Oh! Error!", textbody: self.error)
                    
                    
                }
            }
        }
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.username.delegate = self
        self.password.delegate = self
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
