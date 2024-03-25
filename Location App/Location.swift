//
//  Location.swift
//  Location App
//
//  Created by yatziri on 10/03/24.
//

import SwiftUI
import MapKit

struct LocationView: View {
    @StateObject private var viewModel = LocationModel()
    
    var body: some View {
        Map(coordinateRegion: $viewModel.region , showsUserLocation: true)
           .ignoresSafeArea()
           .accentColor(Color(.systemPink))
           .onAppear{
               viewModel.checkIfLocationServicesIsEnabled()
           }
    }
}

#Preview {
    LocationView()
}
