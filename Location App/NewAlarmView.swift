//
//  NewAlarmView.swift
//  Location App
//
//  Created by yatziri on 18/03/24.
//
import SwiftUI
import SwiftData



struct NewAlarmView: View {
    @State private var TypeAlarm = 0
    @State private var snooze: Bool = false
    @State private var name: String = ""
    @State private var selected: Bool = false
    @State private var isEditing = false
    @State private var selectedWeather: WeatherData?
    @State private var TextStartLocation: String = "Your location"
    @State private var SelectStartLocation: Location?
    @State private var TextEndLocation: String = "Where do you want to go?"
    @State private var SelectEndLocation: Location?
    
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) var modelContext
    
    @Query private var alarmss: [Alarms]
    @Query private var locations: [Location]
//    @Query private var weathers: [Weather]
    var weathers: [WeatherData] = [
        WeatherData(temperature: 25, condition: "Sunny"),
        WeatherData(temperature: 15, condition: "Cloudy"),
        WeatherData(temperature: 20, condition: "Partly Cloudy")
    ]
    
    
    @State var selectedAlarm: Alarms?
    @State var selectedLocation: Location?
//    @State var selectedWeather: Weather?
    
    var item: Alarms = Alarms(snooze: false, name: "", activated: true, sound: "Sound1", isWeatherAlarm: 0, weather: WeatherData(temperature: 15, condition: "Cloudy"), locationStart: nil)
//    let weathers = ["Weather 1", "Weather 2", "Weather 3"]
    
    var body: some View {
        NavigationView {
            VStack {
                Picker(selection: $TypeAlarm, label: Text("Select")) {
                    Text("Weather").tag(0)
                    Text("Location").tag(1)
                }.pickerStyle(SegmentedPickerStyle())
                    .padding(.vertical)
//                ScrollView {
                    VStack{
                        if TypeAlarm != 0{
                            NavigationLink(destination: MapSearchView(TextEndLocation: $TextEndLocation, SelectEndLocation: $SelectEndLocation)) {
                                HStack {
                                    Image(systemName: "magnifyingglass")
                                        .foregroundColor(.gray)
                                        .padding()
                                    Text(TextEndLocation)
                                        .foregroundColor(.gray)
                                    Spacer()
                                }
                                .padding(.horizontal, 12)
                                .background(
                                    RoundedRectangle(cornerRadius: 8)
                                        .shadow(color: Color.black.opacity(0.5), radius: 4, x: 0, y: 2)
                                )
                            }.accentColor(.white)


                        }
                        List {
                            
                            Section(header: Text("")) {
                                Toggle("Snooze", isOn: $snooze)
                                HStack{
                                    Text("Label")
                                    Spacer()
                                    TextField("Alarm", text: $name)
                                        .multilineTextAlignment(.trailing)
                                }
                                NavigationLink(destination: SoundsView()) {
                                    Text("Sound")
                                }
                            }
                            
                            if TypeAlarm == 0{
                                Section(header: Text("Select")) {
                                    ForEach(weathers, id: \.self) { weather in
                                        WeatherRow(weather: weather, isSelected: self.selectedWeather == weather)
                                            .onTapGesture {
                                                self.selectedWeather = weather
                                            }
                                        
                                    }
                                }
                            }
                        }
                        //                    .listStyle(PlainListStyle())
                    }
//                }
                ZStack{
                    Rectangle()
                        .foregroundColor(.blue)
                        .frame( height: 40.0)
                        .cornerRadius(8)
                        .padding()
                    Button("Save") {
                        save()
                        dismiss()
                    }
                    .bold()
                    .foregroundColor(.white)
                    
                }
                
            }.padding()
                .navigationTitle("New Alarm")
                .navigationBarTitleDisplayMode(.inline)
                .navigationBarBackButtonHidden(true)
//                .navigationBarHidden(true)
//                .onTapGesture {
//                    hideKeyboard()
//                }
            
        }
    }
}

extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}




private extension  NewAlarmView {
    
    func save() {
        item.name = name
        item.isWeatherAlarm = TypeAlarm
        item.snooze = snooze
        item.activated = true
        item.weather = selectedWeather
//        item.amount = Double(amountText)!
        modelContext.insert(item)
        print("\(String(describing: item.weather?.condition))")
//        print(SelectEndLocation[0].location.latitude)
    
//        selectedWeather?.alarmS_weather?.append(item)
        item.locationFinish = SelectEndLocation
        SelectEndLocation?.alarmS_locationStart?.append(item)
        
    }
}






