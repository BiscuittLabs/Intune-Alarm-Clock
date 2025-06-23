//
//  SettingsView.swift
//  eartrainer
//
//  Created by Zachary Fertig on 6/12/25.
//

import SwiftUI

/// # A view for adjusting note generation settings
struct SettingsView: View {

    // MARK: - Observed Object

    /// ViewModel managing settings logic and state
    @ObservedObject var viewModel: NoteViewModel

    ///-------------------------------------------------------------------------------------------------------
    // MARK: - View Body

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Note Options")) {

                    /// Toggle for including half steps in note generation
                    Toggle(
                        "Include Half Steps",
                        isOn: $viewModel.includeHalfSteps
                    )
                    .onChange(of: viewModel.includeHalfSteps) {
                        viewModel.updateNotes()
                    }

                    /// Octave range steppers
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

                    /// Playback mode picker
                    Picker("Playback Mode", selection: $viewModel.playbackMode)
                    {
                        Text("Sine Wave").tag(NoteViewModel.PlaybackMode.sine)
                        Text("Sampler").tag(NoteViewModel.PlaybackMode.sampler)
                    }
                    .pickerStyle(SegmentedPickerStyle())

                    /// SoundFont picker (only visible when using sampler)
                    if viewModel.playbackMode == .sampler {
                        List {
                            Picker(selection: $viewModel.selectedSoundFont) {
                                ForEach(
                                    viewModel.availableSoundFonts,
                                    id: \.self
                                ) {
                                    font in
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
                viewModel.updateSoundFonts()
            }
        }
    }
}

///-------------------------------------------------------------------------------------------------------
// MARK: - Preview

#Preview {
    SettingsView(viewModel: NoteViewModel())
}
