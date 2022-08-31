//
//  WeatherManager.swift
//  Task3
//
//  Created by neoviso on 8/30/22.
//

import Foundation
import CoreLocation

class WeatherManager: NSObject {
    
    private let locationManager = CLLocationManager()
    
    private let API_KEY = "bba1ef98ff690e6ebecccaa4767ef105"
    private var completionHandler: ((Weather) -> ())?
    
    public override init() {
        super.init()
        locationManager.delegate = self
    }
    
    public func loadWeatherData(_ completionHandler: @escaping(Weather) -> ()) {
        self.completionHandler = completionHandler
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    public func makeDataRequest(coordinates: CLLocationCoordinate2D) {
        guard let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?lat=\(coordinates.latitude)&lon=\(coordinates.longitude)&appid=\(API_KEY)&units=metric") else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard error == nil, let data = data else{ return }
            if let response = try? JSONDecoder().decode(WeatherResponse.self, from: data) {
                self.completionHandler?(Weather(response: response))
            }

        }.resume()
    }
}

extension WeatherManager: CLLocationManagerDelegate {
    public func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else { return }
        makeDataRequest(coordinates: location.coordinate)
    }
}

struct WeatherResponse: Decodable {
    let name: String?
    let main: Main?
    let wind: Wind?
    let weather: [WeatherElement]?
}

struct Main: Decodable {
    let temp: Double?
    let feels_like: Double?
}

struct Wind: Decodable {
    let speed: Double?
}

struct WeatherElement: Decodable {
    let description: String?
    let iconName: String?
    
    enum CodingKeys: String, CodingKey {
        case description
        case iconName = "main"
    }
}
