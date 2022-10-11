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
            PatientView_HomePage().tabItem {
                Label("Home", systemImage: "house.fill")
               
            }
            tabItem {
                Label("New Entry", systemImage: "plus.circle.fill")
               
            }
            PatientView_PastRecords().tabItem {
               Label("Past Records", systemImage: "newspaper.fill")
               
            }
            PatientView_Profile().tabItem {
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
