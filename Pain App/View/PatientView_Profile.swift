//
//  PatientView_Profile.swift
//  Pain App
//
//  Created by Jonathan Lim on 10/9/22.
//

import SwiftUI

struct PatientView_Profile: View {
    @State private var firstName: String = ""
    @State private var lastName: String = ""
    @State private var dateOfBirth: String = ""
    @State private var sex: String = ""
    @State private var age: String = ""
    @State private var state: String = ""
    @State private var city: String = ""
    @State private var country: String = ""
    @State private var phNumber: String = ""
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
                    .ignoresSafeArea()
                
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
                .background(Color(hex: "#A8DADC"))
                .clipShape(RoundedRectangle(cornerRadius: 15))
                .offset(x: -540, y: -900)
                
                Button(action: {
                    mainViewController.viewState = .patientSecurity
                }, label: {
                    Text("Security")
                        .foregroundColor(Color.black)
                })
                .frame(width: 190, height: 80)
                .background(Color.white)
                .clipShape(RoundedRectangle(cornerRadius: 15))
                .offset(x: -540, y: -870)
                
                Text("Personal Infomation")
                    .font(.title)
                    .bold()
                    .offset(x: -200, y: -1080)
            }
            
            Group {
                Text("First Name:")
                    .font(.title2)
                    .offset(x: -270, y: -1030)
                
                TextField("Jane", text: $firstName)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .foregroundColor(Color(hex: "F1FAEE"))
                    .frame(width: 500, height: 10)
                    .offset(x: 80, y: -1060)
                
                Text("Last Name:")
                    .font(.title2)
                    .offset(x: -270, y: -1030)
                
                TextField("Dose", text: $firstName)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .frame(width: 500, height: 10)
                    .offset(x: 80, y: -1060)
                
                Text("Date of Birth:")
                    .font(.title2)
                    .offset(x: -262, y: -1030)
                
                TextField("07/30/2000", text: $dateOfBirth)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .frame(width: 500, height: 10)
                    .offset(x: 80, y: -1060)
                
                Text("Age:")
                    .font(.title2)
                    .offset(x: -303, y: -1030)
                
                TextField("30", text: $age)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .frame(width: 500, height: 10)
                    .offset(x: 80, y: -1060)
            }
            
            Group {
                Text("Address Infomation")
                    .font(.title)
                    .bold()
                    .offset(x: -200, y: -1010)
                
                Text("State:")
                    .font(.title2)
                    .offset(x: -295, y: -960)
                
                TextField("Ohio", text: $state)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .frame(width: 500, height: 10)
                    .offset(x: 80, y: -990)
                
                Text("City:")
                    .font(.title2)
                    .offset(x: -300, y: -960)
                
                TextField("Columbus", text: $city)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .frame(width: 500, height: 10)
                    .offset(x: 80, y: -990)
                
                Text("Country:")
                    .font(.title2)
                    .offset(x: -280, y: -960)
                
                TextField("United States", text: $country)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .frame(width: 500, height: 10)
                    .offset(x: 80, y: -990)
            }
            
            Group {
                Text("Contact Infomation")
                    .font(.title)
                    .bold()
                    .offset(x: -200, y: -930)
                
                Text("Phone Number:")
                    .font(.title2)
                    .offset(x: -250, y: -900)
                
                TextField("5132900314", text: $phNumber)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .frame(width: 500, height: 10)
                    .offset(x: 80, y: -930)
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
                .offset(x: -540, y: -1100)
                
                Button(action: {
                    loginController.signOutLocally()
                }, label: {
                    Text("Sign Out")
                        .foregroundColor(Color.black)
                })
                .frame(width: 190, height: 80)
                .background(Color.white)
                .clipShape(RoundedRectangle(cornerRadius: 15))
                .offset(x: -540, y: -1080)
            }
            
        }.offset(x: 0, y: 520)
            .ignoresSafeArea()
    }
}

struct PatientView_Profile_Previews: PreviewProvider {
    static var previews: some View {
        PatientView_Profile()
            .environmentObject(MainViewController())
            .environmentObject(LoginController())
    }
}
