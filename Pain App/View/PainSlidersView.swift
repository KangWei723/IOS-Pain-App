//
//  PainSlidersView.swift
//  Pain App
//
//  Created by Elijah Yates on 11/7/22.
//

import SwiftUI

struct UISliderView: UIViewRepresentable {
    @Binding var value: Double
    
    var minValue = 1.0
    var maxValue = 100.0
    var thumbColor: UIColor = .white
    var minTrackColor: UIColor = .blue
    var maxTrackColor: UIColor = .lightGray

    class Coordinator: NSObject {
        var value: Binding<Double>
        
        init(value: Binding<Double>) {
            self.value = value
        }
        
        @objc func valueChanged(_ sender: UISlider) {
            self.value.wrappedValue = Double(sender.value)
        }
    }
    
    func makeCoordinator() -> UISliderView.Coordinator {
        Coordinator(value: $value)
    }
    
    func makeUIView(context: Context) -> UISlider {
        let slider = UISlider(frame: .zero)
        slider.thumbTintColor = thumbColor
        slider.minimumTrackTintColor = minTrackColor
        slider.maximumTrackTintColor = maxTrackColor
        slider.minimumValue = Float(minValue)
        slider.maximumValue = Float(maxValue)
        slider.value = Float(value)
        
        for i in 1...10 {
            let tick = UIView(frame: CGRect(x: i * 80, y: (Int(slider.frame.size.height) - 20) / 2, width: 4, height: 50))
            tick.backgroundColor = UIColor.init(hex: "A8DADC")
            tick.layer.shadowColor = UIColor.white.cgColor
            tick.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
            tick.layer.shadowOpacity = 1.0
            tick.layer.shadowRadius = 0.0
            tick.tag = 0
            slider.insertSubview(tick, belowSubview: slider)
        }
        slider.addTarget(
            context.coordinator,
            action: #selector(Coordinator.valueChanged(_:)),
            for: .valueChanged
        )
        
        return slider
    }
    
    func updateUIView(_ uiView: UISlider, context: Context) {
        uiView.value = Float(value)
    }
}

struct PainSlidersView: View {
    @EnvironmentObject var mainViewController: MainViewController
    
    @State private var burning: Double = 0.0
    @State private var shooting: Double = 0.0
    @State private var other: Double = 0.0
    @State private var throbbing: Double = 0.0
    @State private var pain: Double = 0.0
    @State private var pinch: Double = 0.0
    @State private var pins_needles: Double = 0.0
    @State private var crushing: Double = 0.0
    @State private var stabbing: Double = 0.0
    @State private var cramping: Double = 0.0
    @State private var bite: Double = 0.0
    @State private var stinging: Double = 0.0
    @State private var tearing: Double = 0.0
    @State private var tingling: Double = 0.0
    @State private var movement: Double = 0.0
    @State private var itching: Double = 0.0
    @State private var stitching: Double = 0.0
    @State private var flushing: Double = 0.0
    @State private var perforating: Double = 0.0
    @State private var tremor: Double = 0.0
    @State private var cooling: Double = 0.0
    @State private var pressure: Double = 0.0
    @State private var spasm: Double = 0.0
    @State private var pulling: Double = 0.0
    
    @State private var isEditing = false
    
