//
//  DailyCollectionViewCell.swift
//  WeatherApp
//
//  Created by 박도원 on 2022/12/24.
//

import UIKit

class DailyCollectionViewCell: UICollectionViewCell {
    static let identifier = "DailyCell"
    
    let dailyLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    let dailyWeatherImageView: UIImageView = {
        let image = UIImageView()
        return image
    }()
    
    let dailyMinTemp: UILabel = {
        let label = UILabel()
        return label
    }()
    
    let dailyMaxTemp: UILabel = {
        let label = UILabel()
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        createDailyLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func createDailyLayout() {
        [dailyLabel, dailyWeatherImageView, dailyMinTemp, dailyMaxTemp].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            self.contentView.addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            dailyLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            dailyLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            dailyLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            dailyWeatherImageView.widthAnchor.constraint(equalToConstant: 30),
            dailyWeatherImageView.heightAnchor.constraint(equalToConstant: 30),
            dailyWeatherImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 9),
            dailyWeatherImageView.leadingAnchor.constraint(equalTo: dailyLabel.trailingAnchor, constant: 45),

        ])
    }
    
    func configDailyCell(data: Daily) {
        let calender = Calendar.current
        let date = data.dt.dateConverter()
        let day = calender.component(.day, from: date)
        dailyLabel.text = String(day)
        dailyWeatherImageView.image = UIImage(named: data.weather[0].icon)
    }
}
