//
//  ContentView.swift
//  Pain App
//
//  Created by Shrey Patel on 10/5/22.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello, world!")
            Spacer()
        }
        .background(Color.init(hex: "#A8DADC"))
        .padding()
        
        TabView {
            HomeView().tabItem() {
                Image(systemName: "house.fill")
                Text("Home")
               
            }
            NewEntryView().tabItem() {
                Image(systemName: "plus.circle.fill")
                Text("New Entry")
               
            }
            PastRecordsView().tabItem() {
                Image(systemName: "newspaper.fill")
                Text("Past Records")
               
            }
            ProfileView().tabItem() {
                Image(systemName: "person.crop.circle.fill")
                Text("Profile")
               
            }
        }
      
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
       
    }
}
