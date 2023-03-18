//
//  JSON.swift
//  Navigation
//
//  Created by Игорь Скворцов on 16.03.2023.
//

import Foundation

struct JSONFirst: Codable {
    let userId, id : Int
    let title : String
    let completed : Bool
}

struct JSONSecond: Decodable {
    let name, rotationPeriod, orbitalPeriod, diameter: String
    let climate, gravity, terrain, surfaceWater: String
    let population: String
    let residents, films: [String]
    let created, edited: String
    let url: String

    enum CodingKeys: String, CodingKey {
        case name
        case rotationPeriod = "rotation_period"
        case orbitalPeriod = "orbital_period"
        case diameter, climate, gravity, terrain
        case surfaceWater = "surface_water"
        case population, residents, films, created, edited, url
    }
}
