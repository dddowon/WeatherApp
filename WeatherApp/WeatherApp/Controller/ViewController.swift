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
