//
//  HourlyCollectionViewCell.swift
//  WeatherApp
//
//  Created by 박도원 on 2022/12/20.
//

import UIKit

class HourlyCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var hourlyLabel: UILabel!
    @IBOutlet weak var weatherImageView: UIImageView!
    @IBOutlet weak var hourlyTempLabel: UILabel!
    
    func configCell(data: [Hourly], indexPath: IndexPath) {
        hourlyLabel.text = String(data[indexPath.row].dt)
        hourlyTempLabel.text = String(data[indexPath.row].temp)
    }
}
