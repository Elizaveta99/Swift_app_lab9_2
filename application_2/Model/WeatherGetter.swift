//
//  WeatherGetter.swift
//  application_2
//
//  Created by Lizaveta Rudzko on 3/12/1398 AP.
//  Copyright © 1398 Lizaveta Rudzko. All rights reserved.
//

import Foundation

class WeatherGetter
{
    
    static let apiKey = "b6965a28-eff9-4b85-a091-04a6305a1940"
    
    static func getTempurature(latitude: Double, longitude: Double, completition: @escaping (_ temperature:Double) -> Void)
    {
        
        var request = URLRequest(url: URL(string: "https://api.weather.yandex.ru/v1/forecast?lat=" +
            String(latitude) + "&lon=" + String(longitude) + "&lang=ru_Ru")!)
        request.setValue(apiKey, forHTTPHeaderField: "X-Yandex-API-Key")
        request.httpMethod = "GET"
        
        var tempreture: Double = 0
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            do {
                let json = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as! [String:Any]
                let fact = json["fact"] as! [String: Any]
                tempreture = fact["temp"] as! Double
                
                print("Temperature: \(tempreture)")
                DispatchQueue.main.async() {completition(tempreture)}
                
            } catch {
                print(error.localizedDescription)
            }
        }
        task.resume()
    }
}
