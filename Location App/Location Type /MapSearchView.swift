//
//  MapSearchView.swift
//  Location App
//
//  Created by yatziri on 22/03/24.
//

import SwiftUI
import MapKit

struct MapSearchView: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

    @State private var position = MapCameraPosition.automatic
    @State private var searchResults = [SearchResult]()
    @State private var selectedLocation: SearchResult?
    @State private var isSheetPresented: Bool = true
    @State private var isPresented: Bool = true
    @State private var Name: String = ""
    @Binding var TextEndLocation: String
    @Binding var SelectEndLocation:  Location?
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
                    ZStack{
                        
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
                        if selectedLocation != nil {
                            Button(action: {
                                TextEndLocation = Name
                                SelectEndLocation?.location1 = Coordinate2D(latitude: (selectedLocation?.location.latitude)!, longitude: (selectedLocation?.location.longitude)!)
                                self.presentationMode.wrappedValue.dismiss()
                            }) {
                                VStack{
                                    Spacer()
                                    HStack {
                                        Text("Select Place")
                                            .foregroundColor(.white)
                                        
                                    }
                                    .padding(.horizontal, 40)
                                    .padding()
                                    .background(Color.blue)
                                    .cornerRadius(8)
                                    
                                }
                                .padding()
                            }
                        }
                        
                    }
                }
                else{
                    SearchPointView(searchResults: $searchResults, isPresented: $isPresented, Name: $Name)
                }
            }
            .navigationBarHidden(true)
        }
    }
}
//
//#Preview {
//    MapSearchView()
//}
