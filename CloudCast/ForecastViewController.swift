//
//  ForecastViewController.swift
//  CloudCast
//
//  Created by Michael on 23/06/2024.
//

import UIKit

class ForecastViewController: UIViewController {
    
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var forecastImageView: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var tempratureLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var windSpeedLabel: UILabel!
    
    
    var forecasts = [WeatherForecast]()
    var selectedForecastIndex = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addGradient()
        forecasts = createMockData()
        configure(with: forecasts[selectedForecastIndex])
        // Do any additional setup after loading the view.
    }
    
    private func configure(with forecast: WeatherForecast) {
        forecastImageView.image = forecast.weatherCode.image
        descriptionLabel.text = forecast.weatherCode.description
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = "MMMM d, yyyy"
        dateLabel.text = dateFormater.string(from: forecast.date)
        tempratureLabel.text = "\(forecast.temperature)°F"
        windSpeedLabel.text = "\(forecast.precipitation) mph"
        humidityLabel.text = "\(forecast.humidity)%"
    }
    
    private func addGradient() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = view.bounds
        gradientLayer.colors = [UIColor(red: 0.54, green: 0.88, blue: 0.99, alpha: 1.00).cgColor,
                                    UIColor(red: 0.51, green: 0.81, blue: 0.97, alpha: 1.00).cgColor]
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 1)
        view.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    private func createMockData() -> [WeatherForecast] {
        let today = Date()
        var dateComponent = DateComponents()
        dateComponent.day = 1
        let tomorrow = Calendar.current.date(byAdding: dateComponent, to: today)!
        let dayAfterTomorrow = Calendar.current.date(byAdding: dateComponent, to: tomorrow)!
        var weatherForcastArr: [WeatherForecast] = []
        weatherForcastArr.append(WeatherForecast(windSpeed: 3.3,
                                                 weatherCode: .violentRainShowers,
                                                 precipitation: 33.3,
                                                 temperature: 59.5,
                                                 date: today,
                                                 humidity: 10))
        weatherForcastArr.append(WeatherForecast(windSpeed: 3.7,
                                                 weatherCode: .fog,
                                                 precipitation: 13.3,
                                                 temperature: 65.5,
                                                 date: tomorrow,
                                                 humidity: 20))
        weatherForcastArr.append(WeatherForecast(windSpeed: 2.8,
                                                 weatherCode: .partlyCloudy,
                                                 precipitation: 23.3,
                                                 temperature: 49.5,
                                                 date: dayAfterTomorrow,
                                                 humidity: 30))
        return weatherForcastArr
    }
    
    @IBAction func didTabForwardButton(_ sender: UIButton) {
        selectedForecastIndex += 1
        if selectedForecastIndex > forecasts.count - 1 {
            selectedForecastIndex = 0
        }
        configure(with: forecasts[selectedForecastIndex])
    }
    
    @IBAction func didTabPreviousButton(_ sender: UIButton) {
        selectedForecastIndex -= 1
        if selectedForecastIndex < 0 {
            selectedForecastIndex = forecasts.count - 1
        }
        configure(with: forecasts[selectedForecastIndex])
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
