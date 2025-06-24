//
//  Note.swift
//  eartrainer
//
//  Created by Zachary Fertig on 6/11/25.
//

import Foundation

/// # A model representing a musical note with name, frequency, and octave
/// Conforms to `Identifiable` for use in SwiftUI and `Codable` for saving/loading
struct Note: Identifiable, Codable {
    
    // MARK: - Properties
    
    /// A unique identifier (MIDI number) used to distinguish notes
    var id: Int
    
    /// The name of the note (e.g., "C", "D#", "A")
    var name: String
    
    /// Frequency of the note in Hertz (e.g., 440.0 for A4)
    var frequency: Float
    
    /// Octave number the note belongs to (e.g., 4 for A4)
    var octave: Int

    // MARK: - Initialization

    /// # Default initializer
    /// Creates the standard tuning note A4 (440 Hz, MIDI id 69)
    init() {
        self.name = "A"
        self.frequency = 440.0
        self.octave = 4
        self.id = 69
    }

    /// # Custom initializer
    /// Allows creation of any note with specific properties
    init(name: String, frequency: Float, octave: Int, id: Int) {
        self.name = name
        self.frequency = frequency
        self.octave = octave
        self.id = id
    }

    // MARK: - Computed Properties

    /// # Readable string representation of the note
    /// Format: "C4 - 261.63 Hz"
    var description: String {
        return "\(name)\(octave) - \(String(format: "%.2f", frequency)) Hz"
    }

    /// # Validity check for octave and frequency ranges
    /// Ensures the note is musically meaningful
    var isValid: Bool {
        return frequency > 0 && (-1...9).contains(octave) && (0...127).contains(id)
    }
}
