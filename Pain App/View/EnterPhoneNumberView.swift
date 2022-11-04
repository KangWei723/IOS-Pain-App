//
//  EnterPhoneNumberView.swift
//  Pain App
//
//  Created by Elijah Yates on 10/24/22.
//

import SwiftUI

struct EnterPhoneNumberView: View {
    
    @State private var number: String = ""
    
    var body: some View {
        GeometryReader { geoProxy in
            VStack {
    // Rectangle holding the prompt for users to enter info
                Rectangle()
                    .fill(Color.init(hex: "A8DADC"))
                    .frame(width: geoProxy.size.width, height: geoProxy.size.height * 0.15)
                    .padding(.bottom, geoProxy.size.height * 0.05)
                
                Rectangle()
                    .fill(Color.white)
                    .frame(width: geoProxy.size.width * 0.8, height: geoProxy.size.height * 0.5)
                    .overlay(
                        GeometryReader { geoProxy2 in
                            Spacer()
                            HStack {
                                
                                Spacer()
                                VStack {
                                    Spacer()
                                    Text("Enter your phone number to recieve a verification number")
                                        .font(.largeTitle)
                                    Spacer()
                                    
                                    TextField("Phone Number", text: $number)
                                        .foregroundColor(.black)
                                        .font(.system(size: 28))
                                        .textFieldStyle(SuperCustomTextFieldStyle())
                                        .background(Color.init(hex: "F1FAEE"))
                                        .cornerRadius(10)
                                        .frame(width: geoProxy2.size.width * 0.6, height: geoProxy2.size.height * 0.25)
                                        .shadow(color: .gray, radius: 6, x: 0, y: 0)
                                        .accentColor(.black)
                                        .foregroundStyle(Color.black)
                                    Spacer()
                                    Spacer()
                                    Text("Click the Send Verification Code button to get code to login")
                                        .font(.largeTitle)
                                    Spacer()
                                    
                                }
                                Spacer()
                                
                            }
                        }
                        )
                Button {
                
                } label: {
                    Text("Send Verification Code")
                        .font(.largeTitle)
                        .foregroundColor(Color.white)
                        .frame(width: geoProxy.size.width * 0.3, height: geoProxy.size.height * 0.075)
                    
                }
                .background(Color.init(hex: "457B9D"))
                .cornerRadius(10)
                .shadow(color: .gray, radius: 6, x: 0, y: 0)
                .padding(.bottom, geoProxy.size.height * 0.12)
                
            }
            .ignoresSafeArea()
        }
    }
}

struct EnterPhoneNumberView_Previews: PreviewProvider {
    static var previews: some View {
        EnterPhoneNumberView()
    }
}
