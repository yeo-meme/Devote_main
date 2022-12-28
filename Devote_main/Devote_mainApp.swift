//
//  Devote_mainApp.swift
//  Devote_main
//
//  Created by yeomim Kim on 2022/12/02.
//

import SwiftUI

@main
struct Devote_mainApp: App {
    let persistenceController = PersistenceController.shared
    
    @AppStorage("isDarkMode") var isDarkMode : Bool = false

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .preferredColorScheme(isDarkMode ? .dark : .light)
        }
    }
}
