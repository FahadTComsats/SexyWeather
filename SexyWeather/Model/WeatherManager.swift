//
//  WeatherManager.swift
//  SexyWeather
//
//  Created by Fahad Tariq on 16/06/2020.
//  Copyright © 2020 Fahad Tariq. All rights reserved.
//
import Foundation

struct WeatherManager {
    
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=5562c6c059392d354d5d9ba4375607e8&units=metric"
    
    func featherWeather(cityName: String){
        let urlString = "\(weatherURL)&q=\(cityName)"
        performRequest(urlString: urlString)
    }
    //Function to perform Networking
    func performRequest(urlString: String){
        
        if let url = URL(string: urlString){
            
            let session = URLSession(configuration: .default)
            
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil{
                    print(error!)
                    return
                }
                
                if let safeData = data{
                    self.jsonParsing(weatherData: safeData)
                }
            }
            
            task.resume()
            
        }
        
        
    }
    
    func jsonParsing(weatherData: Data){
        
        let decoder = JSONDecoder()
        
        do {
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            print(decodedData.weather[0].description)
        } catch  {
            print(error)
        }
        
    }
    
}
