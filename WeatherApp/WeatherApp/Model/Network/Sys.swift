//
//  Sys.swift
//  WeatherApp
//
//  Created by 박도원 on 2022/12/06.
//

import Foundation

struct Sys: Decodable {
    let type, id: Int
    let country: String
    let sunrise, sunset: Int
}
