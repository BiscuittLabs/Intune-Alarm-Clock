//
//  RandomNoteView.swift
//  eartrainer
//
//  Created by Zachary Fertig on 6/11/25.
//

import SwiftUI

/// The main practice view for playing and identifying random musical notes
struct RandomNoteView: View {
    @StateObject private var viewModel = NoteViewModel()

    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Spacer()

                Text(viewModel.currentNote.description)
                    .font(.largeTitle)
                    .fontWeight(.semibold)
                    .padding()

                Button("Play a Random Note") {
                    viewModel.playRandomNote()
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.green)
                .foregroundColor(.white)
                .cornerRadius(10)
                .padding(.horizontal)

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

#Preview {
    RandomNoteView()
}
