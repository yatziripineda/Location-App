//
//  WeatherView.swift
//  Location App
//
//  Created by yatziri on 18/03/24.
//

import SwiftUI

struct WeatherRow: View {
    var weather: String
    var isSelected: Bool
    
    var body: some View {
        HStack {
            Text(weather)
            Spacer()
            if isSelected {
                Image(systemName: "checkmark")
                    .foregroundColor(.blue)
            }
        }
    }
}


