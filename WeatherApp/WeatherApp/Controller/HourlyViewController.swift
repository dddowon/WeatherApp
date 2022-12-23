//
//  HourlyViewController.swift
//  WeatherApp
//
//  Created by 박도원 on 2022/12/24.
//

import Foundation
import UIKit

extension ViewController {
    func createHourlyLayout() -> UICollectionViewCompositionalLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(50), heightDimension: .absolute(80))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, repeatingSubitem: item, count: 1)

        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = CGFloat(15)
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10)
        section.orthogonalScrollingBehavior = .continuous
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }
    
    func createHoulryCollectionView() {
        hourlyCollectionView = UICollectionView(frame: .zero, collectionViewLayout: createHourlyLayout())
        
        hourlyWeatherView.addSubview(hourlyCollectionView)
        hourlyCollectionView.translatesAutoresizingMaskIntoConstraints = false
        hourlyCollectionView.alpha = 1
        hourlyCollectionView.layer.cornerRadius = 10
        
        NSLayoutConstraint.activate([
            hourlyCollectionView.topAnchor.constraint(equalTo: hourlyWeatherView.topAnchor),
            hourlyCollectionView.leadingAnchor.constraint(equalTo: hourlyWeatherView.leadingAnchor, constant: 10),
            hourlyCollectionView.trailingAnchor.constraint(equalTo: hourlyWeatherView.trailingAnchor, constant: -10),
            hourlyCollectionView.bottomAnchor.constraint(equalTo: hourlyWeatherView.bottomAnchor),
        ])
    }
    
    func configHourlyDataSource(hourly: [Hourly]) {
        let cellRegistration = UICollectionView.CellRegistration<HourlyCollectionViewCell, Hourly>  { cell, indexPath, data in
            if data.dt == hourly[0].dt {
                cell.configNowHourlyCell(data: data)
            } else {
                cell.configHourlyCell(data: data)
            }
        }
        
        hourlyDataSource = UICollectionViewDiffableDataSource<Section, Hourly>(collectionView: hourlyCollectionView, cellProvider: { (collectionView, indexPath, itemIdentifier) -> UICollectionViewCell? in
            return collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: itemIdentifier)
        })
        
        var snapShot = NSDiffableDataSourceSnapshot<Section, Hourly>()
        snapShot.appendSections([.main])
        snapShot.appendItems(hourly)
        hourlyDataSource.apply(snapShot)
    }
}
