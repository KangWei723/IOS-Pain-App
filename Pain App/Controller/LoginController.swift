//
//  LoginController.swift
//  Pain App
//
//  Created by Shrey Patel on 10/9/22.
//

import Amplify
import Combine
import Foundation
import SwiftUI

enum LoginState: Equatable {
    static func == (lhs: LoginState, rhs: LoginState) -> Bool {
        switch(lhs, rhs) {
        case (.login, .login): return true
        case (.signup, .signup): return true
        case (.session(user: _), .session(user: _)): return true
        default: return false
        }
    }
    
    case login
    case session(user: AuthUser? = nil)
    case signup
}

final class LoginController: ObservableObject {
    @ObservedObject var mainView: MainViewController
    @Published var loginState: LoginState
    @Published var email: String
    var password: String
    @Published var pnumber: String
    @Published var dob: String
    @Published var age: String
    @Published var city: String
    @Published var country: String
    @Published var fname: String
    @Published var lname: String
    @Published var state: String
    var storage: Set<AnyCancellable>
    var checkAuth: Bool = true
    
    init(mainView: MainViewController) {
        self.mainView = mainView
        self.loginState = .login
        self.email = ""
        self.password = ""
        self.pnumber = ""
        self.dob = ""
        self.age = ""
        self.city = ""
        self.country = ""
        self.fname = ""
        self.lname = ""
        self.state = ""
        self.storage = Set<AnyCancellable>()
    }
    
    func getCurrentAuthUser() {
        if let user = Amplify.Auth.getCurrentUser() {
          DispatchQueue.main.async {
              print("Signed In")
              self.loginState = .session(user: user)
              self.fetchAttributes()
          }
        } else {
            DispatchQueue.main.async {
              self.loginState = .login
          }
        }
      }
    
    func signUp(password: String, email: String, fname: String, lname: String) {
        let userAttributes = [AuthUserAttribute(.email, value: email),
                              AuthUserAttribute(.name, value: fname),
                              AuthUserAttribute(.custom("lname"), value: lname)]
        
        let options = AuthSignUpRequest.Options(userAttributes: userAttributes)
        Amplify.Auth.signUp(username: email, password: password, options: options)
            .resultPublisher
            .receive(on: DispatchQueue.main)
            .sink {
                if case .failure(let error) = $0 {
                    print("Sign in error: \(error)")
                }
            } receiveValue: { _ in
                print("Signed Up")
                self.email = email
                self.password = password
                self.loginState = .signup
                self.fname = fname
                self.lname = lname
            }.store(in: &self.storage)
    }
    
    func signIn(email: String, password: String) {
        Amplify.Auth.signIn(username: email, password: password)
          .resultPublisher
          .receive(on: DispatchQueue.main)
          .sink {
              if case .failure(let error) = $0 {
                print("Sign in error: \(error)")
                  self.checkAuth = false
              }
          } receiveValue: { _ in
              print("Signed In Succesfully")
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
                self.mainView.viewState = .patientHome
                self.email = ""
                self.password = ""
                self.pnumber = ""
                self.dob = ""
                self.age = ""
                self.city = ""
                self.country = ""
                self.fname = ""
                self.lname = ""
                self.state = ""
                print("Signed Out")
            }.store(in: &self.storage)
    }
    
    func fetchAttributes() {
        Amplify.Auth.fetchUserAttributes()
            .resultPublisher
            .receive(on: DispatchQueue.main)
            .sink {
                if case let .failure(authError) = $0 {
                    print("Fetch user attributes failed with error \(authError)")
                }
            }
            receiveValue: { attributes in
                print("User attributes - \(attributes)")
                for i in 0..<attributes.count {
                    switch attributes[i].key {
                    case .phoneNumber: self.pnumber = attributes[i].value
                    case .birthDate: self.dob = attributes[i].value
                    case .name: self.fname = attributes[i].value
                    case .custom("age"): self.age = attributes[i].value
                    case .custom("city"): self.city = attributes[i].value
                    case .custom("country"): self.country = attributes[i].value
                    case .custom("lname"): self.lname = attributes[i].value
                    case .custom("state"): self.state = attributes[i].value
                    case .email: self.email = attributes[i].value
                    default:
                        break
                    }
                }
            }.store(in: &self.storage)
    }
    
    func updateAttributes(fname: String, lname: String, dob: String, age: String, state: String, city: String, pnumber: String, country: String) {
        let attributes = [AuthUserAttribute(.name, value: ((fname.isEmpty) ? self.fname : fname)),
                          AuthUserAttribute(.custom("lname"), value: ((lname.isEmpty) ? self.lname : lname)),
                          AuthUserAttribute(.birthDate, value: ((dob.isEmpty) ? self.dob : dob)),
                          AuthUserAttribute(.custom("age"), value: ((age.isEmpty) ? self.age : age)),
                          AuthUserAttribute(.custom("state"), value: ((state.isEmpty) ? self.state : state)),
                          AuthUserAttribute(.custom("city"), value: ((city.isEmpty) ? self.city : city)),
                          AuthUserAttribute(.phoneNumber, value: ((pnumber.isEmpty) ? self.pnumber : pnumber)),
                          AuthUserAttribute(.custom("country"), value: ((country.isEmpty) ? self.country : country))]
        Amplify.Auth.update(userAttributes: attributes)
            .resultPublisher
            .sink {
                if case let .failure(authError) = $0 {
                    print("Update attribute failed with error \(authError)")
                }
            }
            receiveValue: { updateResult in
                print(updateResult)
                self.fetchAttributes()
            }.store(in: &self.storage)
    }
    
}
