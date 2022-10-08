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
    
    init() {
        configureAmplify()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
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
