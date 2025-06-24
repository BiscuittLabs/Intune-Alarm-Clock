//
//  NotePlayer.swift
//  eartrainer
//
//  Created by Zachary Fertig on 6/11/25.
//

import AVFoundation
import Foundation

/// # A utility for playing notes using `NoteEngine`
/// This struct abstracts the process of setting up and triggering note playback
struct NotePlayer {

    // MARK: - Methods

    /// # Plays a musical note using the specified playback configuration
    ///
    /// - Parameters:
    ///   - note: The `Note` object containing frequency, name, and octave to play
    ///   - duration: The time in seconds the note should sound (default: 1.0 sec)
    ///   - mode: The playback mode to use (`.sine` for synthesized sine wave, `.sampler` for MIDI-based SoundFont playback)
    ///   - soundFont: The name of the SoundFont file to use (if applicable for `.sampler` mode)
    func playNote(
        note: Note,
        duration: TimeInterval = 1.0,
        mode: NoteEngine.PlaybackMode,
        soundFont: String?
    ) {
        // Initialize the playback engine with the desired note and configuration
        let engine = NoteEngine(
            note: note,
            mode: mode,
            soundFontName: soundFont
        )

        // Begin playing the note
        engine.play()

        // Schedule stopping the engine after the specified duration
        DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
            engine.stop()
        }
    }
}
