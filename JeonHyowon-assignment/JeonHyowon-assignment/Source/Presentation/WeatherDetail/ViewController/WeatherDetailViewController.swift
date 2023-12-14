//
//  WeatherDetailViewController.swift
//  JeonHyowon-assignment
//
//  Created by Hyowon Jeon on 10/25/23.
//

import UIKit

import SnapKit
import Then

final class WeatherDetailViewController: UIViewController {

    private let rootView = WeatherDetailView()
    
    override func loadView() {
        self.view = rootView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        target()
        register()
        delegate()
        setupStyle()

    }
    
    private func target() {
        rootView.menuButton.addTarget(self, 
                                      action: #selector(didTapMenuButton), for: .touchUpInside)
    }
    
    private func register() {
        rootView.collectionView.register(TodayWeatherCollectionViewCell.self, forCellWithReuseIdentifier: TodayWeatherCollectionViewCell.identifier)
        rootView.tableView.register(WeeklyWeatherTableViewCell.self, forCellReuseIdentifier: WeeklyWeatherTableViewCell.identifier)
    }
    
    private func delegate() {
        rootView.tableView.delegate = self
        rootView.tableView.dataSource = self
        rootView.collectionView.dataSource = self
    }
    
    private func setupStyle() {
        self.view.backgroundColor = .black
    }
    
    @objc func didTapMenuButton() {
        self.navigationController?.popViewController(animated: true)
    }
}

extension WeatherDetailViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return rootView.todayWeatherData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let item = collectionView.dequeueReusableCell(
            withReuseIdentifier: TodayWeatherCollectionViewCell.identifier,
            for: indexPath
        ) as? TodayWeatherCollectionViewCell else {return UICollectionViewCell()}
        
        item.bindData(data: rootView.todayWeatherData[indexPath.item])
        return item
    }
}

extension WeatherDetailViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        
        let imageView = UIImageView().then {
            $0.image = UIImage(named: "icon_calendar")
            $0.tintColor = .lightGray
            $0.contentMode = .scaleAspectFill
        }
        
        let label = UILabel().then {
            $0.text = "10일간의 일기예보"
            $0.font = UIFont(name: "SFProDisplay-Medium", size: 15)
            $0.textColor = .lightGray
        }
        
        [imageView, label].forEach {
            headerView.addSubview($0)
        }
        
        imageView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(12)
            $0.leading.equalToSuperview().inset(16)
        }
        
        label.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(imageView.snp.trailing).offset(5)
        }
        
        return headerView
    }
}

extension WeatherDetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rootView.weeklyWeatherData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: WeeklyWeatherTableViewCell.identifier,
            for: indexPath
        ) as? WeeklyWeatherTableViewCell else {return UITableViewCell()}
        
        cell.selectionStyle = .none
        cell.bindData(data: rootView.weeklyWeatherData[indexPath.row])
        return cell
    }
}
