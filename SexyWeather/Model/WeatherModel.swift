//
//  WeatherModel.swift
//  SexyWeather
//
//  Created by Fahad Tariq on 18/06/2020.
//  Copyright © 2020 Fahad Tariq. All rights reserved.
//

import Foundation


struct WeatherModel {
    
    let conditionID: Int
    let temperature: Double
    let cityName: String
    
    //computed properties
    
    var temperatureString: String{
        
        return String(format: "%.1f", temperature)
    }
    
    var conditionName: String{
        
        switch conditionID {
        case 200...232:
            return "cloud.bolt"
        case 300...321:
            return "cloud.drizzle"
        case 500...531:
            return "cloud.rain"
        case 600...622:
            return "cloud.snow"
        case 701...781:
            return "cloud.fog"
        case 800:
            return "sun.max"
        case 801...804:
            return "cloud.bolt"
        default:
            return "cloud"
    }
    

    }
}
