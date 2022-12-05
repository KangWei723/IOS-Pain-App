//
//  MainViewController.swift
//  Pain App
//
//  Created by Shrey Patel on 10/10/22.
//

import Foundation
import SwiftUI

enum ViewState {
    case patientHome
    case patientProfile
    case patientPastRecords
    case patientSecurity
    case highlightAreaPage
    case painSensationPage
    case painSliderPage
    case addNewRecordPage
}

final class MainViewController: ObservableObject {
    @Published var viewState: ViewState = .patientHome
    
    @Published var sensations: [Sensations] = [Sensations(img: Image("Burning"), name: "Burning" ),
                                               Sensations(img: Image("Shooting"), name: "Shooting"),
                                               Sensations(img: Image("Other"), name: "Other"),
                                               Sensations(img: Image("Throbbing"), name: "Throbbing"),
                                               Sensations(img: Image("Pain"), name: "Pain"),
                                               Sensations(img: Image("Pinch"), name: "Pinch"),
                                               Sensations(img: Image("Pins&Needles"), name: "Pins&Needles"),
                                               Sensations(img: Image("Crushing"), name: "Crushing"),
                                               Sensations(img: Image("Stabbing"), name: "Stabbing"),
                                               Sensations(img: Image("Cramping"), name: "Cramping"),
                                               Sensations(img: Image("Bite"), name: "Bite"),
                                               Sensations(img: Image("Stinging"), name: "Stinging"),
                                               Sensations(img: Image("Tearing"), name: "Tearing"),
                                               Sensations(img: Image("Tingling"), name: "Tingling"),
                                               Sensations(img: Image("Movement"), name: "Movement"),
                                               Sensations(img: Image("Itching"), name: "Itching"),
                                               Sensations(img: Image("Stitching"), name: "Stitching"),
                                               Sensations(img: Image("Flushing"), name: "Flushing"),
                                               Sensations(img: Image("Perforating"), name: "Perforating"),
                                               Sensations(img: Image("Tremor"), name: "Tremor"),
                                               Sensations(img: Image("Cooling"), name: "Cooling"),
                                               Sensations(img: Image("Pressure"), name: "Pressure"),
                                               Sensations(img: Image("Spasm"), name: "Spasm"),
                                               Sensations(img: Image("Pulling"), name: "Pulling")]
    
    @ViewBuilder func getView() -> some View {
        switch viewState {
        case .patientHome:
            PatientView_HomePage()
        case .patientProfile:
            PatientView_Profile()
        case .patientPastRecords:
            PatientView_PastRecords()
        case .patientSecurity:
            PatientView_Security()
        case .highlightAreaPage:
            HighlightAreaPage()
        case .painSensationPage:
            PainSensationView()
        case .painSliderPage:
            PainSlidersView()
        case .addNewRecordPage:
            AddNewRecordPage()
        }
    }
    
    struct Sensations: Identifiable {
        var id = UUID()
        var img: Image
        var isSelected: Bool = false
        var name: String = ""
    }
}
