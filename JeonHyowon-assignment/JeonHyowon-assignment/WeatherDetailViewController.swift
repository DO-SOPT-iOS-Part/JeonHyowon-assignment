//
//  WeatherDetailViewController.swift
//  JeonHyowon-assignment
//
//  Created by Hyowon Jeon on 10/25/23.
//

import UIKit

import SnapKit
import Then

class WeatherDetailViewController: UIViewController {
    
    let todayWeatherData: [TodayWeatherData] = [.init(hour: "Now", image: "icon_cloudy", temperature: "18°"),
                                                .init(hour: "10시", image: "icon_heavyrain", temperature: "17°"),
                                                .init(hour: "11시", image: "icon_lightning", temperature: "16°"),
                                                .init(hour: "12시", image: "icon_cloudy", temperature: "16°"),
                                                .init(hour: "1시", image: "icon_rain", temperature: "15°"),
                                                .init(hour: "2시", image: "icon_sunshower", temperature: "14°"),
                                                .init(hour: "3시", image: "icon_sunshower", temperature: "14°"),
                                                .init(hour: "4시", image: "icon_cloudy", temperature: "14°"),
                                                .init(hour: "5시", image: "icon_lightning", temperature: "13°"),
                                                .init(hour: "6시", image: "icon_lightning", temperature: "11°"),
                                                .init(hour: "7시", image: "icon_heavyrain", temperature: "10°"),
                                                .init(hour: "8시", image: "icon_cloudy", temperature: "10°"),
                                                .init(hour: "9시", image: "icon_lightning", temperature: "9°"),
                                                .init(hour: "10시", image: "icon_sunshower", temperature: "8°"),
                                                .init(hour: "11시", image: "icon_cloudy", temperature: "7°")]
    
    let weeklyWeatherData: [WeeklyWeatherData] = [.init(day: "오늘", weatherImage: "cloud.sun.fill", minimumTemperature: "15°", temperatureImage: "temperature1", maximumTemperature: "29°"),
                                                  .init(day: "월", weatherImage: "sun.max.fill", minimumTemperature: "18°", temperatureImage: "temperature2", maximumTemperature: "27°"),
                                                  .init(day: "화", weatherImage: "cloud.fill", minimumTemperature: "20°", temperatureImage: "temperature3", maximumTemperature: "25°"),
                                                  .init(day: "수", weatherImage: "cloud.rain.fill", minimumTemperature: "17°", temperatureImage: "temperature4", maximumTemperature: "25°"),
                                                  .init(day: "목", weatherImage: "sun.max.fill", minimumTemperature: "17°", temperatureImage: "temperature5", maximumTemperature: "25°"),
                                                  .init(day: "금", weatherImage: "cloud.heavyrain.fill", minimumTemperature: "20°", temperatureImage: "temperature6", maximumTemperature: "26°"),
                                                  .init(day: "토", weatherImage: "cloud.bolt.fill", minimumTemperature: "18°", temperatureImage: "temperature7", maximumTemperature: "25°"),
                                                  .init(day: "일", weatherImage: "cloud.sun.rain.fill", minimumTemperature: "13°", temperatureImage: "temperature8", maximumTemperature: "21°"),
                                                  .init(day: "월", weatherImage: "smoke.fill", minimumTemperature: "12°", temperatureImage: "temperature9", maximumTemperature: "19°"),
                                                  .init(day: "화", weatherImage: "cloud.sleet.fill", minimumTemperature: "18°", temperatureImage: "temperature10", maximumTemperature: "25°"),
                                                  .init(day: "수", weatherImage: "sun.max.fill", minimumTemperature: "18°", temperatureImage: "temperature11", maximumTemperature: "25°")]
    
    private var backgroundImageView = UIImageView().then {
        $0.image = UIImage(named: "Img")
        $0.contentMode = .scaleAspectFill
    }
    
    private var scrollView = UIScrollView().then {
        $0.showsHorizontalScrollIndicator = false
    }
    
    private var contentView = UIView()
    
    private var cityLabel = UILabel().then {
        $0.text = "서울특별시"
        $0.font = UIFont(name: "SFProDisplay-Regular", size: 36)
        $0.textColor = .white
    }
    
    private var currentTemperatureLabel = UILabel().then {
        $0.text = "21°"
        $0.font = UIFont(name: "SFProDisplay-Thin", size: 102)
        $0.textColor = .white
    }
    
    private var currentWeatherLabel = UILabel().then {
        $0.text = "흐림"
        $0.font = UIFont(name: "SFProDisplay-Regular", size: 24)
        $0.textColor = .white
    }
    
    private var temperatureLabel = UILabel().then {
        $0.text = "최고:29° 최저:15°"
        $0.font = UIFont(name: "SFProDisplay-Medium", size: 20)
        $0.textColor = .white
    }
    
