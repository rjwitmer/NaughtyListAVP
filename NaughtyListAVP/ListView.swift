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
                    
                    NavigationLink {
                        DetailView(child: child)
                    } label: {
                        HStack {
                            Image(child.naughty ? "naughty" : "nice")
                                .resizable()
                                .scaledToFit()
                                .frame(height: 30)
                            Text("\t\(child.firstName) \(child.lastName)")
                                .font(.title)
                        }
                    }
                    .swipeActions {
                        Button("Delete", role: .destructive) {
                            modelContext.delete(child)
                            // Force delete in SwiftData
                            guard let _ = try? modelContext.save() else {
                                print("😡 ERROR: Save after delete failed!")
                                return
                            }
                        }
                    }
                }
                
            }
            .navigationTitle("Schmutzli's List:")
            .listStyle(.automatic)
            .fullScreenCover(isPresented: $sheetIsPresented) {
                NavigationStack {
                    DetailView(child: Child())
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
