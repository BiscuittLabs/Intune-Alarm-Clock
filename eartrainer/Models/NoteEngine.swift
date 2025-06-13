//
//  ToneGenerator.swift
//  eartrainer
//
//  Created by Zachary Fertig on 6/10/25.
//

import AVFoundation

/// #A class for generating tones using AVAudioEngine and AVAudioSourceNode
class NoteEngine {
    // MARK: - Calculated Properties
    /// Modes for audio playback: sine wave or sampled instrument
    enum PlaybackMode {
        case sine
        case sampler
    }
    ///-------------------------------------------------------------------------------------------------------
    // MARK: - Properties
    /// Current playback mode
    private let mode: PlaybackMode
    /// Audio engine responsible for managing audio signal flow
    private let engine = AVAudioEngine()
    /// Custom source node that generates audio samples programmatically
    private var sourceNode: AVAudioSourceNode?
    /// Sampler node for playing MIDI notes from a SoundFont
    private var sampler: AVAudioUnitSampler?
    /// The Note to generate
    private var note: Note
    /// Standard audio sample rate (samples per second)
    private let sampleRate: Double = 44100.0
    /// Keeps track of the waveform phase to produce a continuous sine wave
    private var theta: Float = 0.0
    ///-------------------------------------------------------------------------------------------------------
    // MARK: - Initialization
    /// #Initializes the tone generator with a specific frequency
    init(note: Note, mode: PlaybackMode = .sine) {
        self.note = note
        self.mode = mode
        switch mode {
        case .sine:
            createSineSourceNode()
        case .sampler:
            setupSamplerEngine()
        }
    }
    ///-------------------------------------------------------------------------------------------------------
    // MARK: - Methods
    /// #Creates the AVAudioSourceNode with a render block that generates sine wave samples
    private func createSineSourceNode() {
        sourceNode = AVAudioSourceNode {
            _,
            _,
            frameCount,
            audioBufferList -> OSStatus in
            let ablPointer = UnsafeMutableAudioBufferListPointer(
                audioBufferList
            )
            let thetaIncrement =
                2.0 * Float.pi * self.note.frequency / Float(self.sampleRate)

            for frame in 0..<Int(frameCount) {
                /// Generate a sine wave sample
                let sampleVal = sin(self.theta)
                self.theta += thetaIncrement
                if self.theta > 2.0 * Float.pi {
                    self.theta -= 2.0 * Float.pi
                }

                /// Write the sample to each audio channel buffer
                for buffer in ablPointer {
                    let buf = buffer.mData?.assumingMemoryBound(to: Float.self)
                    buf?[frame] = sampleVal
                }
            }

            return noErr
        }
    }
    /// #Sets up the AVAudioUnitSampler and connects it to the engine
    private func setupSamplerEngine() {
        let sampler = AVAudioUnitSampler()
        engine.attach(sampler)
        engine.connect(sampler, to: engine.mainMixerNode, format: nil)
        self.sampler = sampler

        do {
            /// Start the engine before loading soundbank
            try engine.start()

            if let soundbankURL = Bundle.main.url(
                forResource: "Casio_Privia_PX-160",
                withExtension: "sf2",
                subdirectory: "SoundFonts"
            ) {
                try sampler.loadSoundBankInstrument(
                    at: soundbankURL,
                    program: 0,
                    bankMSB: 0x00,
                    bankLSB: 0x00
                )
            } else {
                print("SoundFont file not found.")
            }
        } catch {
            print("Failed to start audio engine: \(error.localizedDescription)")
        }
    }
    /// #Starts playback of a note using the selected playback mode
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
                print("Failed to start engine: \(error.localizedDescription)")
            }
        case .sampler:
            print()
            sampler?.startNote(
                UInt8(self.note.id),
                withVelocity: 64,
                onChannel: 0
            )
        }
    }
    /// #Stops audio playback
    func stop() {
        engine.stop()
    }
}
