//
//  NavigationBar.swift
//  Pain App
//
//  Created by Darshit Vachhani on 10/8/22.
//

import SwiftUI

struct NavigationBar: View {
    var body: some View {
        TabView {
            HomeView().tabItem {
                Label("Home", systemImage: "house.fill")
               
            }
            tabItem {
                Label("New Entry", systemImage: "plus.circle.fill")
               
            }
            tabItem {
               Label("Past Records", systemImage: "newspaper.fill")
               
            }
            tabItem {
                Label("Profile", systemImage: "person.crop.circle.fill")
               
            }
        }
    }
}

struct NavigationBar_Previews: PreviewProvider {
    static var previews: some View {
        NavigationBar()
    }
}
