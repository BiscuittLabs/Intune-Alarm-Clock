//
//  NoteGenerator.swift
//  eartrainer
//
//  Created by Zachary Fertig on 6/12/25.
//

import Foundation

/// # A struct that creates an array of `Note` based on the provided settings
/// Provides tools for generating notes across octaves with optional half steps
struct NoteGenerator {

    // MARK: - Properties

    /// The names of all chromatic notes within an octave, using Unicode sharps
    let noteNames = [
        "C", "C♯", "D", "D♯", "E", "F", "F♯", "G", "G♯", "A", "A♯", "B",
    ]

    /// The indices corresponding to natural (whole step) notes only
    let wholeStepIndices = [0, 2, 4, 5, 7, 9, 11]

    // MARK: - Note Generation

    /// # Generates an array of `Note` objects within a specified octave range
    ///
    /// - Parameters:
    ///   - octaves: Range of octaves (e.g., 3...6)
    ///   - includeHalfSteps: Whether to include sharps/flats
    /// - Returns: An array of generated `Note` values
    func generateNotes(
        octaves: ClosedRange<Int> = -1...9,
        includeHalfSteps: Bool = false
    ) -> [Note] {

        var notes = [Note]()
        let indices =
            includeHalfSteps
            ? Array(noteNames.indices)
            : wholeStepIndices

        for octave in octaves {
            for i in indices {
                let name = noteNames[i]
                let midiNote = getMidiNote(octave: octave, index: i)
                let frequency = getFrequency(midiNote: midiNote)
                let newNote = Note(
                    name: name,
                    frequency: frequency,
                    octave: octave,
                    id: midiNote
                )

                if newNote.isValid {
                    notes.append(newNote)
                }
            }
        }

        return notes
    }

    // MARK: - Helper Methods

    /// # Returns a list of note names (with or without half steps)
    func getNoteNames(includeHalfSteps: Bool) -> [String] {
        let indices =
            includeHalfSteps
            ? Array(noteNames.indices)
            : wholeStepIndices
        return indices.map { noteNames[$0] }
    }

    /// # Converts a MIDI note number to frequency using the 440 Hz formula
    func getFrequency(midiNote: Int) -> Float {
        return 440 * pow(2, Float(midiNote - 69) / 12.0)
    }

    /// # Converts octave and note index to MIDI note number
    func getMidiNote(octave: Int, index: Int) -> Int {
        return (octave + 1) * 12 + index
    }

    /// # Finds the index of a note name in the `noteNames` array
    func getIndex(name: String) -> Int {
        return noteNames.firstIndex(of: name) ?? 0
    }

    /// # Creates a full `Note` instance from a name and octave
    func makeNote(name: String, octave: Int) -> Note {
        let index = getIndex(name: name)
        let midiNote = getMidiNote(octave: octave, index: index)
        let frequency = getFrequency(midiNote: midiNote)
        let newNote = Note(
            name: name,
            frequency: frequency,
            octave: octave,
            id: midiNote
        )
        if newNote.isValid {
            return newNote
        } else {
            print("makeNote() returned invalid Note: returning default Note()")
            return Note()
        }
    }
}
