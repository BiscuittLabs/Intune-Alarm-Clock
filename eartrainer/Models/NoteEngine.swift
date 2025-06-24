//
//  NoteEngine.swift
//  eartrainer
//
//  Created by Zachary Fertig on 6/10/25.
//

import AVFoundation

/// # A class for generating tones using AVFoundation
/// Supports two playback modes: generated sine waves and sampled instruments using SoundFonts
class NoteEngine {

    // MARK: - Playback Modes

    /// Enum to switch between synthesis and sampled playback
    enum PlaybackMode {
        case sine      // Generate tone programmatically
        case sampler   // Play pre-recorded sound from a SoundFont
    }

    // MARK: - Properties

    /// Which mode to use for audio playback
    private let mode: PlaybackMode

    /// Core AVFoundation audio engine that routes sound
    private let engine = AVAudioEngine()

    /// Custom node for generating sine wave samples
    private var sourceNode: AVAudioSourceNode?

    /// Sampler node that plays MIDI notes using SoundFont
    private var sampler: AVAudioUnitSampler?

    /// Note object containing frequency and other info
    private var note: Note

    /// Audio sampling rate in Hz (standard for audio)
    private let sampleRate: Double = 44100.0

    /// Current phase of the sine wave (used for continuous waveform)
    private var theta: Float = 0.0

    // MARK: - Initialization

    /// # Create a NoteEngine to play a single note
    /// - Parameters:
    ///   - note: The musical note to generate
    ///   - mode: Whether to use sine wave or sample playback
    ///   - soundFontName: Optional name of a .sf2 file for sampler mode
    init(note: Note, mode: PlaybackMode = .sine, soundFontName: String? = nil) {
        self.note = note
        self.mode = mode
        switch mode {
        case .sine:
            createSineSourceNode()
        case .sampler:
            setupSamplerEngine(using: soundFontName)
        }
    }

    // MARK: - Engine Setup Methods

    /// # Build an audio node that generates sine wave samples in real time
    private func createSineSourceNode() {
        sourceNode = AVAudioSourceNode {
            _, _, frameCount, audioBufferList in
            let ablPointer = UnsafeMutableAudioBufferListPointer(audioBufferList)
            let thetaIncrement = 2.0 * Float.pi * self.note.frequency / Float(self.sampleRate)

            for frame in 0..<Int(frameCount) {
                let sampleVal = sin(self.theta)
                self.theta += thetaIncrement
                if self.theta > 2.0 * Float.pi {
                    self.theta -= 2.0 * Float.pi
                }

                for buffer in ablPointer {
                    let buf = buffer.mData?.assumingMemoryBound(to: Float.self)
                    buf?[frame] = sampleVal
                }
            }

            return noErr
        }
    }

    /// # Sets up the sampler with the provided SoundFont
    private func setupSamplerEngine(using soundFontName: String?) {
        let sampler = AVAudioUnitSampler()
        engine.attach(sampler)
        engine.connect(sampler, to: engine.mainMixerNode, format: nil)
        self.sampler = sampler

        do {
            try engine.start()

            if let soundbankURL = Bundle.main.url(
                forResource: soundFontName?.replacingOccurrences(of: ".sf2", with: ""),
                withExtension: "sf2"
            ) {
                try sampler.loadSoundBankInstrument(
                    at: soundbankURL,
                    program: 0,
                    bankMSB: UInt8(kAUSampler_DefaultMelodicBankMSB),
                    bankLSB: 0x00
                )
            } else {
                print("⚠️ SoundFont file not found, defaulting to sine wave.")
                createSineSourceNode()
            }
        } catch {
            print("❌ Failed to start audio engine: \(error.localizedDescription)")
        }
    }

    // MARK: - Utility

    /// # Returns all `.sf2` files in the app's main bundle
    static func loadSoundFonts() -> [String] {
        var availableSoundFonts = [String]()
        if let resourcePath = Bundle.main.resourcePath {
            do {
                let files = try FileManager.default.contentsOfDirectory(atPath: resourcePath)
                availableSoundFonts = files.filter { $0.hasSuffix(".sf2") }
            } catch {
                print("⚠️ Failed to load SoundFonts: \(error)")
            }
        }
        return availableSoundFonts
    }

    // MARK: - Playback Controls

    /// # Begins playing the configured note
    func play() {
        switch mode {
        case .sine:
            guard let sourceNode = sourceNode else { return }
            engine.attach(sourceNode)
            engine.connect(
                sourceNode,
                to: engine.mainMixerNode,
                format: AVAudioFormat(
                    standardFormatWithSampleRate: sampleRate,
                    channels: 1
                )
            )
            do {
                try engine.start()
            } catch {
                print("❌ Failed to start engine: \(error.localizedDescription)")
            }
        case .sampler:
            sampler?.startNote(UInt8(self.note.id), withVelocity: 64, onChannel: 0)
        }
    }

    /// # Stops playback and shuts down the engine
    func stop() {
        engine.stop()
    }
}
