//
//  DefaultsJSON.swift
//  Location App
//
//  Created by yatziri on 19/03/24.
//

import Foundation
struct DefaultsJSON {

    static func decode<T: Codable>(from fileName: String, type: T.Type) -> T? {

        do {
            guard let url = Bundle.main.url(forResource: fileName, withExtension: "json"),
                  let data = try? Data(contentsOf: url) else {
                return nil
            }

            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601 // Configurar la estrategia de decodificación de fecha

            let result = try decoder.decode(T.self, from: data)

            return result
        } catch {
            print(error)
            return nil
        }

    }
}
