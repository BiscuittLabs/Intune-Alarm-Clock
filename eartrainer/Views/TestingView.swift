//
//  TestingView.swift
//  eartrainer
//
//  Created by Zachary Fertig on 6/24/25.
//

import SwiftUI

/// # The main practice view for playing and identifying random musical notes
/// This screen allows users to hear a note and guess its name. It provides feedback and the option to retry or generate a new note.
struct TestingView: View {

    // MARK: - State

    /// ViewModel for managing settings like playback mode, note range, and SoundFonts
    @StateObject private var settings = NoteSettingsViewModel()

    /// ViewModel for managing game logic like current note and guess checking
    @StateObject private var game = NoteGameViewModel()

    // MARK: - View Body

    var body: some View {
        NavigationView {
            VStack(spacing: 20) {

                /// Displays either the note (after guess) or a prompt to listen and guess
                if let guessed = game.guessedCorrectly {
                    Text(game.currentNote.description)
                        .font(.largeTitle)
                        .fontWeight(.semibold)
                        .padding()
                        .foregroundColor(guessed ? .green : .red) // color feedback
                } else {
                    Text("Listen and Guess")
                        .font(.title2)
                        .padding()
                }

                /// Interactive note guessing buttons (natural and sharp)
                noteGuessingButtons

                /// Replay the current note
                Button("Play Note Again") {
                    game.playSelectedNote(using: settings.playback)
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(10)
                .padding(.horizontal)

                /// Generate and play a new random note
                Button("Play a Random Note") {
                    game.playRandomNote(
                        from: settings.notes,
                        using: settings.playback
                    )
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.green)
                .foregroundColor(.white)
                .cornerRadius(10)
                .padding(.horizontal)

                /// Navigate to the settings screen
                NavigationLink("Settings") {
                    SettingsView(viewModel: settings)
                }
                .padding()

                Spacer()
            }
            .navigationTitle("Guess the Note")
        }
    }

    /// Buttons for guessing notes
    private var noteGuessingButtons: some View {
        VStack {
            /// Buttons for natural notes
            HStack {
                ForEach(settings.naturalNotes, id: \.self) { noteName in
                    Button(action: {
                        game.checkUserGuess(noteName)
                        game.playNoteGuess(noteName, using: settings.playback)
                    }) {
                        Text(noteName)
                            .padding(8)
                            .background(Color.blue.opacity(0.2))
                            .cornerRadius(8)
                    }
                }
            }

            /// Additional buttons for sharp notes (if enabled)
            if settings.includeHalfSteps {
                HStack {
                    ForEach(settings.sharpNotes, id: \.self) { noteName in
                        Button(action: {
                            game.checkUserGuess(noteName)
                            game.playNoteGuess(noteName, using: settings.playback)
                        }) {
                            Text(noteName)
                                .padding(8)
                                .background(Color.blue.opacity(0.2))
                                .cornerRadius(8)
                        }
                    }
                }
            }
        }
    }
}

// MARK: - Preview

#Preview {
    TestingView()
}
