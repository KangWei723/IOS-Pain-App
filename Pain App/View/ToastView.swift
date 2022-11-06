//
//  ToastView.swift
//  Pain App
//
//  Created by Jonathan Lim on 11/4/22.
//

import SwiftUI

enum ToastStyle {
    case error
    case warning
}

extension ToastStyle {
    var color: Color {
        switch self {
        case .error: return Color.red
        case .warning: return Color.yellow
        }
    }
    var icon: String {
        switch self {
        case .error: return "xmark.circle.fill"
        case .warning: return "exclamationmark.triangle.fill"
        }
    }
}

struct ToastView: View {
        var type: ToastStyle
        var title: String
        var message: String
        var onCancelTapped: (() -> Void)
        var body: some View {
            VStack(alignment: .leading) {
                HStack(alignment: .top) {
                    Image(systemName: type.icon)
                        .foregroundColor(type.color)
                    
                    VStack(alignment: .leading) {
                        Text(title)
                            .font(.system(size: 14, weight: .semibold))
                        
                        Text(message)
                            .font(.system(size: 12))
                            .foregroundColor(Color.black.opacity(0.6))
                    }
                    
                    Spacer(minLength: 10)
                    Button {
                        onCancelTapped()
                    } label: {
                        Image(systemName: "xmark")
                            .foregroundColor(Color.black)
                    }
                }.padding()
            }
            .background(Color.white)
            .overlay(
                Rectangle()
                    .fill(type.color)
                    .frame(width: 6)
                    .clipped()
                , alignment: .leading
            )
            .frame(minWidth: 0, maxWidth: .infinity)
            .cornerRadius(8)
            .shadow(color: Color.black.opacity(0.25), radius: 4, x: 0, y: 1)
            .padding(.horizontal, 16)
        }
    }
