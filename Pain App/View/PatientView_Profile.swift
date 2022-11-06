//
//  PatientView_HomePage_Fix.swift
//  Pain App
//
//  Created by Jonathan Lim on 10/28/22.
//

import SwiftUI

struct PatientView_Profile: View {
    @EnvironmentObject var mainViewController: MainViewController
    @EnvironmentObject var loginController: LoginController
    @State private var firstName: String = ""
    @State private var lastName: String = ""
    @State private var dateOfBirth: String = ""
    @State private var sex: String = ""
    @State private var age: String = ""
    @State private var state: String = ""
    @State private var city: String = ""
    @State private var country: String = ""
    @State private var phNumber: String = ""
    
    var body: some View {
        // Header
        GeometryReader { geoProxy in
            VStack {
                Rectangle()
                    .fill(Color.init(hex: "A8DADC"))
                    .frame(width: geoProxy.size.width, height: geoProxy.size.height*0.2)
                    .overlay(
                        GeometryReader { geoProxy2 in
                            VStack {
                                Spacer()
                                HStack {
                                    Spacer().frame(width: 50)
                                    Text("Welcome User01").font(.system(size: 45))
                                    Spacer()
                                    Button {
                                        withAnimation(.default, {
                                            mainViewController.viewState = .patientHome
                                        })
                                    } label: {
                                        HStack {
                                            Text("Back").font(.system(size: 30))
                                                .foregroundColor(Color.black)
                                        }.frame(width: geoProxy2.size.width * 0.15, height: geoProxy2.size.height * 0.25)
                                    }.background(Color.white)
                                        .cornerRadius(15)
                                    Spacer().frame(width: 50)
                                }
                                Spacer()
                            }
                        })
                HStack {
                    Rectangle()
                        .fill(Color.init(hex: "F1FAEE"))
                        .frame(width: geoProxy.size.width*0.24, height: geoProxy.size.height)
                        .overlay(GeometryReader { geoProxy2 in
                            VStack {
                                Spacer().frame(height: 40)
                                HStack {
                                    Spacer()
                                    Button {
                                        withAnimation(.default, {
                                            mainViewController.viewState = .patientProfile
                                        })
                                    } label: {
                                        HStack {
                                            Text("Edit\nProfile").font(.system(size: 30))
                                                .foregroundColor(Color.black)
                                        }.frame(width: geoProxy2.size.width * 0.7, height: geoProxy2.size.height * 0.13)
                                    }.background(Color(hex: "#A8DADC"))
                                        .cornerRadius(15)
                                    Spacer()
                                }
                                Spacer().frame(height: 40)
                                HStack {
                                    Button {
                                        withAnimation(.default, {
                                            mainViewController.viewState = .patientSecurity
                                        })
                                    } label: {
                                        HStack {
                                            Text("Security").font(.system(size: 30))
                                                .foregroundColor(Color.black)
                                        }.frame(width: geoProxy2.size.width * 0.7, height: geoProxy2.size.height * 0.13)
                                    }.background(Color.white)
                                        .cornerRadius(15)
                                }
                                Spacer()
                                HStack {
                                    Button {
                                        withAnimation(.default, {
                                        })
                                    } label: {
                                        HStack {
                                            Text("Save\nChanges").font(.system(size: 30))
                                                .foregroundColor(Color.black)
                                        }.frame(width: geoProxy2.size.width * 0.7, height: geoProxy2.size.height * 0.13)
                                    }.background(Color.white)
                                        .cornerRadius(15)
                                }
                                Spacer().frame(height: 40)
                                HStack {
                                    Button {
                                        withAnimation(.default, {
                                            loginController.signOutLocally()
                                        })
                                    } label: {
                                        HStack {
                                            Text("Sign\nOut").font(.system(size: 30))
                                                .foregroundColor(Color.black)
                                        }.frame(width: geoProxy2.size.width * 0.7, height: geoProxy2.size.height * 0.13)
                                    }.background(Color.white)
                                        .cornerRadius(15)
                                }
                                Spacer().frame(height: geoProxy2.size.height * 0.21)
                            }
                        })
                    Spacer()
                    HStack {
                        Rectangle()
                            .fill(Color.white)
                            .frame(width: geoProxy.size.width*0.7, height: geoProxy.size.height)
                            .overlay(
                                GeometryReader { _ in
                                    
                                    VStack {
                                        Group {
                                            Spacer().frame(height: geoProxy.size.height*0.03)
                                            HStack {
                                                Text("Personal Infomation").font(.title).bold()
                                            }
                                            HStack {
                                                Text("First Name:")
                                                    .font(.title2)
                                                    .frame(alignment: .leading)
                                                
                                                TextField("Jane", text: $firstName)
                                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                                                    .foregroundColor(Color(hex: "F1FAEE"))
                                                    .frame(width: 500, height: 10)
                                            }
                                            HStack {
                                                Text("Last Name:")
                                                    .font(.title2)
                                                
                                                TextField("Dose", text: $lastName)
                                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                                                    .frame(width: 500, height: 10)
                                            }
                                            HStack {
                                                Text("Date of Birth:")
                                                    .font(.title2).frame(alignment: .leading)
                                                
                                                TextField("07/30/2000", text: $dateOfBirth)
                                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                                                    .frame(width: 500, height: 10)
                                            }
                                            HStack {
                                                Text("Age:")
                                                    .font(.title2).frame(alignment: .leading)
                                                
                                                TextField("30", text: $age)
                                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                                                    .frame(width: 500, height: 10)
                                            }
                                        }
                                        Group {
                                            Spacer().frame(height: geoProxy.size.height*0.05)
                                            HStack {
                                                Text("Address Infomation")
                                                    .font(.title)
                                                    .bold()
                                            }
                                            HStack {
                                                Text("State:")
                                                    .font(.title2)
                                                
                                                TextField("Ohio", text: $state)
                                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                                                    .frame(width: 500, height: 10)
                                            }
                                            HStack {
                                                Text("City:")
                                                    .font(.title2)
                                                
                                                TextField("Columbus", text: $city)
                                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                                                    .frame(width: 500, height: 10)
                                            }
                                            HStack {
                                                Text("Country:")
                                                    .font(.title2)
                                                
                                                TextField("United States", text: $country)
                                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                                                    .frame(width: 500, height: 10)
                                            }
                                        }
                                        Group {
                                            Spacer().frame(height: geoProxy.size.height*0.05)
                                            HStack {
                                                Text("Contact Infomation")
                                                    .font(.title)
                                                    .bold()
                                            }
                                            HStack {
                                                Text("Phone Number:")
                                                    .font(.title2)
                                                
                                                TextField("5132900314", text: $phNumber)
                                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                                                    .frame(width: 500, height: 10)
                                            }
                                        }
                                    }
                                        
                                        Spacer()
                                    
                                })
                    }
                }
            }.ignoresSafeArea()
        }
    }
}

struct PatientView_Profile_Preview: PreviewProvider {
    static var previews: some View {
        PatientView_Profile()
            .environmentObject(MainViewController())
            .environmentObject(LoginController(mainView: MainViewController()))
    }
}
