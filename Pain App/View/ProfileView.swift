//
//  ProfileView.swift
//  Pain App
//
//  Created by Darshit Vachhani on 10/8/22.
//

import SwiftUI

struct ProfileView: View {
    var body: some View {
        ZStack {
            (Color.init(hex: "#A8DADC"))
            Image(systemName: "person.crop.circle.fill").foregroundColor(Color.black).font(.system(size:100))
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
