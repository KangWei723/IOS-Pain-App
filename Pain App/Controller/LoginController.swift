//
//  LoginController.swift
//  Pain App
//
//  Created by Shrey Patel on 10/9/22.
//

import Amplify
import Combine
import Foundation

enum LoginState {
    case signUp
    case login
    case session(user: AuthUser)
}

final class LoginController: ObservableObject {
    @Published var loginState: LoginState = .login
    
    func getCurrentUser() {
        if let user = Amplify.Auth.getCurrentUser() {
            loginState = .session(user: user)
        } else {
            loginState = .login
        }
    }
    
    func showSignUp() {
        loginState = .signUp
    }
    
    func showLogin() {
        loginState = .login
    }
    
    func signUp(email: String, password: String) -> AnyCancellable {
        let userAttributes = [AuthUserAttribute(.email, value: email)]
        let options = AuthSignUpRequest.Options(userAttributes: userAttributes)
        let sink = Amplify.Auth.signUp(username: email, password: password, options: options)
            .resultPublisher
            .sink {
                if case let .failure(authError) = $0 {
                    print("An error occured while registering a user \(authError)")
                }
            }
            receiveValue: { signUpResult in
                if case let .confirmUser(deliveryDetails, _) = signUpResult.nextStep {
                        print("Delivery details \(String(describing: deliveryDetails))")
                } else {
                    print("SignUp Complete")
                }
            }
        return sink
    }
    
}
