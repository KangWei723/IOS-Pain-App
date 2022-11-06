//
//  ToastExtension.swift
//  Pain App
//
//  Created by Jonathan Lim on 11/5/22.
//

import SwiftUI

extension View {
    func toastView(toast: Binding<ToastModel?>) -> some View {
        self.modifier(ToastModifier(toast: toast))
    }
}
