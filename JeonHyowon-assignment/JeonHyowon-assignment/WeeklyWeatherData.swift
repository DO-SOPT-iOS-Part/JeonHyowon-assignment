//
//  WeeklyWeatherData.swift
//  JeonHyowon-assignment
//
//  Created by Hyowon Jeon on 11/6/23.
//

import Foundation

struct WeeklyWeatherData {
    let day: String
    let weatherImage: String
    let minimumTemperature: String
    let temperatureImage: String
    let maximumTemperature: String
    
    init(day: String, weatherImage: String, minimumTemperature: String, temperatureImage: String, maximumTemperature: String) {
        self.day = day
        self.weatherImage = weatherImage
        self.minimumTemperature = minimumTemperature
        self.temperatureImage = temperatureImage
        self.maximumTemperature = maximumTemperature
    }
}
