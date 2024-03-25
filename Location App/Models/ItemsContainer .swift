//
//  ItemsContainer .swift
//  Location App
//
//  Created by yatziri on 19/03/24.
//

import Foundation

import Foundation
import SwiftData

actor ItemsContainer {
    
    @MainActor
    static func create(shouldCreateDefaults: inout Bool) -> ModelContainer {
        let schema = Schema([Alarms.self])
        let configuration = ModelConfiguration()
        let container = try! ModelContainer(for: schema, configurations: [configuration])
        
        if shouldCreateDefaults {
            shouldCreateDefaults = false
            
//            let acounts = DefaultsJSON.decode(from: "DefoultAcount",
//                                                 type: [Acount].self)
//            acounts?.forEach {
//                print(".")
//                container.mainContext.insert($0)
//            }
            
            
            
            let weathers = DefaultsJSON.decode(from: "Default_Categories",
                                                 type: [Weather].self)
            weathers?.forEach {
                
                print("-")
                container.mainContext.insert($0)
            }
            
            
            
//        
//            let alarms = DefaultsJSON.decode(from: "Default_Alarms",
//                                            type: [Alarms].self)
//            
//         
//            alarms?.forEach { alarms in
//                print("=")
//                container.mainContext.insert(alarms)
//                alarms?.items?.append(alarms)
//            }
//            print("Hola")
//            print(items)
//            print(acounts)
            
//            print(weathers)

        }

        return container
    }
    
}
