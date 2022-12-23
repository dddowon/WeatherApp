//
//  NetworkController.swift
//  WeatherApp
//
//  Created by 박도원 on 2022/12/24.
//

import Foundation
import Alamofire

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
                    self.setWeatherLayout(data: data)
                    DispatchQueue.main.async {
                        self.createHoulryCollectionView()
                        self.configHourlyDataSource(hourly: data.hourly)
                        self.horizontalCollectionView.reloadData()
                    }
                    print(data)
                case .failure(let fail):
                    print(fail.localizedDescription)
                }
            }
    }
}
