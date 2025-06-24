//
//  SettingsView.swift
//  eartrainer
//
//  Created by Zachary Fertig on 6/12/25.
//

import SwiftUI

/// # A view for adjusting note generation and playback settings
/// This interface allows users to customize note generation range, playback type, and SoundFont selection
struct SettingsView: View {

    // MARK: - Observed Object

    /// ViewModel managing the user settings and their effects
    @ObservedObject var viewModel: NoteSettingsViewModel

    // MARK: - View Body

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Note Options")) {

                    /// Toggle for enabling or disabling half steps (sharps/flats)
                    Toggle(
                        "Include Half Steps",
                        isOn: $viewModel.includeHalfSteps
                    )
                    .onChange(of: viewModel.includeHalfSteps) {
                        viewModel.updateNotes() // Refresh notes on toggle change
                    }

                    /// Steppers for adjusting the low and high octave bounds
                    VStack(alignment: .leading) {
                        Stepper(
                            "Low Octave: \(viewModel.lowOctave)",
                            value: $viewModel.lowOctave,
                            in: -1...9
                        )
                        Stepper(
                            "High Octave: \(viewModel.highOctave)",
                            value: $viewModel.highOctave,
                            in: -1...9
                        )
                    }
                    .padding(.vertical)

                    /// Picker to choose between playback types: sine wave or sample-based
                    Picker("Playback Mode", selection: $viewModel.playbackMode) {
                        Text("Sine Wave").tag(NoteSettingsViewModel.PlaybackMode.sine)
                        Text("Sampler").tag(NoteSettingsViewModel.PlaybackMode.sampler)
                    }
                    .pickerStyle(SegmentedPickerStyle())

                    /// Conditional UI: Display SoundFont picker only when using sampler mode
                    if viewModel.playbackMode == .sampler {
                        List {
                            Picker(selection: $viewModel.selectedSoundFont) {
                                ForEach(viewModel.availableSoundFonts, id: \.self) { font in
                                    Text(font).tag(font)
                                }
                            } label: {
                                Text("Sound Font")
                            }
                        }
                    }
                }
            }
            .navigationTitle("Settings")
            .onAppear {
                viewModel.updateSoundFonts() // Ensure fonts are loaded on view entry
            }
        }
    }
}

// MARK: - Preview

#Preview {
    SettingsView(viewModel: NoteSettingsViewModel())
}
