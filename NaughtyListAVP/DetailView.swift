//
//  DetailView.swift
//  NaughtyListAVP
//
//  Created by Bob Witmer on 2025-09-17.
//

import SwiftUI
import SwiftData

struct DetailView: View {
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss
    @State private var isBoyFullSize: Bool = true
    @State private var isGirlFullSize: Bool = true
    @State var child: Child
    @State private var firstName: String = ""
    @State private var lastName: String = ""
    @State private var naughty: Bool = false
    @State private var smacks: Int = 0
    @State private var notes: String = ""
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(.white)
                .edgesIgnoringSafeArea(.all)
            NavigationStack {
                ZStack {
                    Rectangle()
                        .foregroundColor(.white)
                        .cornerRadius(10)
                    VStack(alignment: .leading) {
                        Text("First Name:")
                        TextField("first name", text: $firstName)
                            .textFieldStyle(.roundedBorder)
                        Text("Last Name:")
                        TextField("last name", text: $lastName)
                            .textFieldStyle(.roundedBorder)
                        
                        Toggle("Naughty?", isOn: $naughty)
                            .padding(.vertical, 30)
                        
                        Stepper("Smacks Deserved:", value: $smacks, in: 0...5)
                        
                        Text("\(smacks)")
                            .font(.title)
                            .frame(maxWidth: .infinity, alignment: .center)
                        
                        Text("Notes:")
                        TextField("notes", text: $notes, axis: .vertical)
                            .textFieldStyle(.roundedBorder)
                        HStack {
                            Spacer()
                            
                            Image("boy")
                                .resizable()
                                .scaledToFit()
                                .scaleEffect(isBoyFullSize ? 1 : 0.9)
                                .onTapGesture {
                                    if smacks > 0 {
                                        playSound(soundName: "smack")
                                    }
                                    isBoyFullSize.toggle()
                                    withAnimation(.spring(response: 0.3, dampingFraction: 0.3, blendDuration: 1.0)) {
                                        isBoyFullSize.toggle()
                                    }
                                }
                                .frame(height: 150)
                            
                            
                            Image("girl")
                                .resizable()
                                .scaledToFit()
                                .scaleEffect(isGirlFullSize ? 1 : 0.9)
                                .onTapGesture {
                                    if smacks > 0 {
                                        playSound(soundName: "smack")
                                    }
                                    isGirlFullSize.toggle()
                                    withAnimation(.spring(response: 0.3, dampingFraction: 0.3)) {
                                        isGirlFullSize.toggle()
                                    }
                                }
                                .frame(height: 150)
                            Spacer()
                        }
                    }
                    .padding(.top)
                }
                .onAppear {     // This could be alternatively done with an init
                    firstName = child.firstName
                    lastName = child.lastName
                    naughty = child.naughty
                    smacks = child.smacks
                    notes = child.notes
                }
                .onChange(of: smacks) {
                    naughty = (smacks == 0) ? false : true
                    //                    if smacks == 0 {
                    //                        naughty = false
                    //                    } else {
                    //                        naughty = true
                    //                    }
                }
                .onChange(of: naughty) {
                    smacks = naughty ? 1 : 0
                    //                    if naughty && smacks == 0 {
                    //                       smacks = 1
                    //                    }
                }
                .navigationBarBackButtonHidden()
                .toolbar {
                    ToolbarItem(placement: .cancellationAction) {
                        Button("Cancel") {
                            dismiss()
                        }
                    }
                    ToolbarItem(placement: .topBarTrailing) {
                        Button("Save") {
                            // Move data from the local variables to the Child object
                            child.firstName = firstName
                            child.lastName = lastName
                            child.naughty = naughty
                            child.smacks = smacks
                            child.notes = notes
                            // Save a new child or save changes to an edited child
                            modelContext.insert(child)  // Save the data to the SwiftData modelContext
                            // Force a save of the data to the SwiftData data store
                            guard let _ = try? modelContext.save() else {
                                print("😡 ERROR: Failed to save the child object to the SwiftData store")
                                return
                            }
                            dismiss()
                        }
                    }
                }
            }
            .foregroundStyle(Color(.black))
            .padding()
        }
    }
}


#Preview {
    //    DetailView(child: Child(firstName: "Bob", lastName: "Witmer", naughty: false, smacks: 0, notes: "Poster Child"))
    DetailView(child: Child())
        .modelContainer(for: Child.self, inMemory: true)
}
