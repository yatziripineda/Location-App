//
//  SearchPointView.swift
//  Location App
//
//  Created by yatziri on 22/03/24.
//
import SwiftUI
import MapKit

struct SearchPointView: View {
    @State private var locationService = LocationService(completer: .init())
    @State private var search: String = ""
    @State private var showlist: Bool = false
    // 1
    @Binding var searchResults: [SearchResult]
    @Binding var isPresented: Bool 
    @Binding var Name: String

    var body: some View {
        VStack {
            HStack {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.gray)
                TextField("Where do you want to go?", text: $search)
                    .autocorrectionDisabled()
                // 2
                    .onSubmit {
                        Task {
                            searchResults = (try? await locationService.search(with: search)) ?? []
                        }
                    }
                
            }
            .modifier(TextFieldGrayBackgroundColor())
            if showlist || (search != ""){
                List {
                    ForEach(locationService.completions) { completion in
                        // 3
                        Button(action: { didTapOnCompletion(completion) }) {
                            VStack(alignment: .leading, spacing: 4) {
                                Text(completion.title)
                                    .font(.headline)
                                    .fontDesign(.rounded)
                                Text(completion.subTitle)
                                // What can we show?
                                //                            if let url = completion.url {
                                //                                Link(url.absoluteString, destination: url)
                                //                                    .lineLimit(1)
                                //                            }
                            }
                        }
                        .listRowBackground(Color.clear)
                    }
                }
                .listStyle(.plain)
                .scrollContentBackground(.hidden)
            }
        }
        .onChange(of: search) {
            locationService.update(queryFragment: search)
        }
//        .padding()
        .interactiveDismissDisabled()
        .presentationDetents([.height(200), .large])
        .presentationBackground(.regularMaterial)
        .presentationBackgroundInteraction(.enabled(upThrough: .large))
    }

    // 4
    private func didTapOnCompletion(_ completion: SearchCompletions) {
        Task {
            if let singleLocation = try? await locationService.search(with: "\(completion.title) \(completion.subTitle)").first {
                searchResults = [singleLocation]
            }
        }
        isPresented.toggle()
        showlist.toggle()
        Name = completion.title
//        if search != ""{
//            isPresented.toggle()
//        }
        
        
    }
}
struct TextFieldGrayBackgroundColor: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding(12)
            .background(.gray.opacity(0.1))
            .cornerRadius(8)
            .foregroundColor(.primary)
    }
}
//
//#Preview {
//    SheetView()
//}
//
//#Preview {
//    SearchPointView(searchResults: searchResults, isPresented: true)
//}
