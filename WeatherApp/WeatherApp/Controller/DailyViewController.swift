//
//  DailyViewController.swift
//  WeatherApp
//
//  Created by 박도원 on 2022/12/24.
//

import Foundation
import UIKit

extension ViewController {
    func createDailyLayout() -> UICollectionViewCompositionalLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(50), heightDimension: .absolute(50))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, repeatingSubitem: item, count: 1)
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10)
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }
    
    func createDailyCollectionView() {
        dailyCollectionView = UICollectionView(frame: .zero, collectionViewLayout: createDailyLayout())
        
        dailyWeatherView.addSubview(dailyCollectionView)
        dailyCollectionView.translatesAutoresizingMaskIntoConstraints = false
        dailyCollectionView.layer.cornerRadius = 10
        
        NSLayoutConstraint.activate([
            dailyCollectionView.topAnchor.constraint(equalTo: dailyWeatherView.topAnchor),
            dailyCollectionView.leadingAnchor.constraint(equalTo: dailyWeatherView.leadingAnchor, constant: 10),
            dailyCollectionView.trailingAnchor.constraint(equalTo: dailyWeatherView.trailingAnchor, constant: -10),
            dailyCollectionView.bottomAnchor.constraint(equalTo: dailyWeatherView.bottomAnchor),
        ])
    }
    
    func configDailyDataSource(daily: [Daily]) {
        let cellRegistration = UICollectionView.CellRegistration<DailyCollectionViewCell, Daily> { cell, indexPath, data in
            cell.configDailyCell(data: data)
        }
            
        dailyDataSource = UICollectionViewDiffableDataSource<Section, Daily>(collectionView: dailyCollectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            return collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: itemIdentifier)
        })
        
        var snapShot = NSDiffableDataSourceSnapshot<Section, Daily>()
        snapShot.appendSections([.main])
        snapShot.appendItems(daily)
        dailyDataSource.apply(snapShot)
    }
}
