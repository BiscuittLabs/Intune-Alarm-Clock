//
//  NoteViewModel.swift
//  eartrainer
//
//  Created by Zachary Fertig on 6/12/25.
//

import Foundation

/// # A ViewModel that manages note generation and playback logic for the UI
class NoteViewModel: ObservableObject {

    ///-------------------------------------------------------------------------------------------------------
    // MARK: - Published Properties

    /// Determines if half steps (sharps/flats) are included in the note set
    @Published var includeHalfSteps: Bool = false {
        didSet { updateNotes() }
    }

    /// The selected range of octaves, used to generate notes
    @Published var octaveRange: ClosedRange<Double> = 3...6 {
        didSet { updateNotes() }
    }

    /// Current playback mode (sine or sampler)
    @Published var playbackMode: NoteEngine.PlaybackMode = .sine

    /// The currently selected or played note
    @Published var currentNote: Note = Note()

    /// The currently available soundFonts
    @Published var availableSoundFonts: [String] = []

    /// The currently selected soundFont
    @Published var selectedSoundFont: String = "HappyMellow.sf2"

    ///-------------------------------------------------------------------------------------------------------
    // MARK: - Published Computed Properties

    /// Low octave value (updates range and highOctave if needed)
    @Published var lowOctave: Int = 3 {
        didSet {
            if lowOctave > highOctave { highOctave = lowOctave }
            updateRange()
        }
    }

    /// High octave value (updates range and lowOctave if needed)
    @Published var highOctave: Int = 6 {
        didSet {
            if highOctave < lowOctave { lowOctave = highOctave }
            updateRange()
        }
    }

    ///-------------------------------------------------------------------------------------------------------
    // MARK: - Private Properties

    /// The list of notes generated based on current settings
    private var notes: [Note] = []

    /// The audio player responsible for tone playback
    private let player = NotePlayer()

    /// The note generator responsible for creating note arrays
    private let generator = NoteGenerator()

    /// The playback mode enum
    typealias PlaybackMode = NoteEngine.PlaybackMode

    ///-------------------------------------------------------------------------------------------------------
    // MARK: - Initialization

    /// # Initializes and prepares the default note set
    init() {
        updateNotes()
    }

    ///-------------------------------------------------------------------------------------------------------
    // MARK: - Methods

    /// # Regenerates the list of notes based on current settings
    func updateNotes() {
        let octaveBounds =
            Int(octaveRange.lowerBound)...Int(octaveRange.upperBound)
        notes = generator.generateNotes(
            octaves: octaveBounds,
            includeHalfSteps: includeHalfSteps
        )
    }

    /// # Selects and plays a random note from the generated list
    func playRandomNote() {
        currentNote = notes.randomElement()!
        player.playNote(
            note: currentNote,
            mode: playbackMode,
            soundFont: selectedSoundFont
        )
    }

    /// # Updates the octave range based on low and high values
    private func updateRange() {
        octaveRange = Double(lowOctave)...Double(highOctave)
        updateNotes()
    }

    /// # Updates the available SoundFonts from the app bundle
    func updateSoundFonts() {
        availableSoundFonts = NoteEngine.loadSoundFonts()
    }
}
