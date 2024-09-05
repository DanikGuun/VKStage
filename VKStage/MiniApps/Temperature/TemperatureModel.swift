//
//  TemperatureModel.swift
//  VKStage
//
//  Created by Данила Бондарь on 05.09.2024.
//

import Foundation
import CoreLocation

final class TemperatureModel{
    static func getTemperature() async -> Double?{
        guard let coordinates = getCoordinates() else { return nil }
        guard let url = URL(string: "https://api.open-meteo.com/v1/forecast?latitude=\(coordinates.latitude)&longitude=\(coordinates.longitude)&minutely_15=temperature_2m&past_days=1&forecast_days=1") else { return nil }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        do{
            let (data, _) = try await URLSession.shared.data(for: request)
            let temperatures = try JSONDecoder().decode(WeatherResponse.self, from: data)
            return temperatures.minutely_15.temperature_2m[0]
        }
        catch { print(error) }
        return nil
    }
    
    static func getCoordinates() -> CLLocationCoordinate2D?{
        let manager = CLLocationManager()
        manager.requestWhenInUseAuthorization()
        if manager.authorizationStatus == .authorizedWhenInUse || manager.authorizationStatus == .authorizedAlways{
            manager.startUpdatingLocation()
            let coordinates = manager.location?.coordinate
            manager.stopUpdatingLocation()
            return coordinates
        }
        return nil
    }
}

fileprivate struct WeatherResponse: Codable{
    let minutely_15: AllWeatherData
}
fileprivate struct AllWeatherData: Codable{
    let temperature_2m: [Double]
}
