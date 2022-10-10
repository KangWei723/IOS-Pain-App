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
        var isRunningForPreviews: Bool {
            ProcessInfo.processInfo.environment["XCODE_RUNNING_FOR_PREVIEWS"] != nil
        }

        if !isRunningForPreviews {
            // Do not invoke Amplify.configure()
            configureAmplify()
            loginController.getCurrentAuthUser()
            return
        }
    }
    
    var body: some Scene {
        WindowGroup {
            switch loginController.loginState {
            case .login:
                LoginView()
                    .preferredColorScheme(.light)
                    .environmentObject(loginController)
            case .session(user: _):
                ContentView()
                    .environmentObject(loginController)
                NavigationBar()
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
