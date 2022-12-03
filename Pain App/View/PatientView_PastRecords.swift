//
//  PatientView_HomePage_Fix.swift
//  Pain App
//
//  Created by Jonathan Lim on 10/28/22.
//

import SwiftUI

struct PatientView_PastRecords: View {
    @EnvironmentObject var mainViewController: MainViewController
    
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
                                            mainViewController.viewState = .patientProfile
                                        })
                                    } label: {
                                        HStack {
                                            Text("Profile").font(.system(size: 30))
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
                                            mainViewController.viewState = .patientHome
                                        })
                                    } label: {
                                        HStack {
                                            Text("Active\n Records").font(.system(size: 30))
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
                                            mainViewController.viewState = .patientPastRecords
                                        })
                                    } label: {
                                        HStack {
                                            Text("Past\n Records").font(.system(size: 30))
                                                .foregroundColor(Color.black)
                                        }.frame(width: geoProxy2.size.width * 0.7, height: geoProxy2.size.height * 0.13)
                                    }.background(Color(hex: "#A8DADC"))
                                        .cornerRadius(15)
                                }
                            }
                        })
                        .padding(.bottom, geoProxy.size.height * -0.006)
                    Spacer()
                    Rectangle().fill(Color.white)
                        .frame(width: geoProxy.size.width*0.74, height: geoProxy.size.height)
                        .overlay(GeometryReader { geoProxy2 in
                            VStack {
                                Spacer().frame( height: geoProxy2.size.height*0.05)
                                HStack {
                                    Spacer()
                                    Rectangle().fill(Color.init(hex: "F1FAEE"))
                                        .overlay(GeometryReader { geoProxy3 in
                                            
                                            VStack {
                                                        Spacer().frame(height: geoProxy3.size.height*0.1)
                                                        Text("\tDate: 06/20/2022")
                                                            .font(.title)
                                                    }
                                                    
                                                    VStack {
                                                        Spacer().frame(height: geoProxy3.size.height*0.4)
                                                        Text("\tPain Area: Left hand").font(.title)
                                                    }
                                                    VStack {
                                                        Spacer().frame(height: geoProxy3.size.height*0.7)
                                                        Text("\tPain Description: Burn")
                                                            .font(.title)
                                                    }
                                            HStack {
                                                Spacer().frame(width: geoProxy3.size.width*0.75)
                                                VStack {
                                                    Spacer().frame(height: geoProxy3.size.height*0.7)
                                                    Button {} label: {
                                                        Text("View")
                                                            .foregroundColor(Color.black)
                                                            .frame(width: 130, height: 40)
                                                            .background(Color.white)
                                                            .clipShape(RoundedRectangle(cornerRadius: 15))
                                                    }
                                                }
                                            }
                                            
                                        })
                                        .frame(width: geoProxy2.size.width*0.8, height: geoProxy2.size.height*0.2)
                                    Spacer()
                                }
                            }
                        })
                }
            }.ignoresSafeArea()
        }
    }
}

struct PatientView_PastRecords_Preview: PreviewProvider {
    static var previews: some View {
        PatientView_PastRecords()
            .environmentObject(MainViewController())
    }
}
