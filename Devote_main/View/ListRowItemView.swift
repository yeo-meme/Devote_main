//
//  ListRowItemView.swift
//  Devote_main
//
//  Created by yeomim Kim on 2022/12/28.
//

import SwiftUI

struct ListRowItemView: View {
    @Environment(\.managedObjectContext) var viewCotext
    @ObservedObject var item : Item
    
    var body: some View {
        Toggle(isOn: $item.completion) {
            Text(item.task ?? "")
                .font(.system(.title2, design: .rounded))
                .fontWeight(.heavy)
                .foregroundColor(item.completion ? Color.pink : Color.primary)
                .padding(.vertical , 8)
                .animation(.default)
        } //: TOGGEL
        .toggleStyle(CheckboxStyle())
        .onReceive(item.objectWillChange , perform: { _  in
            if self.viewCotext.hasChanges {
                try? self.viewCotext.save()
            }
        })
    }
}


