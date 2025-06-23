//
//  NotePlayer.swift
//  eartrainer
//
//  Created by Zachary Fertig on 6/11/25.
//

import AVFoundation
import Foundation

/// # A utility for playing notes using NoteEngine
struct NotePlayer {

    // MARK: - Methods

    /// # Plays a note for a specified duration using the given playback mode and sound font
    ///
    /// - Parameters:
    ///   - note: The `Note` to play
    ///   - duration: The length of time to play the note
    ///   - mode: Playback mode (`sine` or `sampler`)
    ///   - soundFont: Optional name of the SoundFont file
    func playNote(
        note: Note,
        duration: TimeInterval = 1.0,
        mode: NoteEngine.PlaybackMode,
        soundFont: String?
    ) {
        let engine = NoteEngine(
            note: note,
            mode: mode,
            soundFontName: soundFont
        )
        engine.play()

        DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
            engine.stop()
        }
    }
}
