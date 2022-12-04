//
//  HideKeyboardExtension.swift
//  Devote_main
//
//  Created by yeomim Kim on 2022/12/04.
//

import SwiftUI

#if canImport(UIKit)

extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
#endif
