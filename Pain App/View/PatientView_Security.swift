//
//  PatientView_Security.swift
//  Pain App
//
//  Created by Jonathan Lim on 10/10/22.
//

import SwiftUI

struct PatientView_Security: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @EnvironmentObject var mainViewController: MainViewController
    @EnvironmentObject var loginController: LoginController
    
    var body: some View {
        VStack {
            Group {
                Rectangle()
                    .frame(width: 1400, height: 150, alignment: .leading)
                    .foregroundColor(Color(hex: "#A8DADC"))
                    .overlay(Text("\t\tProfile").font(.title), alignment: .leading)
                    .overlay(Button(action: {
                            mainViewController.viewState = .patientHome
                        }, label: {
                            Text("Back")
                                .foregroundColor(Color.black)
                        })
                        .frame(width: 130, height: 40)
                        .background(Color.white)
                        .clipShape(RoundedRectangle(cornerRadius: 15))
                        .offset(x: 550, y: 40)
                    )
                    .offset(x: 10, y: -30)
                
                Rectangle()
                    .frame(width: 300, height: 900)
                    .foregroundColor(Color(hex: "F1FAEE"))
                    .offset(x: -550, y: -39)
                
                Button(action: {
                    mainViewController.viewState = .patientProfile
                }, label: {
                    Text("Edit Profile")
                        .foregroundColor(Color.black)
                })
                .frame(width: 190, height: 80)
                .background(Color.white)
                .clipShape(RoundedRectangle(cornerRadius: 15))
                .offset(x: -540, y: -900)
                
                Button(action: {
                    mainViewController.viewState = .patientSecurity
                }, label: {
                    Text("Security")
                        .foregroundColor(Color.black)
                })
                .frame(width: 190, height: 80)
                .background(Color(hex: "#A8DADC"))
                .clipShape(RoundedRectangle(cornerRadius: 15))
                .offset(x: -540, y: -870)
                
                Text("Security")
                    .font(.title)
                    .bold()
                    .offset(x: -280, y: -1080)
                
                Text("Email:")
                    .font(.title2)
                    .offset(x: -300, y: -1030)
                
                TextField("user01@example.com", text: $email)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .frame(width: 500, height: 10)
                    .offset(x: 80, y: -1060)
                
                Text("Password:")
                    .font(.title2)
                    .offset(x: -280, y: -1030)
                
                TextField("********", text: $password)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .frame(width: 500, height: 10)
                    .offset(x: 80, y: -1060)
            }
            Group {
                Button(action: {
                    
                }, label: {
                    Text("Save Changes")
                        .foregroundColor(Color.black)
                })
                .frame(width: 190, height: 80)
                .background(Color.white)
                .clipShape(RoundedRectangle(cornerRadius: 15))
                .offset(x: -540, y: -600)
                
                Button(action: {
                    loginController.signOutLocally()
                }, label: {
                    Text("Sign Out")
                        .foregroundColor(Color.black)
                })
                .frame(width: 190, height: 80)
                .background(Color.white)
                .clipShape(RoundedRectangle(cornerRadius: 15))
                .offset(x: -540, y: -580)
                
            }
            }.offset(x: 0, y: 290)
    }
}

struct PatientView_Security_Previews: PreviewProvider {
    static var previews: some View {
        PatientView_Security()
            .environmentObject(MainViewController())
            .environmentObject(LoginController(mainView: MainViewController()))
    }
}
