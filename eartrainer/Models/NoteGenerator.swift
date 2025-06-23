//
//  NoteGenerator.swift
//  eartrainer
//
//  Created by Zachary Fertig on 6/12/25.
//

import Foundation

/// # A struct that creates an array of `Note` based on the provided settings
struct NoteGenerator {

    // MARK: - Properties

    /// The names of all the notes by semitone
    let noteNames = [
        "C", "C♯", "D", "D♯", "E", "F", "F♯", "G", "G♯", "A", "A♯", "B",
    ]

    /// The indices of the whole steps only
    let wholeStepIndices = [0, 2, 4, 5, 7, 9, 11]

    ///-------------------------------------------------------------------------------------------------------
    // MARK: - Note Generation

    /// # Generates an array of notes based on the octave range and whether to include half steps
    ///
    /// - Parameters:
    ///   - octaves: The range of octaves to generate notes for
    ///   - includeHalfSteps: Whether to include half steps (sharps/flats)
    /// - Returns: An array of `Note` objects matching the criteria
    func generateNotes(
        octaves: ClosedRange<Int> = -1...9,
        includeHalfSteps: Bool = false
    ) -> [Note] {

        /// Initialize the array to be returned
        var notes = [Note]()

        /// Determine the note indices to loop over
        let indices =
            includeHalfSteps ? Array(noteNames.indices) : wholeStepIndices

        /// Loop over each octave
        for octave in octaves {
            /// Loop over the selected note indices
            for i in indices {
                /// Create note properties
                let name = noteNames[i]
                let midiNote = (octave + 1) * 12 + i

                /// Skip if MIDI note is outside valid range (0-127)
                guard midiNote <= 127 else { continue }

                /// Calculate the frequency using the MIDI to frequency formula
                let frequency = 440 * pow(2, Float(midiNote - 69) / 12.0)

                /// Append note to array
                notes.append(
                    Note(
                        name: name,
                        frequency: frequency,
                        octave: octave,
                        id: midiNote
                    )
                )
            }
        }

        return notes
    }
}
