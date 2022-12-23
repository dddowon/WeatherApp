//
//  HourlyCollectionViewCell.swift
//  WeatherApp
//
//  Created by 박도원 on 2022/12/20.
//

import UIKit

class HourlyCollectionViewCell: UICollectionViewCell {
    static let identifier = "HourlyCell"
    
    private let collectionStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .equalSpacing
        return stackView
    }()
    
    let hourLabel: UILabel = {
        let label = UILabel()
        label.alpha = 1
        return label
    }()
    
    let weatherImageView: UIImageView = {
        let image = UIImageView()
        return image
    }()
    
    let hourTempLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        createLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func createLayout() {
        [hourLabel, weatherImageView ,hourTempLabel].forEach {
            collectionStackView.addArrangedSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        contentView.addSubview(collectionStackView)
        
        NSLayoutConstraint.activate([
            collectionStackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            collectionStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            collectionStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            collectionStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            weatherImageView.centerXAnchor.constraint(equalTo: collectionStackView.centerXAnchor),
            weatherImageView.centerYAnchor.constraint(equalTo: collectionStackView.centerYAnchor),
            weatherImageView.widthAnchor.constraint(equalToConstant: 30),
            weatherImageView.heightAnchor.constraint(equalToConstant: 30),
        ])
    }
    
    func configCell(data: Hourly) {
        let calender = Calendar.current
        let date = data.dt.dateConverter()
        let hour = calender.component(.hour, from: date)
        hourLabel.text = String(hour) + "시"
        weatherImageView.image = UIImage(named: data.weather[0].icon)
        hourTempLabel.text = String(data.temp.changeCelsius()) + "°"
    }
    
    func configCell2(data: Hourly) {
        hourLabel.text = "지금"
        weatherImageView.image = UIImage(named: data.weather[0].icon)
        hourTempLabel.text = String(data.temp.changeCelsius()) + "°"
    }
}
