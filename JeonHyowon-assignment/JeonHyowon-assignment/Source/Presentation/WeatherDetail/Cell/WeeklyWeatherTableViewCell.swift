//
//  WeeklyWeatherTableViewCell.swift
//  JeonHyowon-assignment
//
//  Created by Hyowon Jeon on 11/6/23.
//

import UIKit

import SnapKit
import Then

class WeeklyWeatherTableViewCell: UITableViewCell {

    static let identifier: String = "WeeklyWeatherTableViewCell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func bindData(data: WeeklyWeatherData) {
        self.dayLabel.text = data.day
        self.weatherImageView.image = UIImage(systemName: data.weatherImage)?.withRenderingMode(.alwaysOriginal)
        self.minimumTemperatureLabel.text = data.minimumTemperature
        self.temperatureImageView.image = UIImage(named: data.temperatureImage)
        self.maximumTemperatureLabel.text = data.maximumTemperature
    }
    
    private func setLayout() {
        self.backgroundColor = .clear
        [dayLabel, weatherImageView, minimumTemperatureLabel, temperatureImageView, maximumTemperatureLabel].forEach {
            self.contentView.addSubview($0)
        }

        dayLabel.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(14)
            $0.leading.equalToSuperview().inset(16)
        }
        
        weatherImageView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(220)
            $0.size.equalTo(26)
        }
        
        minimumTemperatureLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalTo(temperatureImageView.snp.leading).offset(-5)
        }
        
        temperatureImageView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalTo(maximumTemperatureLabel.snp.leading).offset(-5)
        }
        
        maximumTemperatureLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(16)
        }
    }
    
    private var dayLabel = UILabel().then {
        $0.font = UIFont(name: "SFProDisplay-Medium", size: 22)
        $0.textColor = .white
    }
    
    private var weatherImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFill
    }
    
    private var minimumTemperatureLabel = UILabel().then {
        $0.font = UIFont(name: "SFProDisplay-Medium", size: 22)
        $0.textColor = .lightGray
    }
    
    private var temperatureImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFill
    }
    
    private var maximumTemperatureLabel = UILabel().then {
        $0.font = UIFont(name: "SFProDisplay-Medium", size: 22)
        $0.textColor = .white
    }
}
