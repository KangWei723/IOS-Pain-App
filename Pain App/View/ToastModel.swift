//
//  ToastModel.swift
//  Pain App
//
//  Created by Jonathan Lim on 11/5/22.
//

struct ToastModel: Equatable {
    var type: ToastStyle
    var title: String
    var message: String
    var duration: Double = 3
}
