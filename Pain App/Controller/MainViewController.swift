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
}

final class MainViewController: ObservableObject {
    @Published var viewState: ViewState = .patientHome
    
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
        }
    }
}
