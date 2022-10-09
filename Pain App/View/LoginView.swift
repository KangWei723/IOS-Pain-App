//
//  LoginView.swift
//  Pain App
//
//  Created by Shrey Patel on 10/8/22.
//

import SwiftUI

extension UISegmentedControl {
    override open func didMoveToSuperview() {
        super.didMoveToSuperview()
        self.setContentHuggingPriority(.defaultLow, for: .vertical)
    }
}

struct SuperCustomTextFieldStyle: TextFieldStyle {
    func _body(configuration: TextField<_Label>) -> some View {
        configuration
            .padding(20)
    }
}

struct LoginView: View {
    enum PickerState: String, CaseIterable, Identifiable {
        case login, signup
        var id: Self { self }
    }
    @State private var selectedPicker: PickerState = .login
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var confirmPassword: String = ""
    @State private var rememberMe: Bool = false
    @State private var fname: String = ""
    @State private var lname: String = ""
    @EnvironmentObject var loginController: LoginController
    
    init() {
        UISegmentedControl.appearance().selectedSegmentTintColor = UIColor(Color.init(hex: "A8DADC"))
        UISegmentedControl.appearance().backgroundColor = UIColor(Color.init(hex: "F1FAEE"))
        UISegmentedControl.appearance().setTitleTextAttributes(
            [
                .font: UIFont.systemFont(ofSize: 25)
            ], for: .normal)
        
    }
    
    private func toggle() {
        self.rememberMe = !self.rememberMe
    }
    
    var body: some View {
        GeometryReader { geoProxy in
            HStack {
                Rectangle()
                    .fill(Color.init(hex: "A8DADC"))
                    .frame(width: geoProxy.size.width * 0.4, height: geoProxy.size.height)
                    .overlay(
                        ZStack {
                            Image("Blob 2")
                                .padding()
                                .blur(radius: 40, opaque: false)
                                .position(x: geoProxy.frame(in: .local).midX * 0.6, y: geoProxy.frame(in: .local).midY * 1.2)
                            Image("Blob 3")
                                .padding()
                                .blur(radius: 90, opaque: false)
                                .position(x: geoProxy.frame(in: .local).midX * 0.3, y: geoProxy.frame(in: .local).midY * 0.8)
                            Image("Blob 1")
                                .padding()
                                .blur(radius: 70, opaque: false)
                                .position(x: geoProxy.frame(in: .local).midX * 0.46, y: geoProxy.frame(in: .local).midY * 0.755)
                            Image("Falling Male Cartoon")
                                .padding()
                        }
                    )
                Rectangle()
                    .fill(.white)
                    .frame(width: geoProxy.size.width * 0.6, height: geoProxy.size.height)
                    .overlay(
                        GeometryReader { geoProxy2 in
                            HStack {
                                Spacer()
                                VStack {
                                    Text("Welcome!")
                                        .font(.system(size: 30))
                                        .padding()
                                        .frame(height: geoProxy2.size.height * 0.05)
                                    
                                    Picker("Selector", selection: $selectedPicker) {
                                        ForEach(PickerState.allCases) { state in
                                            Text(state.rawValue.capitalized)
                                                .padding()
                                        }
                                    }
                                    .pickerStyle(.segmented)
                                    .frame(width: geoProxy2.size.width * 0.5, height: 65)
                                    .padding()
                                    .shadow(color: .gray, radius: 6, x: 0, y: 0)
                                    
                                    if selectedPicker == .signup {
                                        TextField("First Name", text: $fname)
                                            .foregroundColor(.black)
                                            .font(.system(size: 28))
                                            .textFieldStyle(SuperCustomTextFieldStyle())
                                            .background(Color.init(hex: "F1FAEE"))
                                            .frame(width: geoProxy2.size.width * 0.65)
                                            .cornerRadius(10)
                                            .shadow(color: .gray, radius: 6, x: 0, y: 0)
                                            .padding(.top, 10)
                                        
                                        TextField("Last Name", text: $lname)
                                            .foregroundColor(.black)
                                            .font(.system(size: 28))
                                            .textFieldStyle(SuperCustomTextFieldStyle())
                                            .background(Color.init(hex: "F1FAEE"))
                                            .frame(width: geoProxy2.size.width * 0.65)
                                            .cornerRadius(10)
                                            .shadow(color: .gray, radius: 6, x: 0, y: 0)
                                            .padding(.top, 30)
                                    }
                                    
                                    TextField("Email", text: $email)
                                        .foregroundColor(.black)
                                        .font(.system(size: 28))
                                        .textFieldStyle(SuperCustomTextFieldStyle())
                                        .background(Color.init(hex: "F1FAEE"))
                                        .frame(width: geoProxy2.size.width * 0.65)
                                        .cornerRadius(10)
                                        .shadow(color: .gray, radius: 6, x: 0, y: 0)
                                        .padding(.top, (selectedPicker == .signup) ? 30 : 70)
                                    
                                    SecureField("Password", text: $password)
                                        .foregroundColor(.black)
                                        .font(.system(size: 28))
                                        .textFieldStyle(SuperCustomTextFieldStyle())
                                        .background(Color.init(hex: "F1FAEE"))
                                        .frame(width: geoProxy2.size.width * 0.65)
                                        .cornerRadius(10)
                                        .shadow(color: .gray, radius: 6, x: 0, y: 0)
                                        .padding(.top, (selectedPicker == .signup) ? 30 : 70)
                                    
                                    if selectedPicker == .login {
                                        HStack {
                                            Button(action: toggle) {
                                                HStack {
                                                    Image(systemName: rememberMe ? "checkmark.square" : "square")
                                                        .foregroundColor(.gray)
                                                        .background(Color.init(hex: "F1FAEE"))
                                                    Text("Remember Me?")
                                                        .foregroundColor(.black)
                                                    
                                                }
                                            }
                                            Spacer()
                                            Button(action: {}) {
                                               Text("Forgot Password?")
                                                    .foregroundColor(.black)
                                                    .underline()
                                            }
                                        }
                                        .frame(width: geoProxy2.size.width * 0.65)
                                        .padding()
                                    } else {
                                        SecureField("Confirm Password", text: $confirmPassword)
                                            .foregroundColor(.black)
                                            .font(.system(size: 28))
                                            .textFieldStyle(SuperCustomTextFieldStyle())
                                            .background(Color.init(hex: "F1FAEE"))
                                            .frame(width: geoProxy2.size.width * 0.65)
                                            .cornerRadius(10)
                                            .shadow(color: .gray, radius: 6, x: 0, y: 0)
                                            .padding(.top, 30)
                                    }
                                    
                                    Button(action: {loginController.signUp(email: email, password: password)}) {
                                        Text((selectedPicker == .login ) ? "Login" : "Sign Up")
                                            .foregroundColor(.white)
                                            .font(.system(size: 28))
                                            .padding(20)
                                    }
                                    .frame(width: geoProxy2.size.width * 0.65)
                                    .background(Color.init(hex: "457B9D"))
                                    .cornerRadius(10)
                                    .padding(.top, 30)
                                }
                                .padding(.top, geoProxy2.size.height * 0.12)
                                Spacer()
                            }
                        }
                    )
            }
        }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .ignoresSafeArea()
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView().environmentObject(LoginController())
    }
}
