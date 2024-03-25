//
//  SoundsView.swift
//  Location App
//
//  Created by yatziri on 18/03/24.
//

import SwiftUI

struct SoundsView: View {
    let sounds = ["Sound 1", "Sound 2", "Sound 3"] // Lista de nombres de sonidos
    @State private var selectedSound: String?
    
    var body: some View {
        NavigationView {
            List(sounds, id: \.self) { sound in
                SoundRow(sound: sound, isSelected: sound == selectedSound)
                    .onTapGesture {
                        selectedSound = sound
                    }
            }
            .navigationTitle("Sounds")
            .navigationBarTitleDisplayMode(.inline)
            
//
        }
    }
}

struct SoundRow: View {
    var sound: String
    var isSelected: Bool
    
    var body: some View {
        HStack {
            Text(sound)
            Spacer()
            if isSelected {
                Image(systemName: "checkmark")
                    .foregroundColor(.blue)
            }
        }
    }
}

#Preview {
    SoundsView()
}
