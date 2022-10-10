//
//  ContentView.swift
//  Pain App
//
//  Created by Shrey Patel on 10/5/22.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var loginController: LoginController
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello, world!")
            Spacer()
            Button {
                loginController.signOutLocally()
            } label: {
                Text("Sign Out")
            }
            .padding()
        }
        .background(Color.init(hex: "#A8DADC"))
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(LoginController())
    }
}
