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
    @State private var pinching: Float = 0.0
    @State private var shooting: Float = 0.0
    @State private var throbbing: Float = 0.0
    @State private var other: Float = 0.0
    @State private var isBurningEditing = false
    @State private var isPinchingEditing = false
    @State private var isShootingEditing = false
    @State private var isThrobbingEditing = false
    
    @State private var currentValue = 6.0
    
    var body: some View {
        GeometryReader { geoProxy in
            VStack {
                // Rectangle holding the prompt for users rate their pain
                Rectangle()
                    .fill(Color.init(hex: "A8DADC"))
                    .frame(width: geoProxy.size.width, height: geoProxy.size.height * 0.15)
                    .overlay(
                        Text("Please Rate Your Pain On The Sliders").font(.largeTitle)
                        
                    )
                VStack {
                    Rectangle()
                        .fill(Color.white)
                        .frame(width: geoProxy.size.width * 0.8, height: geoProxy.size.height * 0.5)
                        .overlay(
                            GeometryReader { geoProxy2 in
                                VStack {
                                    VStack {
                                    
                                        HStack {
                                            Spacer()
                                            UISliderView(value: $burning,
                                                         minValue: 1.0,
                                                         maxValue: 100.0,
                                                         thumbColor: .black,
                                                         minTrackColor: .red,
                                                         maxTrackColor: .blue
                                                         
                                                        )
                                            
                                                            .frame(width: geoProxy2.size.width * 0.8, height: geoProxy2.size.height * 0.25)
                                            
                                          //  .frame(width: geoProxy2.size.width * 0.8, height: geoProxy2.size.height * 0.25)
                                            Spacer()
                                            Spacer()
                                            Text("Burning")
                                                .font(.title)
                                            Spacer()
                                        }
                                        Text("\(String(format: "%.0f", burning))")
                                            .foregroundColor(isBurningEditing ? .red : .blue)
                                        
                                        Spacer()
                                        HStack {
                                            Spacer()
                                            Slider(
                                                value: $pinching,
                                                in: 0...100,
                                                step: 1,
                                                onEditingChanged: { editing in
                                                    isPinchingEditing = editing
                                                }
                                            )
                                    
                                            .frame(width: geoProxy2.size.width * 0.8, height: geoProxy2.size.height * 0.25)
                                            Spacer()
                                            Spacer()
                                            Text("Pinching")
                                                .font(.title)
                                            Spacer()
                                        }
                                        Text("\(String(format: "%.0f", pinching))")
                                            .foregroundColor(isPinchingEditing ? .red : .blue)
                                    }
                                    
                                    VStack {
                                        HStack {
                                            Spacer()
                                            Slider(
                                                value: $shooting,
                                                in: 0...100,
                                                step: 1,
                                                onEditingChanged: { editing in
                                                    isShootingEditing = editing
                                                }
                                            )
                                            .frame(width: geoProxy2.size.width * 0.8, height: geoProxy2.size.height * 0.25)
                                            Spacer()
                                            Spacer()
                                            Text("Shooting")
                                                .font(.title)
                                            Spacer()
                                        }
                                        Text("\(String(format: "%.0f", shooting))")
                                            .foregroundColor(isShootingEditing ? .red : .blue)
                                        
                                        HStack {
                                            Spacer()
                                            Slider(
                                                value: $throbbing,
                                                in: 0...100,
                                                step: 1,
                                                onEditingChanged: { editing in
                                                    isThrobbingEditing = editing
                                                }
                                            )
                                            .frame(width: geoProxy2.size.width * 0.8, height: geoProxy2.size.height * 0.25)
                                            Spacer()
                                            Spacer()
                                            Text("Throbbing")
                                                .font(.title)
                                            Spacer()
                                        }
                                        Text("\(String(format: "%.0f", throbbing))")
                                            .foregroundColor(isThrobbingEditing ? .red : .blue)
                                        
                                    }
                                    Spacer()
                                }
                            }
                        )
                    Spacer(minLength: 200)
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
    }
}
