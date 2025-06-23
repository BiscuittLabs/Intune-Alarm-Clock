//
//  Note.swift
//  eartrainer
//
//  Created by Zachary Fertig on 6/11/25.
//

import Foundation

/// # A model representing a musical note with name, frequency, and octave
struct Note: Identifiable, Codable {
    // MARK: - Properties
    /// Unique identifier for use in SwiftUI views
    var id: Int
    /// The note's name, e.g., "A", "C♯"
    var name: String
    /// The note's frequency in Hz
    var frequency: Float
    /// The note's octave (e.g., 4 for A4)
    var octave: Int

    ///-------------------------------------------------------------------------------------------------------
    // MARK: - Initialization

    /// # Default initializer creating an A4 note
    init() {
        self.name = "A"
        self.frequency = 440.0
        self.octave = 4
        self.id = 69
    }

    /// # Custom initializer
    init(name: String, frequency: Float, octave: Int, id: Int) {
        self.name = name
        self.frequency = frequency
        self.octave = octave
        self.id = id
    }

    ///-------------------------------------------------------------------------------------------------------
    // MARK: - Computed Properties

    /// Description of the note for display purposes
    var description: String {
        return "\(name)\(octave) - \(String(format: "%.2f", frequency)) Hz"
    }

    /// Validates that frequency and octave are within realistic bounds
    var isValid: Bool {
        return frequency > 0 && (-1...9).contains(octave)
    }
}