    private var weatherDetailView = UIView().then {
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 15
        $0.layer.borderWidth = 0.5
        $0.layer.borderColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.25).cgColor
    }
    
    private var detailLabel = UILabel().then {
        $0.text = "08:00~09:00에 강우 상태가, 18:00에 한때 흐린 상태가 예상됩니다."
        $0.font = UIFont(name: "SFProDisplay-Regular", size: 18)
        $0.textColor = .white
        $0.numberOfLines = 0
    }
    
    private var separatorView = UIView().then {
        $0.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.25)
    }
    
    private var collectionViewLayout = UICollectionViewFlowLayout().then {
        $0.itemSize = CGSize(width: 44, height: 140)
        $0.minimumInteritemSpacing = 22
        $0.scrollDirection = .horizontal
    }
    
    private lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout).then {
        $0.backgroundColor = .clear
        $0.collectionViewLayout = collectionViewLayout
        $0.dataSource = self
        $0.register(TodayWeatherCollectionViewCell.self, forCellWithReuseIdentifier: TodayWeatherCollectionViewCell.identifier)
    }
    
    private lazy var tableView = UITableView(frame: .zero, style: .plain).then {
        $0.backgroundColor = .init(white: 0.5, alpha: 0.05)
        $0.separatorColor = .lightGray
        $0.separatorStyle = .singleLine
        $0.isScrollEnabled = false
        $0.layer.cornerRadius = 15
        $0.layer.borderWidth = 0.5
        $0.layer.borderColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.25).cgColor
        $0.clipsToBounds = true
        $0.sectionHeaderTopPadding = 0
        $0.delegate = self
        $0.dataSource = self
        $0.register(WeeklyWeatherTableViewCell.self, forCellReuseIdentifier: WeeklyWeatherTableViewCell.identifier)
    }
        
    private var mapButton = UIButton().then {
        $0.setImage(UIImage(named: "icon_map"), for: .normal)
    }
    
    private var toolbarView = UIView().then {
        $0.layer.borderWidth = 0.5
        $0.layer.borderColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.25).cgColor
    }

    private lazy var menuButton = UIButton().then {
        $0.setImage(UIImage(named: "icon_menu"), for: .normal)
        $0.addTarget(self, action: #selector(didTapMenuButton), for: .touchUpInside)
    }
    
    @objc func didTapMenuButton() {
        self.navigationController?.popViewController(animated: true)
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .black
                        
        setLayout()
    }
}

extension WeatherDetailViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return todayWeatherData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let item = collectionView.dequeueReusableCell(
            withReuseIdentifier: TodayWeatherCollectionViewCell.identifier,
            for: indexPath
        ) as? TodayWeatherCollectionViewCell else {return UICollectionViewCell()}
        
        item.bindData(data: todayWeatherData[indexPath.item])
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
            $0.translatesAutoresizingMaskIntoConstraints = false
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
        return weeklyWeatherData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: WeeklyWeatherTableViewCell.identifier,
            for: indexPath
        ) as? WeeklyWeatherTableViewCell else {return UITableViewCell()}
        
        cell.selectionStyle = .none
        cell.bindData(data: weeklyWeatherData[indexPath.row])
        return cell
    }
}

private extension WeatherDetailViewController {
    func setLayout() {
        [
            backgroundImageView,
            scrollView,
            toolbarView
        ].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
        }
        
        backgroundImageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        scrollView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(toolbarView.snp.top)
        }
        
        toolbarView.snp.makeConstraints {
            $0.leading.trailing.bottom.equalToSuperview()
            $0.height.equalTo(82)
        }
        
        [
            contentView
        ].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            scrollView.addSubview($0)
        }
        
        contentView.snp.makeConstraints {
            $0.edges.width.equalToSuperview()
        }
        
        [
            mapButton,
            menuButton
        ].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            toolbarView.addSubview($0)
        }
        
        mapButton.snp.makeConstraints {
            $0.top.equalToSuperview().inset(4)
            $0.leading.equalToSuperview().inset(10)
        }
        
        menuButton.snp.makeConstraints {
            $0.top.equalToSuperview().inset(4)
            $0.trailing.equalToSuperview().inset(10)
        }
        
        [
            cityLabel,
            currentTemperatureLabel,
            currentWeatherLabel,
            temperatureLabel,
            weatherDetailView,
            tableView
        ].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview($0)
        }
        
        cityLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(34)
            $0.centerX.equalToSuperview()
        }
        
        currentTemperatureLabel.snp.makeConstraints {
            $0.top.equalTo(cityLabel.snp.bottom).offset(4)
            $0.centerX.equalToSuperview()
        }
        
        currentWeatherLabel.snp.makeConstraints {
            $0.top.equalTo(currentTemperatureLabel.snp.bottom).offset(4)
            $0.centerX.equalToSuperview()
        }
        
        temperatureLabel.snp.makeConstraints {
            $0.top.equalTo(currentWeatherLabel.snp.bottom).offset(4)
            $0.centerX.equalToSuperview()
        }
        
        weatherDetailView.snp.makeConstraints {
            $0.top.equalTo(temperatureLabel.snp.bottom).offset(44)
            $0.leading.trailing.equalToSuperview().inset(20)
        }
        
        tableView.snp.makeConstraints {
            $0.top.equalTo(weatherDetailView.snp.bottom).offset(20)
            $0.leading.trailing.bottom.equalToSuperview().inset(20)
            $0.height.equalTo(weeklyWeatherData.count * 54 + 80)
        }
        
        [
            detailLabel,
            separatorView,
            collectionView
        ].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            weatherDetailView.addSubview($0)
        }
        
        detailLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(10)
            $0.leading.trailing.equalToSuperview().inset(16)
        }
        
        separatorView.snp.makeConstraints {
            $0.top.equalTo(detailLabel.snp.bottom).offset(10)
            $0.leading.equalToSuperview().inset(14)
            $0.trailing.equalToSuperview()
            $0.height.equalTo(0.2)
        }
        
        collectionView.snp.makeConstraints {
            $0.top.equalTo(separatorView.snp.bottom).offset(14)
            $0.leading.trailing.bottom.equalToSuperview()
            $0.height.equalTo(140)
        }
    }
}
