//
//  PlaybackSettings.swift
//  eartrainer
//
//  Created by Zachary Fertig on 6/24/25.
//

import Foundation
import AVFoundation

/// # A lightweight model for audio playback configuration
/// This struct encapsulates user-selected playback preferences for consistent note rendering
struct PlaybackSettings {
    // MARK: - Properties

    /// # Playback mode determines how the sound is generated
    /// - `.sine` produces a pure synthesized tone
    /// - `.sampler` plays back using a loaded SoundFont file
    let mode: NoteEngine.PlaybackMode

    /// # The name of the selected SoundFont (.sf2) file to use in sampler mode
    /// This should match a filename in the app bundle, e.g., "HappyMellow.sf2"
    let soundFont: String
}
