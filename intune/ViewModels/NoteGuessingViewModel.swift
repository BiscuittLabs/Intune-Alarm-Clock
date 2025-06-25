//
//  NoteGuessingViewModel.swift
//  eartrainer
//
//  Created by Zachary Fertig on 6/23/25.
//

import Foundation

/// # A ViewModel dedicated to managing the logic for guessing musical notes
/// This class handles the current note to guess, evaluates the user's input,
/// and exposes guess results to update the UI.
class NoteGuessingViewModel: ObservableObject {

    // MARK: - Published Properties

    /// The note that the user is supposed to guess
    @Published private(set) var targetNote: Note?

    /// Whether the user's guess was correct
    /// - `true` if correct
    /// - `false` if incorrect
    /// - `nil` if no guess has been made yet
    @Published var guessedCorrectly: Bool?

    // MARK: - Methods

    /// # Sets a new note to be guessed
    /// Resets the guess state to `nil` so UI doesn't show prior result
    /// - Parameter note: the new note to guess
    func setNewNote(_ note: Note) {
        targetNote = note
        guessedCorrectly = nil
    }

    /// # Checks the user's guess against the current target note
    /// - Parameter guess: the note guessed by the user
    func checkGuess(_ guess: Note) {
        guard let target = targetNote else {
            guessedCorrectly = nil
            return
        }
        guessedCorrectly = guess.name == target.name
    }

    /// # Returns the note the user is trying to guess
    /// Used by the view to play or display it
    func getTargetNote() -> Note? {
        return targetNote
    }
}
