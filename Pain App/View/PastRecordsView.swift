//
//  PastRecordsView.swift
//  Pain App
//
//  Created by Darshit Vachhani on 10/8/22.
//

import SwiftUI

struct PastRecordsView: View {
    var body: some View {
        ZStack {
            (Color.init(hex: "#A8DADC"))
            Image(systemName: "newspaper.fill").foregroundColor(Color.black).font(.system(size:100))
        }
    }
}

struct PastRecordsView_Previews: PreviewProvider {
    static var previews: some View {
        PastRecordsView()
    }
}
