//
//  LocationTableViewCell.swift
//  JeonHyowon-assignment
//
//  Created by Hyowon Jeon on 11/17/23.
//

import UIKit

import SnapKit
import Then

class LocationTableViewCell: UITableViewCell {
    
    static let identifier: String = "LocationTableViewCell"

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = .clear
        self.setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func bindData(city: String) {
        Task {
            if let result = try await GetWeatherService.shared.getWeatherData(cityName: city) {
                self.cityLabel.text = translateCityNameToKorean(name: result.name)
                self.timeLabel.text = dateToString(date: Date())
                self.currentWeatherLabel.text = result.weather[0].description
                self.currentTemperatureLabel.text = "\(Int(round(result.main.currentTemperature)))°"
                self.minimumTemperatureLabel.text = "최저:\(Int(round(result.main.minimumTemperature)))°"
                self.maximumTemperatureLabel.text = "최고:\(Int(round(result.main.maximumTemperature)))°"
            }
        }
    }
    
    private var backgroundImageView = UIImageView().then {
        $0.image = UIImage(named: "list")
        $0.contentMode = .scaleToFill
    }
    
    private var cityLabel = UILabel().then {
        $0.font = UIFont(name: "SFProDisplay-Bold", size: 24)
        $0.textColor = .white
    }
    
    private var timeLabel = UILabel().then {
        $0.font = UIFont(name: "SFProDisplay-Medium", size: 17)
        $0.textColor = .white
    }
    
    private var currentWeatherLabel = UILabel().then {
        $0.font = UIFont(name: "SFProDisplay-Medium", size: 16)
        $0.textColor = .white
    }
    
    private var currentTemperatureLabel = UILabel().then {
        $0.font = UIFont(name: "SFProDisplay-Light", size: 52)
        $0.textColor = .white
    }
    
    private var minimumTemperatureLabel = UILabel().then {
        $0.font = UIFont(name: "SFProDisplay-Medium", size: 15)
        $0.textColor = .white
    }
    
    private var maximumTemperatureLabel = UILabel().then {
        $0.font = UIFont(name: "SFProDisplay-Medium", size: 15)
        $0.textColor = .white
    }
}

private extension LocationTableViewCell {
    func translateCityNameToKorean(name: String) -> String {
        let translations: [String: String] = [
            "Seoul": "서울특별시",
            "Jeju City": "제주특별자치도",
            "Gwangju": "광주광역시",
            "Daegu": "대구광역시",
            "Cheonan": "천안시"
        ]
        return translations[name] ?? name
    }
    
    func dateToString(date: Date) -> String {
        let dateFormatter = DateFormatter().then {
            $0.dateFormat = "HH:mm"
        }
        
        return dateFormatter.string(from: date)
    }
    
    func setLayout() {
        [backgroundImageView, cityLabel, timeLabel, currentWeatherLabel, currentTemperatureLabel, minimumTemperatureLabel, maximumTemperatureLabel].forEach {
            self.contentView.addSubview($0)
        }
        
        backgroundImageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        cityLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(10)
            $0.leading.equalToSuperview().inset(16)
        }
        
        timeLabel.snp.makeConstraints {
            $0.top.equalTo(cityLabel.snp.bottom).offset(2)
            $0.leading.equalToSuperview().inset(16)
        }
        
        currentWeatherLabel.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(10)
            $0.leading.equalToSuperview().inset(16)
        }
        
        currentTemperatureLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(4)
            $0.trailing.equalToSuperview().inset(16)
        }
        
        minimumTemperatureLabel.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(10)
            $0.trailing.equalToSuperview().inset(16)
        }
        
        maximumTemperatureLabel.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(10)
            $0.trailing.equalTo(minimumTemperatureLabel.snp.leading).offset(-6)
        }
    }
}
