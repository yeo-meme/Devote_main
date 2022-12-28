//
//  CheckboxStyle.swift
//  Devote_main
//
//  Created by yeomim Kim on 2022/12/28.
//

import SwiftUI

struct CheckboxStyle: ToggleStyle {
    func makeBody(configuration: Configuration) -> some View {
        return HStack {
            Image(systemName: configuration.isOn ?
                  "checkmark.circle.fill" : "circle")
            .foregroundColor(configuration.isOn ? .pink : .primary)
            .font(.system(size: 30, weight: .semibold, design: .rounded))
            .onTapGesture {
                configuration.isOn.toggle()
                feedback.notificationOccurred(.success)
                
                //                if configuration.isOn {
                //                }
            }
                configuration.label
            }//: HSTACK
        }
    }

struct CheckboxStyle_Previews: PreviewProvider {
    static var previews: some View {
        Toggle("Placeholder label", isOn: .constant(false))
            .toggleStyle(CheckboxStyle())
            .padding()
            .previewLayout(.sizeThatFits)
        
    }
}
