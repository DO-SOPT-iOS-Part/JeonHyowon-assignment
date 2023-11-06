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
    
    private var backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "Img")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        return scrollView
    }()
    
    private var contentView = UIView()
    
    private var cityLabel: UILabel = {
        let label = UILabel()
        label.text = "서울특별시"
        label.font = UIFont(name: "SFProDisplay-Regular", size: 36)
        label.textColor = .white
        return label
    }()
    
    private var currentTemperatureLabel: UILabel = {
        let label = UILabel()
        label.text = "21°"
        label.font = UIFont(name: "SFProDisplay-Thin", size: 102)
        label.textColor = .white
        return label
    }()
    
    private var currentWeatherLabel: UILabel = {
        let label = UILabel()
        label.text = "흐림"
        label.font = UIFont(name: "SFProDisplay-Regular", size: 24)
        label.textColor = .white
        return label
    }()
    
    private var temperatureLabel: UILabel = {
        let label = UILabel()
        label.text = "최고:29° 최저:15°"
        label.font = UIFont(name: "SFProDisplay-Medium", size: 20)
        label.textColor = .white
        return label
    }()
    
    private var weatherDetailView: UIView = {
        let view = UIView()
        view.clipsToBounds = true
        view.layer.cornerRadius = 15
        view.layer.borderWidth = 0.5
        view.layer.borderColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.25).cgColor
        return view
    }()
    
    private var detailLabel: UILabel = {
        let label = UILabel()
        label.text = "08:00~09:00에 강우 상태가, 18:00에 한때 흐린 상태가 예상됩니다."
        label.font = UIFont(name: "SFProDisplay-Regular", size: 18)
        label.textColor = .white
        label.numberOfLines = 0
        return label
    }()
    
    private var separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.25)
        return view
    }()
    
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
        
    private var mapButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "icon_map"), for: .normal)
        return button
    }()
    
    private var toolbarView: UIView = {
        let view = UIView()
        view.layer.borderWidth = 0.5
        view.layer.borderColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.25).cgColor
        return view
    }()

    private lazy var menuButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "icon_menu"), for: .normal)
        button.addTarget(self, action: #selector(didTapMenuButton), for: .touchUpInside)
        return button
    }()
    
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
            $0.edges.equalToSuperview()
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
            weatherDetailView
        ].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview($0)
        }
        
        cityLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(78)
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
            $0.leading.trailing.bottom.equalToSuperview().inset(20)
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
