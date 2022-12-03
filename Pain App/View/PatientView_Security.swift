//
//  PatientView_HomePage_Fix.swift
//  Pain App
//
//  Created by Jonathan Lim on 10/28/22.
//

import SwiftUI

struct PatientView_Security: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @EnvironmentObject var mainViewController: MainViewController
    @EnvironmentObject var loginController: LoginController
    
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
                    .padding(.bottom, geoProxy.size.height * -0.006)
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
                                    }.background(Color.white)
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
                                    }.background(Color(hex: "#A8DADC"))
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
                                                Text("Security").font(.title).bold()
                                            }
                                            HStack {
                                                Text("Email:")
                                                    .font(.title2)
                                                TextField("user01@example.com", text: $email)
                                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                                                    .frame(width: 500, height: 10)
                                            }
                                            HStack {
                                                Text("Password:")
                                                    .font(.title2)
                                                TextField("********", text: $password)
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

struct PatientView_Security_Preview: PreviewProvider {
    static var previews: some View {
        PatientView_Security()
            .environmentObject(MainViewController())
            .environmentObject(LoginController(mainView: MainViewController()))
    }
}
