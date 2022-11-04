//
//  Patient_Questionaire.swift
//  Pain App
//
//  Created by Elijah Yates on 10/10/22.
//

import SwiftUI

struct Patient_Questionaire: View {
    
    @State private var age: String = ""
    @State private var dob: String = ""
    @State private var city: String = ""
    @State private var state: String = ""
    @State private var pnumber: String = ""
    @State private var country: String = ""
    @EnvironmentObject var loginController: LoginController
    
    var body: some View {
        GeometryReader { geoProxy in
            VStack {
//                HStack {
                    
            // Rectangle holding the prompt for users to enter info
                Rectangle()
                    .fill(Color.init(hex: "A8DADC"))
                    .frame(width: geoProxy.size.width, height: geoProxy.size.height * 0.15)
                    .overlay(
                        Text("Please Enter Your Information Below to Complete Registration").font(.largeTitle)
                    
                    )
                    .padding(.bottom, geoProxy.size.height * 0.05)
                
                Rectangle()
                    .fill(Color.white)
                    .frame(width: geoProxy.size.width * 0.8, height: geoProxy.size.height * 0.5)
                    .overlay(
                        GeometryReader { geoProxy2 in
                            
                            HStack {
                                Spacer()
                                VStack {
                                    Text("Date of Birth")
                                        .font(.largeTitle)
                                    
                                    TextField("Date of Birth", text: $dob)
                                        .foregroundColor(.black)
                                        .font(.system(size: 28))
                                        .textFieldStyle(SuperCustomTextFieldStyle())
                                        .background(Color.init(hex: "F1FAEE"))
                                        .cornerRadius(10)
                                        .frame(width: geoProxy2.size.width * 0.3, height: geoProxy2.size.height * 0.25)
                                        .shadow(color: .gray, radius: 6, x: 0, y: 0)
                                        .accentColor(.black)
                                        .foregroundStyle(Color.black)
                                    
                                    Text("State")
                                        .font(.largeTitle)
                                        .frame(width: geoProxy2.size.width * 0.3, height: geoProxy2.size.height * 0.1)
                                    
                                    TextField("State", text: $state)
                                        .foregroundColor(.black)
                                        .font(.system(size: 28))
                                        .textFieldStyle(SuperCustomTextFieldStyle())
                                        .background(Color.init(hex: "F1FAEE"))
                                        .cornerRadius(10)
                                        .frame(width: geoProxy2.size.width * 0.3, height: geoProxy2.size.height * 0.25)
                                        .shadow(color: .gray, radius: 6, x: 0, y: 0)
                                        .accentColor(.black)
                                        .foregroundStyle(Color.black)
                                    
                                    Text("Phone Number")
                                        .font(.largeTitle)
                                        .frame(width: geoProxy2.size.width * 0.3, height: geoProxy2.size.height * 0.1)
                                    
                                    // Not sure if we will want this anymore 
                                    TextField("Phone Number", text: $pnumber)
                                        .foregroundColor(.black)
                                        .font(.system(size: 28))
                                        .textFieldStyle(SuperCustomTextFieldStyle())
                                        .background(Color.init(hex: "F1FAEE"))
                                        .cornerRadius(10)
                                        .frame(width: geoProxy2.size.width * 0.3, height: geoProxy2.size.height * 0.25)
                                        .shadow(color: .gray, radius: 6, x: 0, y: 0)
                                        .accentColor(.black)
                                        .foregroundStyle(Color.black)
                                    
                                }
                                
                                Spacer()
                                Spacer()
                                VStack {
                                    Text("Age")
                                        .font(.largeTitle)
                                        .frame(width: geoProxy2.size.width * 0.3, height: geoProxy2.size.height * 0.1)
                                    
                                    TextField("Age", text: $age)
                                        .foregroundColor(.black)
                                        .font(.system(size: 28))
                                        .textFieldStyle(SuperCustomTextFieldStyle())
                                        .background(Color.init(hex: "F1FAEE"))
                                        .cornerRadius(10)
                                        .frame(width: geoProxy2.size.width * 0.3, height: geoProxy2.size.height * 0.25)
                                        .shadow(color: .gray, radius: 6, x: 0, y: 0)
                                        .accentColor(.black)
                                        .foregroundStyle(Color.black)
                                    
                                    Text("City")
                                        .font(.largeTitle)
                                        .frame(width: geoProxy2.size.width * 0.3, height: geoProxy2.size.height * 0.1)
                                    
                                    TextField("City", text: $city)
                                        .foregroundColor(.black)
                                        .font(.system(size: 28))
                                        .textFieldStyle(SuperCustomTextFieldStyle())
                                        .background(Color.init(hex: "F1FAEE"))
                                        .cornerRadius(10)
                                        .frame(width: geoProxy2.size.width * 0.3, height: geoProxy2.size.height * 0.25)
                                        .shadow(color: .gray, radius: 6, x: 0, y: 0)
                                        .accentColor(.black)
                                        .foregroundStyle(Color.black)
                                    
                                    Text("Country")
                                        .font(.largeTitle)
                                        .frame(width: geoProxy2.size.width * 0.3, height: geoProxy2.size.height * 0.1)
                                    
                                    TextField("Country", text: $city)
                                        .foregroundColor(.black)
                                        .font(.system(size: 28))
                                        .textFieldStyle(SuperCustomTextFieldStyle())
                                        .background(Color.init(hex: "F1FAEE"))
                                        .cornerRadius(10)
                                        .frame(width: geoProxy2.size.width * 0.3, height: geoProxy2.size.height * 0.25)
                                        .shadow(color: .gray, radius: 6, x: 0, y: 0)
                                        .accentColor(.black)
                                        .foregroundStyle(Color.black)
                                    
                                }
                                Spacer()
                            }
     
                        }
                    
                    )
                // Spacer for the button
                Spacer(minLength: 125)
                // The button that will send them to the next view
                Button {
                    loginController.signIn(email: loginController.email, password: loginController.password)
                } label: {
                    Text("Complete Registration")
                        .font(.largeTitle)
                        .foregroundColor(Color.white)
                        .frame(width: geoProxy.size.width * 0.3, height: geoProxy.size.height * 0.075)
                    
                }
                .background(Color.init(hex: "457B9D"))
                .cornerRadius(10)
                .shadow(color: .gray, radius: 6, x: 0, y: 0)
                .padding(.bottom, geoProxy.size.height * 0.12)
                
            }
            
        }
        .ignoresSafeArea()
    }
}

struct Patient_Questionaire_Previews: PreviewProvider {
    static var previews: some View {
        Patient_Questionaire()
            .environmentObject(LoginController())
    }
}
