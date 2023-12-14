//
//  WeatherData.swift
//  JeonHyowon-assignment
//
//  Created by Hyowon Jeon on 11/17/23.
//

import Foundation

struct WeatherData: Codable {
    let name: String
    let weather: [Weather]
    let main: Main
}

struct Weather: Codable {
    let description: String
}

struct Main: Codable {
    let currentTemperature: Float
    let minimumTemperature: Float
    let maximumTemperature: Float
    
    enum CodingKeys: String, CodingKey {
        case currentTemperature = "temp"
        case minimumTemperature = "temp_min"
        case maximumTemperature = "temp_max"
    }
}
