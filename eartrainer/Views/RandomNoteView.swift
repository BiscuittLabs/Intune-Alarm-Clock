//
//  RandomNoteView.swift
//  eartrainer
//
//  Created by Zachary Fertig on 6/11/25.
//

import SwiftUI

/// # The main practice view for playing and identifying random musical notes
struct RandomNoteView: View {

    // MARK: - State

    /// ViewModel managing note logic and user interaction
    @StateObject private var viewModel = NoteViewModel()

    ///-------------------------------------------------------------------------------------------------------
    // MARK: - View Body

    var body: some View {
        NavigationView {
            VStack(spacing: 20) {

                Spacer()

                /// Display current note description
                Text(viewModel.currentNote.description)
                    .font(.largeTitle)
                    .fontWeight(.semibold)
                    .padding()

                /// Button to play a random note
                Button("Play a Random Note") {
                    viewModel.playRandomNote()
                    //print(viewModel.selectedSoundFont)
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.green)
                .foregroundColor(.white)
                .cornerRadius(10)
                .padding(.horizontal)

                /// Link to settings view
                NavigationLink("Settings") {
                    SettingsView(viewModel: viewModel)
                }
                .padding()

                Spacer()
            }
            .navigationTitle("Ear Trainer")
        }
    }
}

///-------------------------------------------------------------------------------------------------------
// MARK: - Preview

#Preview {
    RandomNoteView()
}
