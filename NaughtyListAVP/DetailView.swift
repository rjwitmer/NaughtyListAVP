//
//  DetailView.swift
//  NaughtyListAVP
//
//  Created by Bob Witmer on 2025-09-17.
//

import SwiftUI
import SwiftData
import AVFAudio

struct DetailView: View {
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss
    @State private var audioPlayer: AVAudioPlayer!
    @State private var isFullSize: Bool = true
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
            List {
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
                                .scaleEffect(isFullSize ? 1 : 0.9)
                                .onTapGesture {
                                    if smacks > 0 {
                                        playSound(soundName: "smack")
                                    }
                                    isFullSize.toggle()
                                    withAnimation(.spring(response: 0.3, dampingFraction: 0.3, blendDuration: 1.0)) {
                                        isFullSize.toggle()
                                    }
                                }
                                .frame(width: 200, height: 200)
                                

                            Image("girl")
                                .resizable()
                                .scaledToFit()
                                .scaleEffect(isFullSize ? 1 : 0.9)
                                .onTapGesture {
                                    if smacks > 0 {
                                        playSound(soundName: "smack")
                                    }
                                    isFullSize.toggle()
                                    withAnimation(.spring(response: 0.3, dampingFraction: 0.3)) {
                                        isFullSize.toggle()
                                    }
                                }
                                .frame(width: 200, height: 200)
                            Spacer()
                        }
                    }
                }
                .onAppear {
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
            }
            .foregroundStyle(Color(.black))
            .padding()
        }
    }
}

extension DetailView {
    func playSound(soundName: String) {
        guard let soundFile = NSDataAsset(name: soundName) else {
            print("😡 ERROR: Could not read sound file named \(soundName)")
            return
        }
        do {
            audioPlayer = try AVAudioPlayer(data: soundFile.data)
            audioPlayer.play()
        } catch {
            print("😡 ERROR: -> \(error.localizedDescription) creating AVAudioPlayer")
        }
    }
    
    func stopSound() {
        if audioPlayer != nil && audioPlayer.isPlaying {
            audioPlayer.stop()
        }
    }
}

#Preview {
    DetailView(child: Child(firstName: "Bob", lastName: "Witmer", naughty: false, smacks: 0, notes: "Poster Child"))
}
