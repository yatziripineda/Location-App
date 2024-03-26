//
//  ContentView.swift
//  Location App
//
//  Created by yatziri on 28/11/23.
//

//import MapKit

import SwiftUI
import SwiftData

struct ContentView: View {
    @StateObject private var viewModel = LocationModel()
    
    @State private var searchText = ""
    @State private var isAddingAlarm = false
    @State private var alarmActivationStates: [PersistentIdentifier: Bool] = [:]
       
        
    @Environment(\.modelContext) private var modelContext
    
    @Query private var alarmss: [Alarms]
    @Query private var locations: [Location]
    @Query private var weathers: [Weather]
    
    
    var filteredAlarms: [Alarms] {
        if searchText.isEmpty {
            return alarmss
        } else {
            return alarmss.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
        }
    }

    var body: some View {
        NavigationView {
            VStack {
                SearchBar(text: $searchText)
                List(filteredAlarms) { alarm in
                    HStack {
                        if alarm.isWeatherAlarm == 0 {
                            Image(systemName: "cloud.drizzle.fill")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 50)
                                .padding()
                                .foregroundColor(.blue)
                        } else {
                            Image(systemName:"mappin.and.ellipse.circle")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 50)
                                .padding()
                                .foregroundColor(.green)
                        }
                        VStack(alignment: .leading){
                            Text(alarm.name)
                                .bold()
                                .font(.title3)
                            Text(alarm.sound)
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                        Spacer()
                        Toggle( "", isOn: Binding(
                            get: {
                                alarmActivationStates[alarm.id] ?? alarm.activated
                            },
                            set: { newValue in
                                alarmActivationStates[alarm.id] = newValue
                                alarm.activated = newValue
                                
                            }
                        ))
                        .padding()
                        .toggleStyle(SwitchToggleStyle(tint: .orange))
                        .onAppear(){
                            alarmActivationStates[alarm.id] = alarm.activated
                        }
                    }
                    .swipeActions {
                        Button(role: .destructive) {
                            withAnimation {
                                modelContext.delete(alarm)
                            }
                        } label: {
                            Label("Delete", systemImage: "trash.fill")
                        }
                    }
                }
            }
            .navigationTitle("My Alarms")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        isAddingAlarm = true
                    }) {
                        ZStack{
                            Circle()
                                .foregroundColor(.orange)
                                .frame(width: 30)
//                                Color.orange
                            Image(systemName: "plus")
                                .foregroundColor(.white)
                                .bold()
                                
                        }
                            
                    }
                }
            }
//            .onTapGesture {
//                hideKeyboard()
//            }
            .sheet(isPresented: $isAddingAlarm) {
                NewAlarmView()
            }
            
        }
    }
}

struct SearchBar: View {
    @Binding var text: String

    var body: some View {
        HStack {
            TextField("Search", text: $text)
                .padding(7)
                .padding(.horizontal, 25)
                .background(Color(.systemGray6))
                .cornerRadius(8)
                .padding(.horizontal, 10)
                .overlay(
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.gray)
                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                            .padding(.leading, 8)
                    }
                )
        }
    }
}



#Preview {
    ContentView()
        .modelContainer(for: Alarms.self, inMemory: true)
}
