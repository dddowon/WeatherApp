//
//  Weather.swift
//  WeatherApp
//
//  Created by 박도원 on 2022/12/09.
//

import Foundation

struct Weather: Decodable, Hashable {
    let main: String
    let icon: String
}
