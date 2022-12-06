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

    let locationManager = CLLocationManager()
    override func viewDidLoad() {
        super.viewDidLoad()
        updateLocation()
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
        
    }
}
