//
//  TodayWeatherData.swift
//  JeonHyowon-assignment
//
//  Created by Hyowon Jeon on 11/6/23.
//

import Foundation

struct TodayWeatherData {
    let hour: String
    let image: String
    let temperature: String
    
    init(hour: String, image: String, temperature: String) {
        self.hour = hour
        self.image = image
        self.temperature = temperature
    }
}
