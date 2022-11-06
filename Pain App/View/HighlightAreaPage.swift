//
//  HighlightAreaPage.swift
//  Pain App
//
//  Created by Shrey Patel on 11/5/22.
//

import Amplify
import AmplifyPlugins
import SwiftUI

struct HighlightAreaPage: View {
    enum PickerState: String, CaseIterable, Identifiable {
        case front, back
        var id: Self { self }
    }
    
    enum AreaState: String {
        case lh
        case rh
        case ll
        case rl
        case none
    }
    
    @EnvironmentObject var mainViewController: MainViewController
    @State private var selectedPicker: PickerState = .front
    @State private var selectedArea: AreaState = .none
    
    init() {
        UISegmentedControl.appearance().selectedSegmentTintColor = UIColor(Color.init(hex: "A8DADC"))
        UISegmentedControl.appearance().backgroundColor = UIColor(Color.init(hex: "F1FAEE"))
        UISegmentedControl.appearance().setTitleTextAttributes(
            [
                .font: UIFont.systemFont(ofSize: 25)
            ], for: .normal)
        
    }
    
    var body: some View {
        GeometryReader { geoProxy in
            HStack {
                VStack {
                    HStack {
                        Text("Highlight the Painful Area")
                            .font(.system(size: 40))
                            .padding(20)
//                            .position(x: geoProxy.frame(in: .local).midX * 0.6, y: geoProxy.frame(in: .local).midY * 1)
                            .padding(.leading, geoProxy.size.width * 0.0125)
                        Spacer()
                        Button(action: {
                                mainViewController.viewState = .patientHome
                            }, label: {
                                Text("Back")
                                    .foregroundColor(Color.black)
                                    .padding(.horizontal, 40.0)
                                    .padding(.vertical, 10)
                                    .background(Color.white)
                            })
                            .clipShape(RoundedRectangle(cornerRadius: 15))
                            .padding(.trailing, geoProxy.size.width * 0.05)
//                            .position(x: geoProxy.frame(in: .local).maxX * 0.55, y: geoProxy.frame(in: .local).minY * 1)
//                            .offset(x: 550, y: 40)
                    }
                    .padding(0)
                    .padding(.top, geoProxy.size.height * 0.05)
                    .ignoresSafeArea()
                    .background(Color.init(hex: "A8DADC"))
                    
                    HStack {
                        Rectangle()
                            .fill(.white)
                            .frame(width: geoProxy.size.width * 0.5, height: geoProxy.size.height)
                            .overlay(
                                VStack {
                                    HStack {
                                        Spacer()
                                        Image("Zoom Out")
                                            .resizable()
                                            .frame(width: geoProxy.size.width * 0.03, height: geoProxy.size.height * 0.03)
                                            .padding(.trailing, 20)
                                        Image("3D Model Image")
                                            .resizable()
                                            .frame(width: geoProxy.size.width * 0.25, height: geoProxy.size.height * 0.65)
                                            .padding(.top, geoProxy.size.height * 0.05)
    //                                        .position(x: geoProxy.frame(in: .local).midX * 0.5, y: geoProxy.frame(in: .local).midY * 0.8)
                                        Image("Zoom In")
                                            .resizable()
                                            .frame(width: geoProxy.size.width * 0.03, height: geoProxy.size.height * 0.03)
                                            .padding(.leading, 20)
                                        Spacer()
                                    }
                                    HStack {
                                        Spacer()
                                        Image("Rotate with Lines")
                                            .resizable()
                                            .frame(width: geoProxy.size.width * 0.25, height: geoProxy.size.height * 0.06)
                                            .padding(.top, 0.0)
                                        Spacer()
                                    }
                                    .padding(.top, geoProxy.size.height * 0.05)
                                    Spacer()
                                }
                            )
                        Rectangle()
                            .fill(.white)
                            .frame(width: geoProxy.size.width * 0.5, height: geoProxy.size.height)
                            .overlay(
                                GeometryReader { geoProxy2 in
                                    HStack {
                                        Spacer()
                                        VStack {
                                            Text("Quck Actions")
                                                .font(.system(size: 30))
                                                .padding()
                                                .frame(height: geoProxy2.size.height * 0.05)
                                                .foregroundColor(.black)
                                            HStack {
                                                Picker("Selector", selection: $selectedPicker) {
                                                    ForEach(PickerState.allCases) { state in
                                                        Text(state.rawValue.capitalized)
                                                            .padding()
                                                            .foregroundColor(.black)
                                                            .foregroundStyle(Color.black)
                                                    }
                                                }
                                                .pickerStyle(.segmented)
                                                .frame(width: geoProxy2.size.width * 0.5, height: geoProxy2.size.height * 0.08)
                                                .padding()
                                                .shadow(color: .gray, radius: 6, x: 0, y: 0)
                                                .accentColor(.black)
                                                Text("View")
                                                    .font(.system(size: 25))
                                            }
                                            .padding(.bottom, geoProxy2.size.height * 0.05)
                                            Text("Zoom To Area")
                                                .font(.system(size: 25))
                                            
                                            Button {
                                                selectedArea = .lh
                                            } label: {
                                                Text("Left Hand")
                                                    .foregroundColor(.black)
                                                    .font(.system(size: 28))
                                                    .padding(20)
                                            }
                                            .frame(width: geoProxy2.size.width * 0.4, height: geoProxy2.size.height * 0.08)
                                            .background((selectedArea == .lh) ? Color.init(hex: "A8DADC") : Color.init(hex: "F1FAEE"))
                                            .cornerRadius(10)
                                            .padding(.top, geoProxy2.size.height * 0.02)
                                            .shadow(color: .gray, radius: 6, x: 0, y: 0)
                                            
                                            Button {
                                                selectedArea = .rh
                                            } label: {
                                                Text("Right Hand")
                                                    .foregroundColor(.black)
                                                    .font(.system(size: 28))
                                                    .padding(20)
                                            }
                                            .frame(width: geoProxy2.size.width * 0.4, height: geoProxy2.size.height * 0.08)
                                            .background((selectedArea == .rh) ? Color.init(hex: "A8DADC") : Color.init(hex: "F1FAEE"))
                                            .cornerRadius(10)
                                            .padding(.top, geoProxy2.size.height * 0.02)
                                            .shadow(color: .gray, radius: 6, x: 0, y: 0)
                                            
                                            Button {
                                                selectedArea = .ll
                                            } label: {
                                                Text("Left Leg")
                                                    .foregroundColor(.black)
                                                    .font(.system(size: 28))
                                                    .padding(20)
                                            }
                                            .frame(width: geoProxy2.size.width * 0.4, height: geoProxy2.size.height * 0.08)
                                            .background((selectedArea == .ll) ? Color.init(hex: "A8DADC") : Color.init(hex: "F1FAEE"))
                                            .cornerRadius(10)
                                            .padding(.top, geoProxy2.size.height * 0.02)
                                            .shadow(color: .gray, radius: 6, x: 0, y: 0)
                                            
                                            Button {
                                                selectedArea = .rl
                                            } label: {
                                                Text("Right Leg")
                                                    .foregroundColor(.black)
                                                    .font(.system(size: 28))
                                                    .padding(20)
                                            }
                                            .frame(width: geoProxy2.size.width * 0.4, height: geoProxy2.size.height * 0.08)
                                            .background((selectedArea == .rl) ? Color.init(hex: "A8DADC") : Color.init(hex: "F1FAEE"))
                                            .cornerRadius(10)
                                            .padding(.top, geoProxy2.size.height * 0.02)
                                            .shadow(color: .gray, radius: 6, x: 0, y: 0)
                                        }
                                        Spacer()
                                    }
                                }
                            )
                    }.padding(-4)
                }
            }
        }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .ignoresSafeArea()
            .background(.white)
            .foregroundColor(.black)
            .foregroundStyle(Color.black)
            .accentColor(.black)
            .padding(0)
    }
}

struct HighlightAreaPage_Previews: PreviewProvider {
    static var previews: some View {
        HighlightAreaPage()
    }
}
