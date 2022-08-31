//
//  ViewController.swift
//  Task3
//
//  Created by neoviso on 8/30/22.
//

import UIKit
import Foundation

class ViewController: UIViewController {
    @IBOutlet weak var nameLocationLabel: UILabel!
    @IBOutlet weak var weatherTemperatureLabel: UILabel!
    @IBOutlet weak var weatherStateLabel: UILabel!
    @IBOutlet weak var windSpeedLabel: UILabel!
    
    
    private var weatherViewModel: WeatherViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
    
    private func updateUI() {
        weatherViewModel = WeatherViewModel()
        weatherViewModel?.bind = { [weak self] in
            self?.updateDataSource()
        }
    }

    private func updateDataSource() {
        guard let weather = weatherViewModel?.getCurrentWeather() else { return }
        DispatchQueue.main.async {
            self.nameLocationLabel.text = "\(weather.city)"
            self.weatherTemperatureLabel.text = "\(weather.temperature)"
            self.weatherStateLabel.text = "\(weather.iconName)"
            self.windSpeedLabel.text = "\(weather.windSpeed)"
        }
    }
}

