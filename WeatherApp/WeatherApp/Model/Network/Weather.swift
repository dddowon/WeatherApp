//
//  Weather.swift
//  WeatherApp
//
//  Created by 박도원 on 2022/12/06.
//

import Foundation

struct Weather: Codable {
    let id: Int
    let main, weatherDescription, icon: String

    enum CodingKeys: String, CodingKey {
        case id, main
        case weatherDescription = "description"
        case icon
    }
}
