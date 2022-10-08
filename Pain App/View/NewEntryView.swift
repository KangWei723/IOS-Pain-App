//
//  NewEntryView.swift
//  Pain App
//
//  Created by Darshit Vachhani on 10/8/22.
//

import SwiftUI

struct NewEntryView: View {
    var body: some View {
        ZStack {
            (Color.init(hex: "#A8DADC"))
            Image(systemName: "plus.circle.fill").foregroundColor(Color.black).font(.system(size:100))
        }
      
    }
}

struct NewEntryView_Previews: PreviewProvider {
    static var previews: some View {
        NewEntryView()
    }
}
