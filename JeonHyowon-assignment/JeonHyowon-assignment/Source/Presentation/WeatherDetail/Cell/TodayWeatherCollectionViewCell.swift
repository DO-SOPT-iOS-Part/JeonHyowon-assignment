//
//  TodayWeatherCollectionViewCell.swift
//  JeonHyowon-assignment
//
//  Created by Hyowon Jeon on 11/6/23.
//

import UIKit

import SnapKit
import Then

class TodayWeatherCollectionViewCell: UICollectionViewCell {
    
    static let identifier: String = "TodayWeatherCollectionViewCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func bindData(data: TodayWeatherData) {
        self.hourLabel.text = data.hour
        self.weatherImageView.image = UIImage(named: data.image)
        self.temperatureLabel.text = data.temperature
    }
    
    private func setLayout() {
        [hourLabel, weatherImageView, temperatureLabel].forEach {
            self.contentView.addSubview($0)
        }
        
        hourLabel.snp.makeConstraints {
            $0.top.centerX.equalToSuperview()
        }
        
        weatherImageView.snp.makeConstraints {
            $0.top.equalTo(hourLabel.snp.bottom).offset(14)
            $0.leading.trailing.equalToSuperview()
            $0.size.equalTo(44)
        }
        
        temperatureLabel.snp.makeConstraints {
            $0.top.equalTo(weatherImageView.snp.bottom).offset(14)
            $0.centerX.equalToSuperview()
        }
    }
    
    private var hourLabel = UILabel().then {
        $0.font = UIFont(name: "SFProDisplay-Medium", size: 17)
        $0.textColor = .white
    }
    
    private var weatherImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFill
    }
    
    private var temperatureLabel = UILabel().then {
        $0.font = UIFont(name: "SFProDisplay-Medium", size: 22)
        $0.textColor = .white
    }
    
}
