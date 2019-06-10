//
//  LoginViewController.swift
//  SignInWithApple
//
//  Created by Priya Talreja on 10/06/19.
//  Copyright © 2019 Priya Talreja. All rights reserved.
//

import UIKit
import AuthenticationServices

class LoginViewController: UIViewController {

    
    @IBOutlet weak var signWithAppleView: UIStackView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpAppleIdButton()
    }
   
    func setUpAppleIdButton()
    {
        let authorizationButton = ASAuthorizationAppleIDButton()
        authorizationButton.addTarget(self, action: #selector(handleAppleIdRequest), for: .touchUpInside)
        self.signWithAppleView.addArrangedSubview(authorizationButton)
    }
    
    @objc func handleAppleIdRequest()
    {
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        let request = appleIDProvider.createRequest()
        request.requestedScopes = [.fullName, .email]
        
        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        authorizationController.delegate = self
        authorizationController.presentationContextProvider = self
        authorizationController.performRequests()
    }

}

extension LoginViewController: ASAuthorizationControllerDelegate,ASAuthorizationControllerPresentationContextProviding
{
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        if let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential {
            
            let userIdentifier = appleIDCredential.user
            let fullName = appleIDCredential.fullName
            let email = appleIDCredential.email
            print("User id is \(userIdentifier) \n Full Name  is \(String(describing: fullName)) \n Email id is \(String(describing: email))")
        }
        
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        // Handle error.
    }
    
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return self.view.window!
    }
}
