//
//  TestingView.swift
//  eartrainer
//
//  Created by Zachary Fertig on 6/24/25.
//

import SwiftUI

/// # The main practice view for playing and identifying random musical notes
struct TestingView: View {

    // MARK: - State

    /// ViewModel managing note logic and user interaction
    @StateObject private var viewModel = NoteViewModel()

    ///-------------------------------------------------------------------------------------------------------
    // MARK: - View Body

    var body: some View {
        NavigationView {
            VStack(spacing: 20) {

                /// Display current note description
                if let correct = viewModel.guessedCorrectly {
                    Text(correct ? "✅ Correct!" : "❌ Try again!")
                        .font(.title2)
                        .foregroundColor(correct ? .green : .red)

                    Text(viewModel.currentNote.description)
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }


                Spacer()

                VStack(spacing: 12) {
                    Text("Guess the Note:")
                        .font(.headline)

                    /// Display whole note button choices
                    HStack {
                        ForEach(viewModel.naturalNotes, id: \.self) { name in
                            Button(action: {
                                viewModel.checkUserGuess(name)
                                //print("Guessed: \(name)")
                            }) {
                                Text(name)
                                    .padding(8)
                                    .background(Color.blue.opacity(0.2))
                                    .cornerRadius(8)
                            }
                        }
                    }

                    /// Display half step button choices conditionally
                    if viewModel.includeHalfSteps {
                        HStack {
                            ForEach(viewModel.sharpNotes, id: \.self) { name in
                                Button(action: {
                                    //print("Guessed: \(name)")
                                }) {
                                    Text(name)
                                        .padding(8)
                                        .background(Color.purple.opacity(0.2))
                                        .cornerRadius(8)
                                }
                            }
                        }
                    }
                }
                .padding(.horizontal)

                /// Button to play the selected note again
                Button("Play Note Again") {
                    viewModel.playSelectedNote()
                    //print(viewModel.selectedSoundFont)
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(10)
                .padding(.horizontal)
                
                /// Button to play a random note
                Button("Play a Random Note") {
                    viewModel.playRandomNote()
                    //print(viewModel.selectedSoundFont)
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.green)
                .foregroundColor(.white)
                .cornerRadius(10)
                .padding(.horizontal)

                /// Link to settings view
                NavigationLink("Settings") {
                    SettingsView(viewModel: viewModel)
                }
                .padding()

                Spacer()
            }
            .navigationTitle("Ear Trainer")
        }
    }
}

///-------------------------------------------------------------------------------------------------------
// MARK: - Preview

#Preview {
    TestingView()
}
