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
    
    @ObservedObject var mainViewController: MainViewController
    @ObservedObject var loginController: LoginController
    
    init() {
        _mainViewController = ObservedObject(wrappedValue: MainViewController())
        _loginController = ObservedObject(wrappedValue: LoginController(mainView: _mainViewController.wrappedValue))
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
                mainViewController.getView()
                    .preferredColorScheme(.light)
                    .environmentObject(mainViewController)
                    .environmentObject(loginController)
                NavigationBar()
            case .signup:
                Patient_Questionaire()
                    .preferredColorScheme(.light)
                    .environmentObject(loginController)
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
