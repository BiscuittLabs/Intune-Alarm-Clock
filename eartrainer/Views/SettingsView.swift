//
//  SettingsView.swift
//  eartrainer
//
//  Created by Zachary Fertig on 6/12/25.
//

import SwiftUI

/// A view for adjusting note generation settings
struct SettingsView: View {
    @ObservedObject var viewModel: NoteViewModel

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Note Options")) {
                    Toggle(
                        "Include Half Steps",
                        isOn: $viewModel.includeHalfSteps
                    )
                    .onChange(of: viewModel.includeHalfSteps) {
                        viewModel.updateNotes()
                    }
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
                    Picker("Playback Mode", selection: $viewModel.playbackMode)
                    {
                        Text("Sine Wave").tag(
                            NoteViewModel.PlaybackMode.sine
                        )
                        Text("Sampler").tag(
                            NoteViewModel.PlaybackMode.sampler
                        )
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
            }
            .navigationTitle("Settings")
        }
    }
}

#Preview {
    SettingsView(viewModel: NoteViewModel())
}
