//
//  ViewController.swift
//  WeatherApp
//
//  Created by 박도원 on 2022/12/01.
//

import UIKit
import CoreLocation

enum Section {
    case main
}

class ViewController: UIViewController {
    let locationManager = CLLocationManager()
    let weatherData: [WeatherData] = []
    var hourlyCollectionView: UICollectionView!
    var dailyCollectionView: UICollectionView!
    var hourlyDataSource: UICollectionViewDiffableDataSource<Section, Hourly>!
    var dailyDataSource: UICollectionViewDiffableDataSource<Section, Daily>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateLocation()
        addSubView()
        setUiConstraints()
        fetchWeatherData()
    }
    
    let areaLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 30)
        return label
    }()
    
    let tempLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 90)
        return label
    }()
    
    let weatherLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 20)
        return label
    }()
    
    let maxMinLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 20)
        return label
    }()
    
    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.showsVerticalScrollIndicator = false
        return scrollView
    }()
    
    let baseView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .equalSpacing
        stackView.spacing = 3
        return stackView
    }()
    
    let hourlyWeatherView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let baseStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .equalSpacing
        stackView.spacing = 10
        return stackView
    }()
    
    let dailyWeatherView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    func addSubView() {
        self.view.addSubview(scrollView)
        scrollView.addSubview(baseView)
        baseView.addSubview(mainStackView)
        [areaLabel, tempLabel, weatherLabel, maxMinLabel].forEach {
            mainStackView.addArrangedSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        baseView.addSubview(hourlyWeatherView)
        baseView.addSubview(baseStackView)
        baseStackView.addSubview(dailyWeatherView)
    }
    
    func setUiConstraints() {
        let safeArea = self.view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            
            baseView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
            baseView.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor),
            baseView.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor),
            baseView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor),
            baseView.widthAnchor.constraint(equalTo: scrollView.frameLayoutGuide.widthAnchor),
            baseView.heightAnchor.constraint(equalToConstant: 1200),
            
            mainStackView.topAnchor.constraint(equalTo: baseView.topAnchor, constant: 60),
            mainStackView.leadingAnchor.constraint(equalTo: baseView.leadingAnchor),
            mainStackView.trailingAnchor.constraint(equalTo: baseView.trailingAnchor),
            mainStackView.bottomAnchor.constraint(equalTo: baseView.topAnchor, constant: 260),

            hourlyWeatherView.topAnchor.constraint(equalTo: mainStackView.bottomAnchor, constant: 60),
            hourlyWeatherView.leadingAnchor.constraint(equalTo: baseView.leadingAnchor),
            hourlyWeatherView.trailingAnchor.constraint(equalTo: baseView.trailingAnchor),
            hourlyWeatherView.heightAnchor.constraint(equalToConstant: 100),
            
            baseStackView.topAnchor.constraint(equalTo: hourlyWeatherView.bottomAnchor, constant: 10),
            baseStackView.leadingAnchor.constraint(equalTo: baseView.leadingAnchor),
            baseStackView.trailingAnchor.constraint(equalTo: baseView.trailingAnchor),
            baseStackView.bottomAnchor.constraint(equalTo: baseView.bottomAnchor),
            
            dailyWeatherView.topAnchor.constraint(equalTo: baseStackView.topAnchor),
            dailyWeatherView.leadingAnchor.constraint(equalTo: baseStackView.leadingAnchor),
            dailyWeatherView.trailingAnchor.constraint(equalTo: baseStackView.trailingAnchor),
            dailyWeatherView.heightAnchor.constraint(equalToConstant: 300)
        ])
    }
}

// MARK: - 위도 경도 알아내는 함수
extension ViewController: CLLocationManagerDelegate {
    func updateLocation() {
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard locations.last != nil else {
            return
        }
        locationManager.stopUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
}

// MARK: - MainLayout
extension ViewController {
    func setWeatherLayout(data: WeatherData) {
        let area = data.timezone.split(separator: "/")
        areaLabel.text = String(area[1])
        tempLabel.text = String(data.current.temp.changeCelsius()) + "°"
        weatherLabel.text = data.current.weather[0].main
        maxMinLabel.text = "최고: \(data.daily[0].temp.max.changeCelsius())° 최저: \(data.daily[0].temp.min.changeCelsius())°"
    }
}

// MARK: - date 변환
extension Int {
    func dateConverter() -> Date {
        return Date(timeIntervalSince1970: TimeInterval(self))
    }
}

extension Double {
    func changeCelsius() -> Int {
        return Int(UnitTemperature.celsius.converter.value(fromBaseUnitValue: self))
    }
}
