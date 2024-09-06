//
//  LocationModel.swift
//  VKStage
//
//  Created by Данила Бондарь on 05.09.2024.
//

import Foundation
import CoreLocation

final class LocationModel{
    static func getCurrentCity() async -> String?{
        guard let coordinates = getCoordinates(),
              let url = URL(string: "https://suggestions.dadata.ru/suggestions/api/4_1/rs/geolocate/address")
        else { return nil}
        do{
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.setValue("application/json", forHTTPHeaderField: "Accept")
            request.setValue("Token d104c32b43e7a00fd24634939ba636c765459399", forHTTPHeaderField: "Authorization")

            let jsonCooredinates: [String: Double] = ["lat": coordinates.latitude, "lon": coordinates.longitude, "radius_meters": 1000]
            request.httpBody = try JSONEncoder().encode(jsonCooredinates)
            
            let (data, _) = try await URLSession.shared.data(for: request)
            let cityResponce = try JSONDecoder().decode(CityResponse.self, from: data)
            guard !cityResponce.suggestions.isEmpty else { return nil }
            return cityResponce.suggestions[0].value
        }
        catch { print(error) }
        return nil
    }
    
    private static func getCoordinates() -> CLLocationCoordinate2D? {
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

fileprivate struct CityResponse: Codable{
    let suggestions: [CitySuggestion]
}
fileprivate struct CitySuggestion: Codable{
    let value: String
}
