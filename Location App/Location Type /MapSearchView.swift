//
//  MapSearchView.swift
//  Location App
//
//  Created by yatziri on 22/03/24.
//

import SwiftUI
import MapKit

struct MapSearchView: View {
    @State private var position = MapCameraPosition.automatic
    // 1
    @State private var searchResults = [SearchResult]()
    //2
    @State private var selectedLocation: SearchResult?
    @State private var isSheetPresented: Bool = true
    @State private var isPresented: Bool = true
    var body: some View {
        NavigationStack{
            VStack{
//                VStack{
                if isPresented{
                    Button(action: { isPresented.toggle() }) {
                        HStack {
                            Image(systemName: "magnifyingglass")
                                .foregroundColor(.gray)
                                .padding([.top, .bottom, .trailing])
                            Text("Where do you want to go?")
                                .foregroundColor(.gray)
                            Spacer()
                        }
                        .padding(.horizontal, 20)
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(10)
                        .padding(.horizontal, 15)
                    }
                
//                }
//                if isPresented{
//                    Map(coordinateRegion: $viewModel.region , showsUserLocation: true)
//                       .ignoresSafeArea()
//                       .accentColor(Color(.systemPink))
//                       .onAppear{
//                           viewModel.checkIfLocationServicesIsEnabled()
//                       }
                    Map(position: $position, selection: $selectedLocation) {
                        ForEach(searchResults) { result in
                            Marker(coordinate: result.location) {
                                Image(systemName: "mappin")
                            }
                            .tag(result)
                        }
                    }
                    .ignoresSafeArea()
                    .onChange(of: selectedLocation) {
                        isSheetPresented = selectedLocation == nil
                    }
                    .onChange(of: searchResults) {
                        if let firstResult = searchResults.first, searchResults.count == 1 {
                            selectedLocation = firstResult
                        }
                    }
                }
                else{
                    SearchPointView(searchResults: $searchResults, isPresented: $isPresented)
                }
            }
        }
    }
}

#Preview {
    MapSearchView()
}
