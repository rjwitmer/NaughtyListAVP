//
//  Child.swift
//  NaughtyListAVP
//
//  Created by Bob Witmer on 2025-09-16.
//

import Foundation
import SwiftData

@MainActor
@Model
class Child {
    var firstName: String
    var lastName: String
    var naughty: Bool
    var smacks: Int
    var notes: String
    
    init(firstName: String = "", lastName: String = "", naughty: Bool = true, smacks: Int = 1, notes: String = "") {
        self.firstName = firstName
        self.lastName = lastName
        self.naughty = naughty
        self.smacks = smacks
        self.notes = notes
    }
}

extension Child {
    
    static var preview: ModelContainer {
        let container = try! ModelContainer(for: Child.self, configurations: ModelConfiguration(isStoredInMemoryOnly: true))
        
        // Add mock data here
        container.mainContext.insert(Child(firstName: "Bad", lastName: "Bunny", naughty: true, smacks: 1, notes: "Conejo Malo"))
        container.mainContext.insert(Child(firstName: "Draco", lastName: "Malfoy", naughty: true, smacks: 5, notes: "Watch out for wands"))
        container.mainContext.insert(Child(firstName: "Lisa", lastName: "Simpson", naughty: false, smacks: 0, notes: "Always tries her best"))
        container.mainContext.insert(Child(firstName: "Veruca", lastName: "Salt", naughty: true, smacks: 3, notes: "Keep away from Candy. Everyone's favourite"))
        container.mainContext.insert(Child(firstName: "Fred", lastName: "Rogers", naughty: false, smacks: 0, notes: "Neighbour"))
        return container
    }
}

