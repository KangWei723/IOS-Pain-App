//
//  PatientView_PastRecords.swift
//  Pain App
//
//  Created by Jonathan Lim on 10/9/22.
//

import SwiftUI

struct PatientView_PastRecords: View {
    var body: some View {
        
        ScrollView(.vertical) {

            Rectangle()
                .frame(width: 1400, height: 150, alignment: .leading)
                .foregroundColor(Color(hex: "#A8DADC"))
                .overlay(Text("\t\tWelcome User").font(.title), alignment: .leading)
                .overlay(Button(action: {}, label: {
                    Text("Profile")
                        .foregroundColor(Color.black)
                        .frame(width: 130, height: 40)
                        .background(Color.white)
                        .clipShape(Capsule())
                        .offset(x: 550, y: 40)
                }))
                .offset(x: 10, y: -30)
            
            Rectangle()
                .frame(width: 300, height: 900)
                .foregroundColor(Color(hex: "F1FAEE"))
                .offset(x: -550, y: -39)
            
            Button(action: {
                
            }, label: {
                Text("Active\n Record")
                    .foregroundColor(Color.black)
                    .frame(width: 190, height: 80)
                    .background(Color.white)
                    .clipShape(Capsule())
                    .offset(x: -540, y: -900)
            })
            
            Button(action: {
                
            }, label: {
                Text("Past\n Record")
                    .foregroundColor(Color.black)
                    .frame(width: 190, height: 80)
                    .background(Color(hex: "#A8DADC"))
                    .clipShape(Capsule())
                    .offset(x: -540, y: -870)
            })
            
            Rectangle()
                .frame(width: 860, height: 230)
                .foregroundColor(Color(hex: "F1FAEE"))
                .overlay(Text("\tDate: 05/27/2022\n\n\tPain Area: Right hand\n\n\tPain Description: Burn").font(.title), alignment: .leading)
                .overlay(Button(action: {}, label: {
                    Text("View")
                        .foregroundColor(Color.black)
                        .frame(width: 130, height: 40)
                        .background(Color.white)
                        .clipShape(Capsule())
                        .offset(x: 340, y: 70)
                }))
                .offset(x: 130, y: -1070)
            
            Rectangle()
                .frame(width: 860, height: 230)
                .foregroundColor(Color(hex: "F1FAEE"))
                .overlay(Text("\tDate: 06/09/2022\n\n\tPain Area: Left Leg\n\n\tPain Description: Freezing").font(.title), alignment: .leading)
                .overlay(Button(action: {}, label: {
                    Text("View")
                        .foregroundColor(Color.black)
                        .frame(width: 130, height: 40)
                        .background(Color.white)
                        .clipShape(Capsule())
                        .offset(x: 340, y: 70)
                }))
                .offset(x: 130, y: -1050)
                
        }
    }
}

struct PatientView_PastRecords_Previews: PreviewProvider {
    static var previews: some View {
        PatientView_PastRecords()
    }
}
