//
//  NoteEngine.swift
//  eartrainer
//
//  Created by Zachary Fertig on 6/11/25.
//

import AVFoundation
import Foundation

struct NotePlayer {
    // MARK: - Methods
    /// Plays a random note from an array of Note
    func playNote(note: Note, duration: TimeInterval = 1.0, mode: NoteEngine.PlaybackMode) {
        let engine = NoteEngine(note: note, mode: mode)
        engine.play()

        DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
            engine.stop()
        }
    }
}
