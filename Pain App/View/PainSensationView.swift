//
//  PainSensationView.swift
//  Pain App
//
//  Created by Darshit Vachhani on 11/5/22.
//

import SwiftUI

struct PainSensationView: View {

    @EnvironmentObject var mainViewController: MainViewController
    @State private var selectedPicker: PickerState = .surface
    @State var sensations: [Sensations] = [Sensations(name: Image("Burning") ),
                                            Sensations(name: Image("Shooting")),
                                            Sensations(name: Image("Other")),
                                            Sensations(name: Image("Throbbing")),
                                            Sensations(name: Image("Pain")),
                                            Sensations(name: Image("Pinch")),
                                            Sensations(name: Image("Pins&Needles")),
                                            Sensations(name: Image("Crushing")),
                                            Sensations(name: Image("Stabbing")),
                                            Sensations(name: Image("Cramping")),
                                            Sensations(name: Image("Bite")),
                                            Sensations(name: Image("Stinging")),
                                            Sensations(name: Image("Tearing")),
                                            Sensations(name: Image("Tingling")),
                                            Sensations(name: Image("Movement")),
                                            Sensations(name: Image("Itching")),
                                            Sensations(name: Image("Stitching")),
                                            Sensations(name: Image("Flushing")),
                                            Sensations(name: Image("Perforating")),
                                            Sensations(name: Image("Tremor")),
                                            Sensations(name: Image("Cooling")),
                                            Sensations(name: Image("Pressure")),
                                            Sensations(name: Image("Spasm")),
                                            Sensations(name: Image("Pulling"))]
    init() {
        UISegmentedControl.appearance().selectedSegmentTintColor = UIColor(Color.init(hex: "A8DADC"))
        UISegmentedControl.appearance().backgroundColor = UIColor(Color.init(hex: "F1FAEE"))
        UISegmentedControl.appearance().setTitleTextAttributes(
            [
                .font: UIFont.systemFont(ofSize: 25)
            ], for: .normal)

    }

    enum PickerState: String, CaseIterable, Identifiable {
        case surface, inside
        var id: Self { self }
    }

    private func getLeft(index: Int, total: Int) -> Int {
        let left = total - index
        var rv = 0
        if left >= 3 {
            rv = 0
        } else if left == 2 {
            rv = 1
        } else if left == 1 {
            rv = 2
        } else if left == 0 {
            rv = 3
        }
        return rv
    }

    var body: some View {
        GeometryReader { geoProxy in
            VStack {
                HStack {
                    VStack {
                        Text("Please select the appropriate sensations and then select next")
                            .font(.system(size: 30))
                            .padding()
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    
                    Button(action: {
                            mainViewController.viewState = .highlightAreaPage
                        }, label: {
                            Text("Back")
                                .foregroundColor(Color.black)
                                .padding(.horizontal, 40.0)
                                .padding(.vertical, 10)
                                .background(Color.white)
                        })
                        .clipShape(RoundedRectangle(cornerRadius: 15))
                    
                    Button(action: {
                        mainViewController.viewState = .highlightAreaPage
                        }, label: {
                            Text("Next")
                                .foregroundColor(Color.black)
                                .padding(.horizontal, 40.0)
                                .padding(.vertical, 10)
                                .background(Color.white)
                        })
                        .clipShape(RoundedRectangle(cornerRadius: 15))
                    Spacer()
                }
                .padding(30)
                
                .background(Color.init(hex: "A8DADC"))
                
                HStack {
                    Rectangle()
                        .fill(.white)
                        .frame(width: geoProxy.size.width * 0.30, height: geoProxy.size.height)
                        .overlay(
                            VStack {
                                Spacer()
                                HStack {
                                    Spacer()
                                    Picker("Selector", selection: $selectedPicker) {
                                        ForEach(PickerState.allCases) { state in
                                            Text(state.rawValue.capitalized)
                                                .padding()
                                                .foregroundColor(.black)
                                                .foregroundStyle(Color.black)
                                        }
                                    }
                                    .pickerStyle(.segmented)
                                    .frame(width: geoProxy.size.width * 0.2, height: geoProxy.size.height * 0.08)
                                    .padding(.bottom, geoProxy.size.height * 0.25)
                                    .shadow(color: .gray, radius: 6, x: 0, y: 0)
                                    .accentColor(.black)
                                    Spacer()
                                }
                                Spacer()
                            }
                        )

                    Rectangle()
                        .fill(.white)
                        .frame(width: geoProxy.size.width * 0.7, height: geoProxy.size.height)
                        .overlay(
                            GeometryReader { geoProxy2 in
                                    HStack {
                                        ScrollView(.vertical) {
                                            VStack {
                                                ForEach(0..<(Int(sensations.count/3))+1, id: \.self) { index in
                                                    HStack {
                                                        ForEach(0..<(3-getLeft(index: index*3, total: sensations.count)), id: \.self) { i in
                                                            Button {
                                                                sensations[index*3+i].isSelected = sensations[index*3+i].isSelected ? false : true
                                                            } label: {
                                                                Text(sensations[index*3+i].name)
                                                                    .padding()
                                                                    .background(.white)
                                                                    .colorMultiply((sensations[index*3+i].isSelected)
                                                                                   ? Color.init(hex: "F1FAEE") : .white)
                                                            }.buttonStyle(BorderlessButtonStyle())
                                                            .padding()
                                                        }
                                                        Spacer()
                                                        }
                                                    }
                                            }
                                        }
                                        .background(.white)
                                        .frame(width: geoProxy2.size.width, height: geoProxy2.size.height * 0.8)
                                        .padding(.trailing, 20)
                                        Spacer()
                                        }
                                    }
                        )
                }
                .padding(.leading, -10)

            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .ignoresSafeArea()
        .background(.white)
        .foregroundColor(.black)
        .foregroundStyle(Color.black)
        .accentColor(.black)
    }
    struct Sensations {
        var id = UUID()
        var name: Image
        var isSelected: Bool = false
    }
}

struct PainSensationView_Previews: PreviewProvider {
    static var previews: some View {
        PainSensationView()
    }

}
