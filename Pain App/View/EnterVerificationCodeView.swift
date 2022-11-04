//
//  EnterVerificationCodeView.swift
//  Pain App
//
//  Created by Elijah Yates on 10/24/22.
//

import SwiftUI

class TextBindingManager: ObservableObject {
    @Published var code: String = "" {
        didSet {
            if code.count > characterLimit && oldValue.count <= characterLimit {
                code = oldValue
            }
        }
    }
    let characterLimit: Int

    init(limit: Int = 6) {
        characterLimit = limit
    }
}

struct EnterVerificationCodeView: View {
  
    @State private var code: String = ""
    @ObservedObject var textBindingManager = TextBindingManager(limit: 6)
    
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
                                    
                                    Text("Enter the code from ThePainApp sent to:")
                                        .font(.largeTitle)
                                    Spacer()
                                    Spacer()
                                    TextField("", text: $textBindingManager.code)
                                        .foregroundColor(.black)
                                        .font(.system(size: 28))
                                        .textFieldStyle(SuperCustomTextFieldStyle())
                                        .background(Color.init(hex: "F1FAEE"))
                                        .cornerRadius(10)
                                        .frame(width: geoProxy2.size.width * 0.2, height: geoProxy2.size.height * 0.25)
                                        .shadow(color: .gray, radius: 6, x: 0, y: 0)
                                        .accentColor(.black)
                                        .foregroundStyle(Color.black)
                                                                                    
                                    Spacer()
                                    Spacer()
                                    
                                    Text("Click the verify button to verify your confirmation number")
                                        .font(.largeTitle)
                                        .multilineTextAlignment(.center)
                                    Spacer()
                                    
                                }
                                Spacer()
                                
                            }
                            Spacer()
                            
                        }
                        )
                Spacer()
                Button {
                
                } label: {
                    Text("Verify")
                        .font(.largeTitle)
                        .foregroundColor(Color.white)
                        .frame(width: geoProxy.size.width * 0.3, height: geoProxy.size.height * 0.075)
                    
                }
                .background(Color.init(hex: "457B9D"))
                .cornerRadius(10)
                .shadow(color: .gray, radius: 6, x: 0, y: 0)
                .padding(.bottom, geoProxy.size.height * 0.12)
            }
            
            Spacer()
            
        }
        .ignoresSafeArea()
    }
}

struct EnterVerificationCodeView_Previews: PreviewProvider {
    static var previews: some View {
        EnterVerificationCodeView()
    }
}
