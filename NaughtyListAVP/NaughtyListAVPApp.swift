//
//  NaughtyListAVPApp.swift
//  NaughtyListAVP
//
//  Created by Bob Witmer on 2025-09-16.
//

import SwiftUI
import SwiftData

@main
struct NaughtyListAVPApp: App {
    var body: some Scene {
        WindowGroup {
            ListView()
                .modelContainer(for: Child.self)
        }
    }
    
    // Print the directory path for the data to make it easier to find
    init () {
        print(URL.applicationSupportDirectory.path(percentEncoded: false))
    }
}
