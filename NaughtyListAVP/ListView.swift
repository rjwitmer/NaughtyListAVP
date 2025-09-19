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
    @State private var sheetIsPresented: Bool = false
    var body: some View {
        NavigationStack {
            List {
                ForEach(children) { child in
                    HStack {
                        Image(child.naughty ? "naughty" : "nice")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100, height: 40)
                        NavigationLink(destination: DetailView(child: child)) {
                            Text("\t\(child.firstName) \(child.lastName)")
                                .font(.title)
                        }

                    }
                    .padding(.horizontal)
                }
                
            }
            .navigationTitle("Schmutzli's List:")
            .listStyle(.automatic)
            .fullScreenCover(isPresented: $sheetIsPresented) {
                NavigationStack {
                    DetailView(child: Child(firstName: "", lastName: "", naughty: false, smacks: 0, notes: ""))
                }
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        sheetIsPresented.toggle()
                    } label: {
                        Image(systemName: "plus")
                    }

                }
            }
            .padding()
        }
        .onAppear {
            playSound(soundName: "riff")
        }
    }
}

#Preview(windowStyle: .automatic) {
    ListView()
        .modelContainer(Child.preview)  // Use Mock Data
}
