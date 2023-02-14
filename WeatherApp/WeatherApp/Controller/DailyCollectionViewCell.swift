//
//  DailyCollectionViewCell.swift
//  WeatherApp
//
//  Created by 박도원 on 2022/12/24.
//

import UIKit

class DailyCollectionViewCell: UICollectionViewCell {
    static let identifier = "DailyCell"
    
    private let dailyLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let dailyWeatherImageView: UIImageView = {
        let image = UIImageView()
        return image
    }()
    
    private let dailyMinTemp: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let dailyMaxTemp: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let dailyView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let dailyMinView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let dailyMaxView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        createDailyView()
        createDailyLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func createDailyView() {
        dailyView.addSubview(dailyLabel)
        dailyMinView.addSubview(dailyMinTemp)
        dailyMaxView.addSubview(dailyMaxTemp)
        
        NSLayoutConstraint.activate([
            dailyLabel.centerXAnchor.constraint(equalTo: dailyView.centerXAnchor),
            dailyLabel.centerYAnchor.constraint(equalTo: dailyView.centerYAnchor),
            
            dailyMinTemp.centerXAnchor.constraint(equalTo: dailyMinView.centerXAnchor),
            dailyMinTemp.centerYAnchor.constraint(equalTo: dailyMinView.centerYAnchor),
            
            dailyMaxTemp.centerXAnchor.constraint(equalTo: dailyMaxView.centerXAnchor),
            dailyMaxTemp.centerYAnchor.constraint(equalTo: dailyMaxView.centerYAnchor),
        ])
    }
    
    private func createDailyLayout() {
        [dailyView, dailyWeatherImageView, dailyMinView, dailyMaxView].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            self.contentView.addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            dailyView.topAnchor.constraint(equalTo: contentView.topAnchor),
            dailyView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 25),
            dailyView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            dailyWeatherImageView.widthAnchor.constraint(equalToConstant: 30),
            dailyWeatherImageView.heightAnchor.constraint(equalToConstant: 30),
            dailyWeatherImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 9),
            dailyWeatherImageView.leadingAnchor.constraint(equalTo: dailyView.trailingAnchor, constant: 90),
            
            dailyMinView.topAnchor.constraint(equalTo: contentView.topAnchor),
            dailyMinView.leadingAnchor.constraint(equalTo: dailyWeatherImageView.trailingAnchor, constant: 90),
            dailyMinView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            dailyMaxView.topAnchor.constraint(equalTo: contentView.topAnchor),
            dailyMaxView.leadingAnchor.constraint(equalTo: dailyMinView.trailingAnchor, constant: 90),
            dailyMaxView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),

        ])
    }
    
    func configDailyCell(data: Daily) {
        let calender = Calendar.current
        let date = data.dt.dateConverter()
        let day = calender.component(.day, from: date)
        dailyLabel.text = String(day) + "일"
        dailyWeatherImageView.image = UIImage(named: data.weather[0].icon)
        dailyMinTemp.text = String(data.temp.min.changeCelsius()) + "°"
        dailyMaxTemp.text = String(data.temp.max.changeCelsius()) + "°"
    }
}
