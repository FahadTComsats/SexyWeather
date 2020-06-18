//
//  WeatherManager.swift
//  SexyWeather
//
//  Created by Fahad Tariq on 16/06/2020.
//  Copyright © 2020 Fahad Tariq. All rights reserved.
//
import Foundation
import CoreLocation

protocol WeatherManagerDelegate {
    func didUpdateWeather(_ weatherManager: WeatherManager,weather: WeatherModel)
    func didFailWithError(error: Error)
}


struct WeatherManager {
    
    var delegate: WeatherManagerDelegate?
    
    
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=5562c6c059392d354d5d9ba4375607e8&units=metric"
    
    func featherWeather(cityName: String){
        let urlString = "\(weatherURL)&q=\(cityName)"
        performRequest(with: urlString)
    }
    func featherWeather(Latitude: CLLocationDegrees, longitude: CLLocationDegrees){
        
        let urlString = "\(weatherURL)&lat=\(Latitude)&lon=\(longitude )"
        performRequest(with: urlString)
    }
    //Function to perform Networking
    func performRequest(with urlString: String){
        
        if let url = URL(string: urlString){
            
            let session = URLSession(configuration: .default)
            
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil{
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                
                if let safeData = data{
                    if let weather =  self.jsonParsing( safeData){
                        self.delegate?.didUpdateWeather(self, weather: weather )
                    }
                }
            }
            
            task.resume()
            
        }
        
        
    }
    
    func jsonParsing(_ weatherData: Data) ->  WeatherModel?{
        
        let decoder = JSONDecoder()
        
        do {
            
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            let id = decodedData.weather[0].id
            let temp = decodedData.main.temp
            let name = decodedData.name
            
            let weather = WeatherModel(conditionID: id, temperature: temp, cityName: name)
            return weather
            
        } catch  {
            
            delegate?.didFailWithError(error: error)
            return nil
        }
        
    }
    
    
    
}
