//
//  HomeView.swift
//  Pain App
//
//  Created by Darshit Vachhani on 10/8/22.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        ZStack {
            (Color.init(hex: "#A8DADC"))
            Text("Home!").font(.title)
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
