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
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 1)

        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = CGFloat(10)
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20)
        section.orthogonalScrollingBehavior = .continuous
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }
    
    func createHoulryCollectionView() {
        horizontalCollectionView = UICollectionView(frame: .zero, collectionViewLayout: createHourlyLayout())
        
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
    
    func configHourlyDataSource(hourly: [Hourly]) {
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
