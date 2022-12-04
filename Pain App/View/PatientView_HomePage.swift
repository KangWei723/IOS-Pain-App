//
//  PatientView_HomePage_Fix.swift
//  Pain App
//
//  Created by Jonathan Lim on 10/28/22.
//

import SwiftUI

struct PatientView_HomePage: View {
    @EnvironmentObject var mainViewController: MainViewController
    @EnvironmentObject var loginController: LoginController
    
    @State private var addRecord = false
    @State private var records = ["Test"]
    @State private var countRecord = 0
    
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
                                    Text("Welcome \(loginController.fname)").font(.system(size: 45))
                                    Spacer()
                                    Button {
                                        withAnimation(.default, {
                                            mainViewController.viewState = .patientProfile
                                        })
                                    } label: {
                                        HStack {
                                            Text("Profile").font(.system(size: 30))
                                                .foregroundColor(Color.black)
                                        }.frame(width: geoProxy2.size.width * 0.15, height: geoProxy2.size.height * 0.25)
                                    }.background(Color.white)
                                        .cornerRadius(10)
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
                                            mainViewController.viewState = .patientHome
                                        })
                                    } label: {
                                        HStack {
                                            Text("Active\n Records").font(.system(size: 30))
                                                .foregroundColor(Color.black)
                                        }.frame(width: geoProxy2.size.width * 0.7, height: geoProxy2.size.height * 0.13)
                                    }.background(Color.init(hex: "A8DADC"))
                                        .cornerRadius(15)
                                    Spacer()
                                }
                                Spacer().frame(height: 40)
                                HStack {
                                    Button {
                                        withAnimation(.default, {
                                            mainViewController.viewState = .patientPastRecords
                                        })
                                    } label: {
                                        HStack {
                                            Text("Past\n Records").font(.system(size: 30))
                                                .foregroundColor(Color.black)
                                        }.frame(width: geoProxy2.size.width * 0.7, height: geoProxy2.size.height * 0.13)
                                    }.background(Color.white)
                                        .cornerRadius(15)
                                }
                            }
                        })
                    Spacer()
                    Rectangle().fill(Color.white)
                        .frame(width: geoProxy.size.width*0.74, height: geoProxy.size.height)
                        .overlay(GeometryReader { geoProxy2 in
                            VStack {
                                    /*List {
                                        ForEach(records, id: \.self) { record in
                                            Text(record)
                                        }
                                    }.frame(width: geoProxy.size.width*0.75, height: geoProxy.size.height*0.6)*/
                                Spacer().frame(height: 50)
                                HStack {
                                    Spacer()
                                    Button {
                                        self.addRecord.toggle()
                                        mainViewController.viewState = .highlightAreaPage
                                    } label: {
                                        HStack {
                                            Image("Plus_Icon")
                                                .resizable()
                                                .frame(width: geoProxy2.size.width*0.06, height: geoProxy2.size.height*0.05)
                                        }.padding()
                                    }.background(Color.init(hex: "A8DADC"))
                                        .cornerRadius(15)
                                    Spacer()
                                    if addRecord {
                                       /* for record in records{
                                            RoundedRectangle(cornerRadius: 15)
                                                .frame(width: 50, height: 50)
                                                .foregroundColor(Color.red)
                                        } */
                                    }
                                }
                                Spacer()
                            }
                        })
                    Spacer()
                }
            }.ignoresSafeArea()
                    }
        
    }
}

struct PatientView_HomePage_Preview: PreviewProvider {
    static var previews: some View {
        PatientView_HomePage()
            .environmentObject(MainViewController())
    }
}
