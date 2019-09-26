//
//  Element.swift
//  collection-views
//
//  Created by David Rifkin on 9/26/19.
//  Copyright © 2019 David Rifkin. All rights reserved.
//

import Foundation

struct Element: Codable {
    let name: String
    let symbol: String
    let number: Int
    let atomicMass: Double
    let meltingPoint: Double?
    let boilingPoint: Double?
    let discoveredBy: String?
    
    var symbolAndMass: String {
        return "\(symbol)(\(number))  \(atomicMass)"
    }
    
    enum CodingKeys: String, CodingKey {
        case atomicMass = "atomic_mass"
        case meltingPoint = "melt"
        case boilingPoint = "boil"
        case discoveredBy = "discovered_by"
        case name,symbol,number
    }
    
    static func decodeElementsFromData(from jsonData: Data) throws -> [Element] {
        let response = try JSONDecoder().decode([Element].self, from: jsonData)
        return response
    }
}
