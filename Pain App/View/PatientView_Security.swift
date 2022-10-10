//
//  PatientView_Security.swift
//  Pain App
//
//  Created by Jonathan Lim on 10/10/22.
//

import SwiftUI

struct PatientView_Security: View {
    var body: some View {
        ScrollView(.vertical) {
            
            Group {
                Rectangle()
                    .frame(width: 1400, height: 150, alignment: .leading)
                    .foregroundColor(Color(hex: "#A8DADC"))
                    .overlay(Text("          Profile").font(.title), alignment: .leading)
                    .overlay(Button(action: {}, label: {
                        Text("Back")
                            .foregroundColor(Color.black)
                            .frame(width: 130, height: 40)
                            .background(Color.white)
                            .clipShape(Capsule())
                            .offset(x: 550, y: 40)
                    }))
                    .offset(x: 10, y: -30)
                
                Rectangle()
                    .frame(width: 300, height: 900)
                    .foregroundColor(Color(hex: "F1FAEE"))
                    .offset(x: -550, y: -39)
                
                Button(action: {
                    
                }, label: {
                    Text("Edit Profile")
                        .foregroundColor(Color.black)
                        .frame(width: 190, height: 80)
                        .background(Color(hex: "#A8DADC"))
                        .clipShape(Capsule())
                        .offset(x: -540, y: -900)
                })
                
                Button(action: {
                    
                }, label: {
                    Text("Security")
                        .foregroundColor(Color.black)
                        .frame(width: 190, height: 80)
                        .background(Color.white)
                        .clipShape(Capsule())
                        .offset(x: -540, y: -870)
                })
                
            }
            
        }
    }
}

struct PatientView_Security_Previews: PreviewProvider {
    static var previews: some View {
        PatientView_Security()
    }
}
