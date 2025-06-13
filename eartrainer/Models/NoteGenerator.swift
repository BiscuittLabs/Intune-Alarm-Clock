//
//  NoteGenerator.swift
//  eartrainer
//
//  Created by Zachary Fertig on 6/12/25.
//

import Foundation

//This struct creates an array of Note based on input
struct NoteGenerator {
    ///The names of all the notes by semitone
    let noteNames = [
        "C", "C♯", "D", "D♯", "E", "F", "F♯", "G", "G♯", "A", "A♯", "B",
    ]
    ///The indicies of the whole steps only
    let wholeStepIndices = [0, 2, 4, 5, 7, 9, 11]

    //generateNotes takes a range of octaves and a boolean to include half steps or not
    //then returns an array of type Note that fit the constraints
    func generateNotes(
        octaves: ClosedRange<Int> = -1...9,
        includeHalfSteps: Bool = false
    ) -> [Note] {
        ///Initialize the array to be returned
        var notes = [Note]()

        ///Initialize the indicies to loop over with only whole steps or all indicies based on includeHalfSteps
        let indices =
            includeHalfSteps ? Array(noteNames.indices) : wholeStepIndices

        ///For  the octave range
        for octave in octaves {
            ///And note indecies
            for i in indices {
                ///Create a Note with the appropriate name, frequency, and octave and add it to our array
                let name = noteNames[i]
                ///MIDI note number (C4 = 60 = 5 * 12 + 0)
                let midiNote = (octave + 1) * 12 + i
                ///Skip if MIDI note is outside valid range (0-127)
                guard midiNote <= 127 else { continue }
                ///Frequency formula: every semitone is a factor of 2^(1/12) from the next using C4 as a reference
                ///A4 = 440 Hz = 261.63 * 2^((69 - 60) / 12.0)
                let frequency = 440 * pow(2, Float(midiNote - 69) / 12.0)

                ///Append note to Array
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
