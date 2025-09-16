//
//  ListView.swift
//  NaughtyListAVP
//
//  Created by Bob Witmer on 2025-09-16.
//

import SwiftUI
import RealityKit
import RealityKitContent
import SwiftData

struct ListView: View {
    @Environment(\.modelContext) var modelContext
    @Query var children: [Child]
    var body: some View {
        List {
            ForEach(children) { child in
                HStack {
                    Image(child.naughty ? "naughty" : "nice")
                    Text("\t\(child.firstName) \(child.lastName)")
                        .font(.largeTitle)
                }
            }

            
        }
        .listStyle(.plain)
        .padding()
    }
}

#Preview(windowStyle: .automatic) {
    ListView()
        .modelContainer(Child.preview)  // Use Mock Data
}
