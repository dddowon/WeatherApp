//
//  HourlyCollectionViewCell.swift
//  WeatherApp
//
//  Created by 박도원 on 2022/12/20.
//

import UIKit

class HourlyCollectionViewCell: UICollectionViewCell {
    static let identifier = "HourlyCell"
    
    private let cellStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .equalSpacing
        stackView.spacing = 10
        return stackView
    }()
    
    private let hourLabel: UILabel = {
        let label = UILabel()
        label.alpha = 1
        return label
    }()
    
    private let hourlyWeatherImageView: UIImageView = {
        let image = UIImageView()
        return image
    }()
    
    private let hourTempLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        createHourlyCellLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func createHourlyCellLayout() {
        [hourLabel, hourlyWeatherImageView ,hourTempLabel].forEach {
            cellStackView.addArrangedSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        contentView.addSubview(cellStackView)
        
        NSLayoutConstraint.activate([
            cellStackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            cellStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            cellStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            cellStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            hourlyWeatherImageView.centerXAnchor.constraint(equalTo: cellStackView.centerXAnchor),
            hourlyWeatherImageView.centerYAnchor.constraint(equalTo: cellStackView.centerYAnchor),
            hourlyWeatherImageView.widthAnchor.constraint(equalToConstant: 30),
            hourlyWeatherImageView.heightAnchor.constraint(equalToConstant: 30),
        ])
    }
    
    func configHourlyCell(data: Hourly) {
        let calender = Calendar.current
        let date = data.dt.dateConverter()
        let hour = calender.component(.hour, from: date)
        hourLabel.text = String(hour) + "시"
        hourlyWeatherImageView.image = UIImage(named: data.weather[0].icon)
        hourTempLabel.text = String(data.temp.changeCelsius()) + "°"
    }
    
    func configNowHourlyCell(data: Hourly) {
        hourLabel.text = "지금"
        hourlyWeatherImageView.image = UIImage(named: data.weather[0].icon)
        hourTempLabel.text = String(data.temp.changeCelsius()) + "°"
    }
}
