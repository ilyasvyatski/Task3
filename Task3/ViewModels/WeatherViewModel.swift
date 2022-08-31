//
//  WeatherViewModel.swift
//  Task3
//
//  Created by neoviso on 8/30/22.
//

import Foundation

public class WeatherViewModel: NSObject {
    
    private var weatherManager: WeatherManager?
    private var weather: Weather? {
      didSet {
        self.bind()
      }
    }
    
    public var bind: (() -> ()) = {}

    override init() {
        super.init()
        self.weatherManager = WeatherManager()
        self.callGetCurrentWeather()
    }
    
    private func callGetCurrentWeather() {
        weatherManager?.loadWeatherData { weather in
            self.weather = weather
        }
    }
    
    public func getCurrentWeather() -> Weather? {
        return weather
    }
}
