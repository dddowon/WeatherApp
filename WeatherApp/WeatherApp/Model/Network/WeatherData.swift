//
//  Weather.swift
//  WeatherApp
//
//  Created by 박도원 on 2022/12/06.
//

import Foundation

struct WeatherData: Decodable {
    let timezone: String
    let current: Current
    let hourly: [Hourly]
    let daily: [Daily]
}