    var body: some View {
        GeometryReader { geoProxy in
            VStack {
                HStack {
                    VStack {
                        Text("Please rate your pain level using the sliders for the selected sensations")
                            .font(.system(size: 30))
                            .padding()
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    
                    Button(action: {
                            mainViewController.viewState = .painSensationPage
                        }, label: {
                            Text("Back")
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
                
                VStack {
                    Rectangle()
                        .fill(Color.white)
                        .frame(width: geoProxy.size.width * 0.8, height: geoProxy.size.height * 0.5)
                        .overlay(
                            GeometryReader { geoProxy2 in
                                VStack {
                                    ScrollView(.vertical) {
                                        VStack {
                                            ForEach(mainViewController.sensations) { sensation in
                                                if sensation.isSelected {
                                                    HStack {
                                                        Spacer()
                                                        UISliderView(value:
                                                                    sensation.name == "Burning" ?
                                                                     $burning : sensation.name == "Shooting" ?
                                                                     $shooting : sensation.name == "Other" ?
                                                                     $other : sensation.name == "Throbbing" ?
                                                                     $throbbing: sensation.name == "Pain" ?
                                                                     $pain : sensation.name == "Pinch" ?
                                                                     $pinch : sensation.name == "Pinch&Needles" ?
                                                                     $pins_needles: sensation.name == "Crushing" ?
                                                                     $crushing : sensation.name == "Stabbing" ?
                                                                     $stabbing : sensation.name == "Cramping" ?
                                                                     $cramping : sensation.name == "Bite" ?
                                                                     $bite : sensation.name == "Stinging" ?
                                                                     $stabbing : sensation.name == "Tearing" ?
                                                                     $tearing : sensation.name == "Tingling" ?
                                                                     $tingling: sensation.name == "Movement" ?
                                                                     $movement: sensation.name == "Itching" ?
                                                                     $itching : sensation.name == "Stitching" ?
                                                                     $stitching : sensation.name == "Flushing" ?
                                                                     $flushing : sensation.name == "Perforating" ?
                                                                     $perforating : sensation.name == "Tremor" ?
                                                                     $tremor : sensation.name == "Cooling" ?
                                                                     $cooling : sensation.name == "Pressure" ?
                                                                     $pressure : sensation.name == "Spasm" ? $spasm : $pulling,
                                                                     minValue: 1.0,
                                                                     maxValue: 100.0,
                                                                     thumbColor: .black,
                                                                     minTrackColor: .red,
                                                                     maxTrackColor: .blue
                                                                    )
                                                        .frame(width: geoProxy2.size.width * 0.8, height: geoProxy2.size.height * 0.25)
                                                        Spacer()
                                                        Spacer()
                                                        Text(sensation.img)
                                                            .font(.title)
                                                            .padding(.leading, -15)
                                                        Spacer()
                                                    }
                                                    
                                                    switch sensation.name {
                                                    case "Burning":
                                                      Text("\(String(format: "%.0f", burning))")
                                                            .foregroundColor(isEditing ? .red : .blue)
                                                            .padding(.trailing, 150)
                                                            Spacer()
                                                    case "Shooting":
                                                      Text("\(String(format: "%.0f", shooting))")
                                                            .foregroundColor(isEditing ? .red : .blue)
                                                            .padding(.trailing, 150)
                                                            Spacer()
                                                    case "Other":
                                                      Text("\(String(format: "%.0f", other))")
                                                            .foregroundColor(isEditing ? .red : .blue)
                                                            .padding(.trailing, 150)
                                                            Spacer()
                                                    case "Throbbing":
                                                      Text("\(String(format: "%.0f", throbbing))")
                                                            .foregroundColor(isEditing ? .red : .blue)
                                                            .padding(.trailing, 150)
                                                            Spacer()
                                                    case "Pain":
                                                      Text("\(String(format: "%.0f", pain))")
                                                            .foregroundColor(isEditing ? .red : .blue)
                                                            .padding(.trailing, 150)
                                                            Spacer()
                                                    case "Pinch":
                                                      Text("\(String(format: "%.0f", pinch))")
                                                            .foregroundColor(isEditing ? .red : .blue)
                                                            .padding(.trailing, 150)
                                                            Spacer()
                                                    case "Pins&Needles":
                                                      Text("\(String(format: "%.0f", pins_needles))")
                                                            .foregroundColor(isEditing ? .red : .blue)
                                                            .padding(.trailing, 150)
                                                            Spacer()
                                                    case "Crushing":
                                                      Text("\(String(format: "%.0f", crushing))")
                                                            .foregroundColor(isEditing ? .red : .blue)
                                                            .padding(.trailing, 150)
                                                            Spacer()
                                                    case "Stabbing":
                                                      Text("\(String(format: "%.0f", stabbing))")
                                                            .foregroundColor(isEditing ? .red : .blue)
                                                            .padding(.trailing, 150)
                                                            Spacer()
                                                    case "Cramping":
                                                      Text("\(String(format: "%.0f", cramping))")
                                                            .foregroundColor(isEditing ? .red : .blue)
                                                            .padding(.trailing, 150)
                                                            Spacer()
                                                    case "Bite":
                                                      Text("\(String(format: "%.0f", bite))")
                                                            .foregroundColor(isEditing ? .red : .blue)
                                                            .padding(.trailing, 150)
                                                            Spacer()
                                                    case "Stinging":
                                                    Text("\(String(format: "%.0f", stinging))")
                                                            .foregroundColor(isEditing ? .red : .blue)
                                                            .padding(.trailing, 150)
                                                            Spacer()
                                                    case "Tearing":
                                                      Text("\(String(format: "%.0f", tearing))")
                                                            .foregroundColor(isEditing ? .red : .blue)
                                                            .padding(.trailing, 150)
                                                            Spacer()
                                                    case "Tingling":
                                                    Text("\(String(format: "%.0f", tingling))")
                                                            .foregroundColor(isEditing ? .red : .blue)
                                                            .padding(.trailing, 150)
                                                            Spacer()
                                                    case "Movement":
                                                      Text("\(String(format: "%.0f", movement))")
                                                            .foregroundColor(isEditing ? .red : .blue)
                                                            .padding(.trailing, 150)
                                                            Spacer()
                                                    case "Itching":
                                                      Text("\(String(format: "%.0f", itching))")
                                                            .foregroundColor(isEditing ? .red : .blue)
                                                            .padding(.trailing, 150)
                                                            Spacer()
                                                    case "Stitching":
                                                      Text("\(String(format: "%.0f", stitching))")
                                                            .foregroundColor(isEditing ? .red : .blue)
                                                            .padding(.trailing, 150)
                                                            Spacer()
                                                    case "Flushing":
                                                      Text("\(String(format: "%.0f", flushing))")
                                                            .foregroundColor(isEditing ? .red : .blue)
                                                            .padding(.trailing, 150)
                                                            Spacer()
                                                    case "Perforating":
                                                      Text("\(String(format: "%.0f", perforating))")
                                                            .foregroundColor(isEditing ? .red : .blue)
                                                            .padding(.trailing, 150)
                                                            Spacer()
                                                    case "Tremor":
                                                      Text("\(String(format: "%.0f", tremor))")
                                                            .foregroundColor(isEditing ? .red : .blue)
                                                            .padding(.trailing, 150)
                                                            Spacer()
                                                    case "Cooling":
                                                      Text("\(String(format: "%.0f", cooling))")
                                                            .foregroundColor(isEditing ? .red : .blue)
                                                            .padding(.trailing, 150)
                                                            Spacer()
                                                    case "Pressure":
                                                      Text("\(String(format: "%.0f", pressure))")
                                                            .foregroundColor(isEditing ? .red : .blue)
                                                            .padding(.trailing, 150)
                                                            Spacer()
                                                    case "Spasm":
                                                      Text("\(String(format: "%.0f", spasm))")
                                                            .foregroundColor(isEditing ? .red : .blue)
                                                            .padding(.trailing, 150)
                                                            Spacer()
                                                    case "Pulling":
                                                      Text("\(String(format: "%.0f", pulling))")
                                                            .foregroundColor(isEditing ? .red : .blue)
                                                            .padding(.trailing, 150)
                                                            Spacer()
                                                    default:
                                                      Text("\(String(format: "%.0f"))")
                                                            .foregroundColor(isEditing ? .red : .blue)
                                                            .padding(.trailing, 150)
                                                            Spacer()
                                                    }

                                                }
                                            }
                                        }
                                        
                                    }
                                    .padding(.top, 70)
                                   Spacer()
                                }
                            }
                        )
                    Spacer(minLength: 150)
                    Button {
                        mainViewController.viewState = .addNewRecordPage
                    } label: {
                        Text("Next")
                            .font(.largeTitle)
                            .foregroundColor(Color.white)
                            .frame(width: geoProxy.size.width * 0.3, height: geoProxy.size.height * 0.075)
                        
                    }
                    .background(Color.init(hex: "457B9D"))
                    .cornerRadius(10)
                    .shadow(color: .gray, radius: 6, x: 0, y: 0)
                    .padding(.bottom, geoProxy.size.height * 0.12)
                    
                }
            }.padding(.bottom, 100)
        }
        .ignoresSafeArea()
    }
}
    
struct PainSlidersView_Previews: PreviewProvider {
    static var previews: some View {
        PainSlidersView()
            .environmentObject(MainViewController())
    }
}
