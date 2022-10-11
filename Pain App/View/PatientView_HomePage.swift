//
//  PatientView_HomePage.swift
//  Pain App
//
//  Created by Jonathan Lim on 10/8/22.
//

import SwiftUI

struct PatientView_HomePage: View {
    @EnvironmentObject var mainViewController: MainViewController
    
    var body: some View {
            // Header
        VStack {
                Rectangle().frame(width: 1400, height: 150, alignment: .leading)
                    .foregroundColor(Color(hex: "#A8DADC")).overlay(
                        Text("\t\tWelcome User01").font(.title), alignment: .leading)
                    .offset(x: 10, y: 300)
                
                // Profile Button
                Button(action: {
                    withAnimation(.default, {
                        mainViewController.viewState = .patientProfile
                    })
                }, label: {
                    Text("Profile")
                        .foregroundColor(Color.black)
                })
                .frame(width: 130, height: 40)
                .background(Color.white)
                .clipShape(RoundedRectangle(cornerRadius: 15))
                .offset(x: 550, y: 220)
                
                // Left tab background
                Rectangle()
                    .frame(width: 300, height: 900)
                    .foregroundColor(Color(hex: "F1FAEE"))
                    .offset(x: -550, y: 245)
                
                // Active Record button
                Button(action: {
                    mainViewController.viewState = .patientHome
                }, label: {
                    Text("Active\n Record")
                        .foregroundColor(Color.black)
                        
                })
                .frame(width: 190, height: 80)
                .background(Color(hex: "#A8DADC"))
                .clipShape(RoundedRectangle(cornerRadius: 15))
                .offset(x: -540, y: -620)
                
                // Past Record button
                Button(action: {
                    mainViewController.viewState = .patientPastRecords
                }, label: {
                    Text("Past\n Record")
                        .foregroundColor(Color.black)
                })
                .frame(width: 190, height: 80)
                .background(Color.white)
                .clipShape(RoundedRectangle(cornerRadius: 15))
                .offset(x: -540, y: -590)
                
                Rectangle()
                    .frame(width: 870, height: 230)
                    .foregroundColor(Color(hex: "F1FAEE"))
                    .overlay(
                        Text("\tDate: 07/30/2022\n")
                            .font(.title)
                            .offset(x: 0, y: -60), alignment: .leading)
                    .overlay(
                        Text("\tPain Area: Left hand")
                            .font(.title)
                            .offset(x: 0, y: 0), alignment: .leading)
                    .overlay(
                        Text("\tPain Description: Burn")
                            .font(.title)
                            .offset(x: 0, y: 70), alignment: .leading)
                    .overlay(
                        Button(action: {}, label: {
                            Text("Update")
                                .foregroundColor(Color.black)
                                
                        })
                        .frame(width: 130, height: 40)
                        .background(Color.white)
                        .clipShape(RoundedRectangle(cornerRadius: 15))
                        .offset(x: 190, y: 70)
                    ).overlay(Button(action: {}, label: {
                            Text("Remove")
                                .foregroundColor(Color.black)
                        })
                        .frame(width: 130, height: 40)
                        .background(Color.white)
                        .clipShape(RoundedRectangle(cornerRadius: 15))
                        .offset(x: 340, y: 70)
                    ).offset(x: 130, y: -790)
                
                Circle()
                    .frame(width: 180, height: 100)
                    .foregroundColor(Color(hex: "F1FAEE"))
                    .overlay(Button(action: {}, label: {
                        Image("Plus_Icon")
                            .resizable()
                            .frame(width: 60, height: 60)
                    }))
                    .offset(x: 130, y: -750)
        }
    }
}

struct PatientView_HomePage_Previews: PreviewProvider {
    static var previews: some View {
        PatientView_HomePage()
            .environmentObject(MainViewController())
    }
}
