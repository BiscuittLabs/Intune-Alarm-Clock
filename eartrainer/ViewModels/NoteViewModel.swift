//
//  NoteViewModel.swift
//  eartrainer
//
//  Created by Zachary Fertig on 6/12/25.
//

import Foundation

/// A ViewModel that manages note generation and playback logic for the UI
class NoteViewModel: ObservableObject {
    // MARK: - Published Properties
    /// Determines if half steps (sharps/flats) are included in the note set
    @Published var includeHalfSteps: Bool = false {
        didSet { updateNotes() }
    }
    /// The selected range of octaves, used to generate notes
    @Published var octaveRange: ClosedRange<Double> = 3...6 {
        didSet { updateNotes() }
    }
    @Published var playbackMode: NoteEngine.PlaybackMode = .sine
    /// The currently selected or played note, exposed to the UI
    @Published var currentNote: Note = Note()
    
    // MARK: - Published Computed Properties
    /// The currently selected low octave range, default to 3 min -1, exposed to the UI
    /// Makes sure that lowOctave.value is never higher than highOctave.vale
    @Published var lowOctave: Int = 3 {
        didSet {
            if lowOctave > highOctave { highOctave = lowOctave }
            updateRange()
        }
    }
    /// The currently selected high octave range, default to 6 max 9, exposed to the UI
    /// Makes sure that highOctave.value is never lower than lowOctave.vale
    @Published var highOctave: Int = 6 {
        didSet {
            if highOctave < lowOctave { lowOctave = highOctave }
            updateRange()
        }
    }

    // MARK: - Private Properties
    /// The list of notes generated based on current settings
    private var notes: [Note] = []
    /// The audio engine responsible for tone playback
    private let engine = NotePlayer()
    /// The note generator responsible for creating an array
    private let generator = NoteGenerator()
    /// The playbackmode enum from NoteEngine
    typealias PlaybackMode = NoteEngine.PlaybackMode

    // MARK: - Initialization
    init() {
        updateNotes()
    }

    // MARK: - Methods
    /// Regenerates the list of notes based on current settings
    func updateNotes() {
        let octaveBounds =
            Int(octaveRange.lowerBound)...Int(octaveRange.upperBound)
        notes = generator.generateNotes(
            octaves: octaveBounds,
            includeHalfSteps: includeHalfSteps
        )
    }
    /// Selects and plays a random note from the generated list
    func playRandomNote() {
        currentNote = notes.randomElement()!
        engine.playNote(note: currentNote, mode: playbackMode)
    }
    /// Updates octave range based on user values
    private func updateRange() {
        octaveRange = Double(lowOctave)...Double(highOctave)
        updateNotes()
    }
}
