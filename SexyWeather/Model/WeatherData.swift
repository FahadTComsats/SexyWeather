//
//  WeatherData.swift
//  SexyWeather
//
//  Created by Fahad Tariq on 18/06/2020.
//  Copyright © 2020 Fahad Tariq. All rights reserved.
//

import Foundation

struct WeatherData: Decodable {
    
    let name: String
    let main: Main
    let weather: [Weather]
    
}

struct Main: Decodable {
    let temp: Double
}
 
struct Weather: Decodable {
    let description: String
    
}
