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

    /// Whether the last guess was correct (nil if not yet guessed)
    @Published var guessedCorrectly: Bool? = nil

    ///-------------------------------------------------------------------------------------------------------
    // MARK: - Computed Properties

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

    /// Natural (whole step) note names
    var naturalNotes: [String] {
        generator.getNoteNames(includeHalfSteps: false)
    }

    /// Half step note names (only if includeHalfSteps is true)
    var sharpNotes: [String] {
        includeHalfSteps
            ? generator.getNoteNames(includeHalfSteps: true).filter {
                !naturalNotes.contains($0)
            }
            : []
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

    /// Returns frequency for given note name and octave
    private func frequencyFor(name: String, octave: Int) -> Float {
        let noteIndex = generator.noteNames.firstIndex(of: name) ?? 0
        let midiNote = (octave + 1) * 12 + noteIndex
        return 440 * pow(2, Float(midiNote - 69) / 12.0)
    }

    /// Returns MIDI note number for name + octave
    private func midiNumberFor(name: String, octave: Int) -> Int {
        let noteIndex = generator.noteNames.firstIndex(of: name) ?? 0
        return (octave + 1) * 12 + noteIndex
    }
    
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
        /// Reset before showing new note
        guessedCorrectly = nil

        currentNote = notes.randomElement()!
        player.playNote(
            note: currentNote,
            mode: playbackMode,
            soundFont: selectedSoundFont
        )
    }

    /// # Plays the selected Note
    func playSelectedNote() {
        player.playNote(
            note: currentNote,
            mode: playbackMode,
            soundFont: selectedSoundFont
        )
        print(currentNote)
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

    /// Compares the user's guess to the current note and sets guessedCorrectly
    func checkUserGuess(_ guess: String) {
        guessedCorrectly = guess == currentNote.name
        print("Guessed \(guess). Actual: \(currentNote.name)")

        /// Play guessed note in same octave
        let guessedNote = Note(
            name: guess,
            frequency: frequencyFor(name: guess, octave: currentNote.octave),
            octave: currentNote.octave,
            id: midiNumberFor(name: guess, octave: currentNote.octave)
        )

        player.playNote(
            note: guessedNote,
            mode: playbackMode,
            soundFont: selectedSoundFont
        )
    }
}
