//
//  NoteGameViewModel.swift
//  eartrainer
//
//  Created by Zachary Fertig on 6/24/25.
//

import Foundation

/// # ViewModel managing the state of the current game session
class NoteGameViewModel: ObservableObject {

    ///-------------------------------------------------------------------------------------------------------
    // MARK: - Published Properties

    /// The currently selected or played note
    @Published var currentNote: Note = Note()

    /// Whether the last guess was correct (nil if not yet guessed)
    @Published var guessedCorrectly: Bool?

    ///-------------------------------------------------------------------------------------------------------
    // MARK: - Private Properties

    /// Responsible for audio playback
    private let player = NotePlayer()

    /// Responsible for note generation and frequency mapping
    private let generator = NoteGenerator()

    ///-------------------------------------------------------------------------------------------------------
    // MARK: - Playback Controls

    /// # Plays a random note from a provided list and updates state
    func playRandomNote(from notes: [Note], using playback: PlaybackSettings) {
        guessedCorrectly = nil
        currentNote = notes.randomElement()!
        player.playNote(
            note: currentNote,
            mode: playback.mode,
            soundFont: playback.soundFont
        )
    }

    /// # Replays the currently selected note
    func playSelectedNote(using playback: PlaybackSettings) {
        player.playNote(
            note: currentNote,
            mode: playback.mode,
            soundFont: playback.soundFont
        )
    }

    /// # Plays the user's guessed note using the current octave
    func playNoteGuess(_ noteName: String, using playback: PlaybackSettings) {
        let guessedNote = generator.makeNote(name: noteName, octave: currentNote.octave)
        player.playNote(
            note: guessedNote,
            mode: playback.mode,
            soundFont: playback.soundFont
        )
    }

    ///-------------------------------------------------------------------------------------------------------
    // MARK: - Game Logic

    /// # Compares the user's guess to the current note and sets result
    func checkUserGuess(_ guessedName: String) {
        guessedCorrectly = (guessedName == currentNote.name)
        // print("Guessed \(guessedName). Actual: \(currentNote.name)")
    }
}
