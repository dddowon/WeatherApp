//
//  Network.swift
//  WeatherApp
//
//  Created by 박도원 on 2022/12/06.
//

import Foundation

protocol Network {
    var lat: Double { get }
    var lon: Double { get }
    var appKey: String { get }
}
