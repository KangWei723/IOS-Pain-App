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
    case login
    case session(user: AuthUser)
    case signup
}

final class LoginController: ObservableObject {
    @Published var loginState: LoginState = .login
    var email: String = ""
    var password: String = ""
    
    var storage = Set<AnyCancellable>()
    
    func getCurrentAuthUser() {
        if let user = Amplify.Auth.getCurrentUser() {
          DispatchQueue.main.async {
              print("Signed In")
              self.loginState = .session(user: user)
          }
        } else {
            DispatchQueue.main.async {
              self.loginState = .login
          }
        }
      }
    
    func signUp(username: String, password: String, email: String) {
        let userAttributes = [AuthUserAttribute(.email, value: email)]
        let options = AuthSignUpRequest.Options(userAttributes: userAttributes)
        Amplify.Auth.signUp(username: username, password: password, options: options)
            .resultPublisher
            .receive(on: DispatchQueue.main)
            .sink {
                if case .failure(let error) = $0 {
                  print("Sign in error: \(error)")
                }
            } receiveValue: { _ in
                print("Signed Up")
//                self.signIn(email: username, password: password)
                self.email = email
                self.password = password
                self.loginState = .signup
            }.store(in: &self.storage)
    }
    
    func signIn(email: String, password: String) {
        Amplify.Auth.signIn(username: email, password: password)
          .resultPublisher
          .receive(on: DispatchQueue.main)
          .sink {
              if case .failure(let error) = $0 {
                print("Sign in error: \(error)")
              }
          } receiveValue: { _ in
              self.email = ""
              self.password = ""
              self.getCurrentAuthUser()
          }.store(in: &self.storage)
      }
    
    func signOutLocally() {
        Amplify.Auth.signOut()
            .resultPublisher
            .receive(on: DispatchQueue.main)
            .sink {
                if case .failure(let error) = $0 {
                  print("Sign out error: \(error)")
                }
            } receiveValue: { _ in
                self.getCurrentAuthUser()
                print("Signed Out")
            }.store(in: &self.storage)
    }
    
}
