//
//  ToastModifier.swift
//  Pain App
//
//  Created by Jonathan Lim on 11/5/22.
//

import SwiftUI

struct ToastModifier: ViewModifier {
    @Binding var toast: ToastModel?
        @State private var item: DispatchWorkItem?
        
        func body(content: Content) -> some View {
            content
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .overlay(
                    ZStack {
                        toastView()
                            .offset(y: -30)
                    }.animation(.spring(), value: toast)
                )
                .onChange(of: toast) {_ in
                    showToast()
                }
        }
        
        @ViewBuilder func toastView() -> some View {
            if let toast = toast {
                VStack {
                    Spacer()
                    ToastView(
                        type: toast.type,
                        title: toast.title,
                        message: toast.message) {
                            dismissToast()
                        }
                }
                .transition(.move(edge: .bottom))
            }
        }
        
        private func showToast() {
            guard let toast = toast else { return }
            
            UIImpactFeedbackGenerator(style: .light).impactOccurred()
            
            if toast.duration > 0 {
                item?.cancel()
                let task = DispatchWorkItem {
                   dismissToast()
                }
                item = task
                DispatchQueue.main.asyncAfter(deadline: .now() + toast.duration, execute: task)
            }
        }
    
        private func dismissToast() {
            withAnimation {
                toast = nil
            }
            item?.cancel()
            item = nil
        }
    }
