//
//  Current.swift
//  WeatherApp
//
//  Created by 박도원 on 2022/12/09.
//

import Foundation

struct Current: Decodable, Hashable {
    let temp: Double
    let sunrise: Int
    let sunset: Int
    let weather: [Weather]
}
