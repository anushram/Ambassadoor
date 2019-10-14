//
//  SignInVC.swift
//  Ambassadoor Business
//
//  Created by K Saravana Kumar on 22/07/19.
//  Copyright © 2019 Tesseract Freelance, LLC. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class SignInVC: BaseVC,UITextFieldDelegate {
    
    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var forgetButton: UIButton!
    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    @IBOutlet weak var scroll: UIScrollView!
    
    var keyboardHeight: CGFloat = 0.00
    var assainedTextField: UITextField? = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        print("roundup",(1.056756 * 100).rounded()/100)
		
		registerButton.layer.cornerRadius = 6
		
        // Do any additional setup after loading the view.
    }
    
    @objc override func keyboardWasShown(notification : NSNotification) {
        
        let info : NSDictionary = notification.userInfo! as NSDictionary
        keyboardHeight = (info[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue.height
        UIView.animate(withDuration: 0.1, animations: {
            
            if self.assainedTextField != nil {
                let textY = self.assainedTextField!.frame.origin.y + (self.assainedTextField!.frame.size.height)
                
                var conOFFSet:CGFloat = 0.0
                
                
                if textY < self.scroll.frame.size.height {
                    
                    conOFFSet = ((self.scroll.contentSize.height - self.scroll.frame.size.height) - (self.scroll.frame.size.height - textY))
                    
                }else {
                    //                conOFFSet = (self.scroll.contentSize.height - self.scroll.frame.size.height) + self.keyboardHeight
                    conOFFSet = ((self.scroll.contentSize.height - self.scroll.frame.size.height) - (self.scroll.frame.size.height - textY))
                }
                
                
                let keyboardY = self.view.frame.size.height - self.keyboardHeight
                
                
                if textY >= keyboardY {
                    UIView.animate(withDuration: 0.1) {
                        let scrollPoint = CGPoint(x: 0, y: conOFFSet)
                        self.scroll .setContentOffset(scrollPoint, animated: true)
                    }
                    
                }
            }
            
        }) { (value) in
            
        }
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool{
		if textField == emailText {
			passwordText.becomeFirstResponder()
		} else {
			signInAction(sender: signInButton)
			textField.resignFirstResponder()
		}
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        self.assainedTextField = textField
        
    }
    
    @IBAction func createAccountAction(sender: UIButton){
        DispatchQueue.main.async(execute: {
            
            self.performSegue(withIdentifier: "toSignUp", sender: self)
            
        })
    }
    
    @objc func timerAction(sender: AnyObject){
        self.showActivityIndicator()
    }
    
	@IBOutlet weak var usernameLine: UILabel!
	@IBOutlet weak var passwordline: UILabel!
	
	@IBAction func signInAction(sender: UIButton){
        
        if emailText.text?.count != 0 {
            
            if Validation.sharedInstance.isValidEmail(emailStr: emailText.text!){
                
                if passwordText.text?.count != 0 {
                    //self.showActivityIndicator()
                    let timer = Timer.scheduledTimer(timeInterval: 4, target: self, selector: #selector(self.timerAction(sender:)), userInfo: nil, repeats: false)
                    signInButton.setTitle("Signing In..", for: .normal)
                    Auth.auth().signIn(withEmail: emailText.text!, password: passwordText.text!) { (user, error) in
                        self.emailText.resignFirstResponder()
                        self.passwordText.resignFirstResponder()
                        if error == nil {
                            
                                getCurrentCompanyUser(userID: (Auth.auth().currentUser?.uid)!) { (companyUser, error) in
                                if companyUser != nil {
                                    Singleton.sharedInstance.setCompanyUser(user: companyUser!)
                                    DispatchQueue.main.async(execute: {
                                        timer.invalidate()
                                        self.hideActivityIndicator()
										self.instantiateToMainScreen()
									})
									}
									
                            }
                            
                        }else{
                            timer.invalidate()
                            self.hideActivityIndicator()
                            self.signInButton.setTitle("Sign In", for: .normal)
                            print("error=",error!)
                            self.showAlertMessage(title: "Alert", message: (error?.localizedDescription)!) {
                                
                            }
                            
                        }
                        
                    }
                    
                } else {
                    MakeShake(viewToShake: signInButton)
					passwordline.backgroundColor = .red
					
				}
			} else {
				MakeShake(viewToShake: signInButton)
				usernameLine.backgroundColor = .red
			}
		} else {
			MakeShake(viewToShake: signInButton)
			usernameLine.backgroundColor = .red
		}
		
	}
	
	@IBAction func forgetPasswordAction(sender: UIButton){
        
        DispatchQueue.main.async(execute: {
            
            self.performSegue(withIdentifier: "toForgetPassword", sender: self)
            
        })
        
    }

}
