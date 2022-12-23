//
//  Daily.swift
//  WeatherApp
//
//  Created by 박도원 on 2022/12/09.
//

import Foundation

struct Daily: Decodable, Hashable {
    let dt: Int
    let temp: Temp
    let weather: [Weather]
}
