//
//  NoteSettingsViewModel.swift
//  eartrainer
//
//  Created by Zachary Fertig on 6/24/25.
//

import Foundation

/// # ViewModel managing user-configurable settings
/// This includes the generation range, playback mode, and available sound fonts.
/// It acts as the settings layer of the app's architecture, separate from game logic.
class NoteSettingsViewModel: ObservableObject {

    // MARK: - Published Properties

    /// Toggle to include sharps/flats in the generated notes
    @Published var includeHalfSteps: Bool = false {
        didSet { updateNotes() }
    }

    /// Range of octaves selected by the user (e.g., 3...6)
    @Published var octaveRange: ClosedRange<Double> = 3...6 {
        didSet { updateNotes() }
    }

    /// The selected playback mode (sine wave or sampler)
    @Published var playbackMode: NoteEngine.PlaybackMode = .sine

    /// SoundFont files discovered in the app bundle
    @Published var availableSoundFonts: [String] = []

    /// The currently selected SoundFont file (if using sampler mode)
    @Published var selectedSoundFont: String = "HappyMellow.sf2"

    /// Lowest octave shown in settings (used to update octaveRange)
    @Published var lowOctave: Int = 3 {
        didSet {
            if lowOctave > highOctave { highOctave = lowOctave }
            updateRange()
        }
    }

    /// Highest octave shown in settings (used to update octaveRange)
    @Published var highOctave: Int = 6 {
        didSet {
            if highOctave < lowOctave { lowOctave = highOctave }
            updateRange()
        }
    }

    // MARK: - Computed Note Name Lists

    /// Note names that represent whole steps only (e.g., C, D, E)
    var naturalNotes: [String] {
        generator.getNoteNames(includeHalfSteps: false)
    }

    /// Sharp/flat notes only (e.g., C♯, D♯), filtered out from full list
    var sharpNotes: [String] {
        includeHalfSteps
            ? generator.getNoteNames(includeHalfSteps: true).filter {
                !naturalNotes.contains($0)
            }
            : []
    }

    /// Combines playback settings for easier passing to other layers
    var playback: PlaybackSettings {
        PlaybackSettings(
            mode: playbackMode,
            soundFont: selectedSoundFont
        )
    }

    // MARK: - Private Properties

    /// Responsible for creating all possible notes based on settings
    private var generator = NoteGenerator()

    /// Cached list of all generated notes
    private(set) var notes: [Note] = []

    /// Optional typealias to improve readability in views
    typealias PlaybackMode = NoteEngine.PlaybackMode

    // MARK: - Initialization

    /// Initializes the view model and prepares notes and fonts
    init() {
        updateNotes()
        updateSoundFonts()
    }

    // MARK: - Methods

    /// # Updates the list of notes when settings change
    func updateNotes() {
        let octaveBounds = Int(octaveRange.lowerBound)...Int(octaveRange.upperBound)
        notes = generator.generateNotes(
            octaves: octaveBounds,
            includeHalfSteps: includeHalfSteps
        )
    }

    /// # Converts integer bounds into octaveRange and updates notes
    func updateRange() {
        octaveRange = Double(lowOctave)...Double(highOctave)
        updateNotes()
    }

    /// # Scans the app bundle for SoundFont (.sf2) files
    func updateSoundFonts() {
        availableSoundFonts = NoteEngine.loadSoundFonts()
    }

    /// # Picks a random note from the currently generated list
    func getRandomNote() -> Note {
        return notes.randomElement() ?? Note()
    }
}
