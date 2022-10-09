//
//  Pain_AppApp.swift
//  Pain App
//
//  Created by Shrey Patel on 10/5/22.
//

import SwiftUI
import Amplify
import AmplifyPlugins

@main
struct Pain_AppApp: App {
    
    @ObservedObject var loginController = LoginController()
    
    init() {
        configureAmplify()
        loginController.getCurrentUser()
    }
    
    var body: some Scene {
        WindowGroup {
            switch loginController.loginState {
            case .login:
                LoginView()
                    .environmentObject(loginController)
            case .signUp:
                LoginView()
                    .environmentObject(loginController)
            case .session:
                ContentView()
            }
        }
    }
    
    private func configureAmplify() {
        do {
            try Amplify.add(plugin: AWSCognitoAuthPlugin())
            try Amplify.configure()
            print("Amplify configured sucessfully")
        } catch {
            print("An error occured setting up Amplify: \(error)")
        }
    }
}
