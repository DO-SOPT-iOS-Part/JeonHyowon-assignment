//
//  MainViewController.swift
//  JeonHyowon-assignment
//
//  Created by Hyowon Jeon on 10/25/23.
//

import UIKit

import SnapKit

class MainViewController: UIViewController {
    
    private var settingButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "icon_setting"), for: .normal)
        return button
    }()
    
    private var weatherLabel: UILabel = {
        let label = UILabel()
        label.text = "날씨"
        label.font = UIFont(name: "SFProDisplay-Bold", size: 36)
        label.textColor = .white
        return label
    }()
    
    private var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "도시 또는 공항 검색"
        searchBar.clipsToBounds = true
        searchBar.layer.cornerRadius = 10
        searchBar.setImage(UIImage(named: "icon_search"), for: .search, state: .normal)
        searchBar.searchBarStyle = .minimal

        return searchBar
    }()
    
    private var stackView = UIStackView()
    
    private var locationView = UIView()
    
    private var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "list")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private var locationLabel: UILabel = {
        let label = UILabel()
        label.text = "나의 위치"
        label.font = UIFont(name: "SFProDisplay-Bold", size: 24)
        label.textColor = .white
        return label
    }()
    
    private var cityLabel: UILabel = {
        let label = UILabel()
        label.text = "서울특별시"
        label.font = UIFont(name: "SFProDisplay-Medium", size: 17)
        label.textColor = .white
        return label
    }()
    
    private var currentWeatherLabel: UILabel = {
        let label = UILabel()
        label.text = "흐림"
        label.font = UIFont(name: "SFProDisplay-Medium", size: 16)
        label.textColor = .white
        return label
    }()
    
    private var currentTemperatureLabel: UILabel = {
        let label = UILabel()
        label.text = "21°"
        label.font = UIFont(name: "SFProDisplay-Light", size: 52)
        label.textColor = .white
        return label
    }()
    
    private var minimumTemperatureLabel: UILabel = {
        let label = UILabel()
        label.text = "최저:15°"
        label.font = UIFont(name: "SFProDisplay-Medium", size: 15)
        label.textColor = .white
        return label
    }()
    
    private var maximumTemperatureLabel: UILabel = {
        let label = UILabel()
        label.text = "최고:29°"
        label.font = UIFont(name: "SFProDisplay-Medium", size: 15)
        label.textColor = .white
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .black
        
        self.navigationController?.navigationBar.isHidden = true
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapLocationView))
        self.locationView.addGestureRecognizer(tapGesture)
        
        setLayout()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}

private extension MainViewController {
    @objc func didTapLocationView(sender: UITapGestureRecognizer) {
        self.navigationController?.pushViewController(WeatherDetailViewController(), animated: true)
    }
}

private extension MainViewController {
    func setLayout() {
        [
            settingButton,
            weatherLabel,
            searchBar,
            stackView
        ].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
        }
        
        [
            locationView
        ].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            stackView.addSubview($0)
        }
        
        [
            imageView,
            locationLabel,
            cityLabel,
            currentWeatherLabel,
            currentTemperatureLabel,
            minimumTemperatureLabel,
            maximumTemperatureLabel
        ].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            locationView.addSubview($0)
        }
        
        settingButton.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(8)
            $0.trailing.equalToSuperview().inset(-10)
            $0.size.equalTo(44)
        }
        
        weatherLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(53)
            $0.leading.equalToSuperview().inset(20)
        }
        
        searchBar.snp.makeConstraints {
            $0.top.equalTo(weatherLabel.snp.bottom).offset(8)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(40)
        }
        
        stackView.snp.makeConstraints {
            $0.top.equalTo(searchBar.snp.bottom).offset(15)
            $0.leading.trailing.bottom.equalToSuperview()
        }
        
        locationView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(20)
        }
        
        imageView.snp.makeConstraints {
            $0.edges.equalTo(locationView.snp.edges)
        }
        
        locationLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(10)
            $0.leading.equalToSuperview().inset(16)
        }
        
        cityLabel.snp.makeConstraints {
            $0.top.equalTo(locationLabel.snp.bottom).offset(2)
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

