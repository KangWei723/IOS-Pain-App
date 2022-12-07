//
//  AddNewRecordPage.swift
//  Pain App
//
//  Created by Jonathan Lim on 11/7/22.
//

import Amplify
import AmplifyPlugins
import SwiftUI
import SceneKit

struct AddNewRecordPage: View {
    enum PickerState: String, CaseIterable, Identifiable {
        case yes, no
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
    @State private var selectedPicker: PickerState = .yes
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
                            .padding(.leading, geoProxy.size.width * 0.0125)
                        Spacer()
                        Button(action: {
                                mainViewController.viewState = .painSliderPage
                            }, label: {
                                Text("Back")
                                    .foregroundColor(Color.black)
                                    .padding(.horizontal, 40.0)
                                    .padding(.vertical, 10)
                                    .background(Color.white)
                            })
                            .clipShape(RoundedRectangle(cornerRadius: 15))
                            .padding(.trailing, geoProxy.size.width * 0.05)
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
                                        SceneView(scene: SCNScene(named: "3D Model.scn"),
                                                  options: [.autoenablesDefaultLighting, .allowsCameraControl])
                                        .frame(width: geoProxy.size.width * 0.3, height: geoProxy.size.height * 0.65)
                                        .padding(.top, geoProxy.size.height * 0.05)

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
                                            Text("Would you like to report pain in another area?")
                                                .font(.system(size: 30))
                                                .padding()
                                                .frame(height: geoProxy2.size.height * 0.15)
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
                                                
                                            }
                                            .padding(.bottom, geoProxy2.size.height * 0.05)
                                            Spacer().frame(height: geoProxy2.size.height*0.3)
                                            Button {
                                                switch selectedPicker {
                                                case .no: mainViewController.viewState = .patientHome
                                                case .yes: mainViewController.viewState = .highlightAreaPage
                                                }
                                            } label: {
                                                HStack {
                                                    Text("Submit").font(.system(size: 30))
                                                        .foregroundColor(Color.black)
                                                }.frame(width: geoProxy2.size.width * 0.5, height: geoProxy2.size.height * 0.1)
                                            }.background(Color.init(hex: "457B9D"))
                                                .cornerRadius(15)
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

struct AddNewRecordPage_Previews: PreviewProvider {
    static var previews: some View {
        AddNewRecordPage()
    }
}
