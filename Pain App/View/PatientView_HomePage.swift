//
//  PatientView_HomePage.swift
//  Pain App
//
//  Created by Jonathan Lim on 10/8/22.
//

import SwiftUI

struct PatientView_HomePage: View {
    var body: some View {
        ScrollView(.vertical) {
            // Header
            Rectangle().frame(width: 1400, height: 150, alignment: .leading)
                .foregroundColor(Color(hex: "#A8DADC")).overlay(
                    Text("\t\tWelcome User").font(.title), alignment: .leading)
                .offset(x: 10, y: -30)
            
            // Profile
            Button(action: {}, label: {
                Text("Profile")                        .foregroundColor(Color.black)
                     .frame(width: 130, height: 40)
                    .background(Color.white)
                    .clipShape(Capsule())
                    .offset(x: 550, y: -100)
                })
            
            // Left tab background
            Rectangle()
                .frame(width: 300, height: 900)
                .foregroundColor(Color(hex: "F1FAEE"))
                .offset(x: -550, y: -87)
            
            // Active Record button
            Button(action: {}, label: {
                Text("Active\n Record")
                    .foregroundColor(Color.black)
                    .frame(width: 190, height: 80)
                    .background(Color(hex: "#A8DADC"))
                    .clipShape(Capsule())
                    .offset(x: -540, y: -950)
            })
            
            // Past Record button
            NavigationLink(destination: PatientView_PastRecords()) {
                Button(action: {
                    _ = PatientView_PastRecords()
                }, label: {
                    Text("Past\n Record")
                        .foregroundColor(Color.black)
                        .frame(width: 190, height: 80)
                        .background(Color.white)
                        .clipShape(Capsule())
                        .offset(x: -540, y: -920)
                })
            }
            
            // Patient Active Record
            Rectangle()
                .frame(width: 870, height: 230)
                .foregroundColor(Color(hex: "F1FAEE"))
                .overlay(
                    Text("\tDate: 07/30/2022\n\n\tPain Area: Left hand\n\n\tPain Description: Burn")
                        .font(.title)
                    , alignment: .leading)
                .overlay(
                    Button(action: {}, label: {
                    Text("Update")
                        .foregroundColor(Color.black)
                        .frame(width: 130, height: 40)
                        .background(Color.white)
                        .clipShape(Capsule())
                        .offset(x: 190, y: 70)
                })).overlay(Button(action: {}, label: {
                    Text("Remove")
                        .foregroundColor(Color.black)
                        .frame(width: 130, height: 40)
                        .background(Color.white)
                        .clipShape(Capsule())
                        .offset(x: 340, y: 70)
                })).offset(x: 130, y: -1120)
            
            // Add record button
            Circle()
                .frame(width: 180, height: 100)
                .foregroundColor(Color(hex: "F1FAEE"))
                .overlay(Button(action: {}, label: {
                    Image("Plus_Icon")
                        .resizable()
                        .frame(width: 60, height: 60)
                }))
                .offset(x: 130, y: -1100)
        }
    }
}

struct PatientView_HomePage_Previews: PreviewProvider {
    static var previews: some View {
        PatientView_HomePage()
    }
}
