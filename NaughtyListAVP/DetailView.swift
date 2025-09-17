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
    @State var child: Child
    @State private var firstName: String = ""
    @State private var lastName: String = ""
    @State private var naughty: Bool = false
    @State private var smacks: Int = 0
    @State private var notes: String = ""
    var body: some View {
        List {
            VStack(alignment: .leading) {
                Text("First Name:")
                TextField("first name", text: $firstName)
                    .textFieldStyle(.roundedBorder)
                Text("Last Name:")
                TextField("last name", text: $lastName)
                    .textFieldStyle(.roundedBorder)
                HStack {
                    Text("Naughty?:")
                    Toggle("", isOn: $naughty)
                }
                .padding(.vertical, 30)
                HStack {
                    Text("Smacks Deserved:")
                    Stepper("", value: $smacks, in: 0...5)
                }
                HStack {
                    Spacer()
                    Text("\(smacks)")
                        .font(.title)
                    Spacer()
                }

                Text("Notes:")
                TextField("notes", text: $notes)
                    .textFieldStyle(.roundedBorder)
                HStack {
                    Spacer()
                    Image("boy")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 200, height: 200)
                    Image("girl")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 200, height: 200)
                    Spacer()
                }
            }
            .onAppear {
                firstName = child.firstName
                lastName = child.lastName
                naughty = child.naughty
                smacks = child.smacks
                notes = child.notes
            }
        }
        .padding()
    }
}

#Preview {
    DetailView(child: Child(firstName: "Bob", lastName: "Witmer", naughty: false, smacks: 0, notes: "Poster Child"))
}
