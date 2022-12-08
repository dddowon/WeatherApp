//
//  Hourly.swift
//  WeatherApp
//
//  Created by 박도원 on 2022/12/09.
//

import Foundation

struct Hourly: Decodable {
    let dt: Int
    let temp: Double
    let weather: [Weather]
}
