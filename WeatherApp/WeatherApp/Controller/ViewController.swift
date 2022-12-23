//
//  ViewController.swift
//  WeatherApp
//
//  Created by 박도원 on 2022/12/01.
//

import UIKit
import CoreLocation
import Alamofire

enum Section {
    case main
}

class ViewController: UIViewController {
    let locationManager = CLLocationManager()
    let weatherData: [WeatherData] = []
    var horizontalCollectionView: UICollectionView!
    var dataSource: UICollectionViewDiffableDataSource<Section, Hourly>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubView()
        setUiConstraints()
        updateLocation()
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
            baseStackView.bottomAnchor.constraint(equalTo: baseView.bottomAnchor)
        ])
    }
    
    func createLayout() -> UICollectionViewCompositionalLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(50), heightDimension: .absolute(80))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 1)

        
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = CGFloat(10)
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20)
        section.orthogonalScrollingBehavior = .continuous
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }
    
    func createCollectionView() {
        horizontalCollectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
        
        hourlyWeatherView.addSubview(horizontalCollectionView)
        horizontalCollectionView.translatesAutoresizingMaskIntoConstraints = false
        horizontalCollectionView.alpha = 1
        horizontalCollectionView.layer.cornerRadius = 10
        
        NSLayoutConstraint.activate([
            horizontalCollectionView.topAnchor.constraint(equalTo: hourlyWeatherView.topAnchor),
            horizontalCollectionView.leadingAnchor.constraint(equalTo: hourlyWeatherView.leadingAnchor, constant: 10),
            horizontalCollectionView.trailingAnchor.constraint(equalTo: hourlyWeatherView.trailingAnchor, constant: -10),
            horizontalCollectionView.bottomAnchor.constraint(equalTo: hourlyWeatherView.bottomAnchor),
        ])
    }
    
    func configDataSource(hourly: [Hourly]) {
        let cellRegistration = UICollectionView.CellRegistration<HourlyCollectionViewCell, Hourly>  { cell, indexPath, data in
            if data.dt == hourly[0].dt {
                cell.configCell2(data: data)
            } else {
                cell.configCell(data: data)
            }
        }
        
        dataSource = UICollectionViewDiffableDataSource<Section, Hourly>(collectionView: horizontalCollectionView, cellProvider: { (collectionView, indexPath, itemIdentifier) -> UICollectionViewCell? in
            return collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: itemIdentifier)
        })
        
        var snapShot = NSDiffableDataSourceSnapshot<Section, Hourly>()
        snapShot.appendSections([.main])
        snapShot.appendItems(hourly)
        dataSource.apply(snapShot)
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

// MARK: - Alamofire
extension ViewController: Network {
    var lat: Double {
        guard let latitude = locationManager.location?.coordinate.latitude else {
            return 0
        }
        return latitude
    }
    
    var lon: Double {
        guard let longitude = locationManager.location?.coordinate.longitude else {
            return 0
        }
        return longitude
    }
    
    var appKey: String {
        let appKey = "8b1d6295034065c5ed173c4f482c2401"
        return appKey
    }

    func fetchWeatherData() {
        let url = "https://api.openweathermap.org/data/3.0/onecall?lat=\(lat)&lon=\(lon)&exclude=minutely&appid=\(appKey)"
        AF.request(url)
            .responseDecodable(of: WeatherData.self) { response in
                switch response.result {
                case .success(let data):
                    self.setWeatherLayout(data: data)
                    DispatchQueue.main.async {
                        self.createCollectionView()
                        self.configDataSource(hourly: data.hourly)
                        self.horizontalCollectionView.reloadData()
                    }
                    print(data)
                case .failure(let fail):
                    print(fail.localizedDescription)
                }
            }
    }
}

// MARK: - layout
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
