//
//  ViewController.swift
//  WeatherApp
//
//  Created by 박도원 on 2022/12/01.
//

import UIKit
import CoreLocation
import Alamofire

class ViewController: UIViewController {
    
    @IBOutlet weak var areaLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var weatherLabel: UILabel!
    @IBOutlet weak var maxminTempLabel: UILabel!
    
    let locationManager = CLLocationManager()
    var weatherData: [WeatherData] = []
    var hourlyData: [Hourly] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateLocation()
        fetchWeatherData()
    }
}

// MARK: - 위도 경도 알아내는 함수
extension ViewController: CLLocationManagerDelegate {
    func updateLocation() {
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard locations.last != nil else {
            return
        }
        locationManager.stopUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
}

// MARK: - Alamofire
extension ViewController: Network {
    var lat: Double {
        guard let latitude = locationManager.location?.coordinate.latitude else {
            return 0
        }
        return latitude
    }
    
    var lon: Double {
        guard let longitude = locationManager.location?.coordinate.longitude else {
            return 0
        }
        return longitude
    }
    
    var appKey: String {
        let appKey = "8b1d6295034065c5ed173c4f482c2401"
        return appKey
    }

    func fetchWeatherData() {
        let url = "https://api.openweathermap.org/data/3.0/onecall?lat=\(lat)&lon=\(lon)&exclude=minutely&appid=\(appKey)"
        AF.request(url)
            .responseDecodable(of: WeatherData.self) { response in
                switch response.result {
                case .success(let data):
                    self.weatherData.append(data)
                    self.setWeatherLayout(data: data)
                    let calender = Calendar.current
                    let date = data.current.sunrise.dateConverter()
                    print(date)
                    let day = calender.component(.day, from: date)
                    print(day)
                case .failure(let fail):
                    print(fail.localizedDescription)
                }
            }
    }
}

// MARK: - layout
extension ViewController {
    func setWeatherLayout(data: WeatherData) {
        areaLabel.text = data.timezone
        tempLabel.text = String(data.current.temp.changeCelsius())
        weatherLabel.text = data.current.weather[0].main
        maxminTempLabel.text = "최소: \(data.daily[0].temp.min.changeCelsius()), 최대: \(data.daily[0].temp.max.changeCelsius())"
    }
}

// MARK: - collectionView
extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        weatherData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? HourlyCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.configCell(data: weatherData[indexPath.row].hourly, indexPath: indexPath)
        
        return cell
    }
    
    
}

// MARK: - date 변환
extension Int {
    func dateConverter() -> Date {
        return Date(timeIntervalSince1970: TimeInterval(self))
    }
}

extension Double {
    func changeCelsius() -> Int {
        return Int(UnitTemperature.celsius.converter.value(fromBaseUnitValue: self))
    }
}
