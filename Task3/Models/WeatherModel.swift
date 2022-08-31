//
//  WeatherModel.swift
//  Task3
//
//  Created by neoviso on 8/30/22.
//

import Foundation

private let defaultIcon = "❓"
private let iconMap = [
  "Drizzle" : "🌧",
  "Thunderstorm" : "⛈",
  "Rain": "🌧",
  "Snow": "❄️",
  "Clear": "☀️",
  "Clouds" : "☁️",
]

public struct Weather {
    let city: String
    let temperature: String
    let feelsLike: String
    let windSpeed: String
    let description: String
    let iconName: String
    
    init(response: WeatherResponse) {
        city = response.name ?? "none"
        temperature = "\(Int(response.main?.temp ?? 0.0))°C"
        feelsLike = "\(Int(response.main?.feels_like ?? 0.0))°C"
        windSpeed = "\(Double(response.wind?.speed ?? 0.0))m/s"
        description = response.weather?.first?.description?.capitalized ?? ""
        iconName = iconMap[response.weather?.first?.iconName ?? defaultIcon] ?? ""
    }
}
