//
//  MainView.swift
//  JeonHyowon-assignment
//
//  Created by Hyowon Jeon on 12/14/23.
//

import UIKit

import SnapKit
import Then

final class MainView: UIView {
    
    public let cityList: [String] = ["seoul", "jeju", "gwangju", "daegu", "cheonan"]
    
    public var settingButton = UIButton().then {
        $0.setImage(UIImage(named: "icon_setting"), for: .normal)
    }
    
    public var weatherLabel = UILabel().then {
        $0.text = "날씨"
        $0.font = UIFont(name: "SFProDisplay-Bold", size: 36)
        $0.textColor = .white
    }
    
    public var searchBar = UISearchBar().then {
        $0.placeholder = "도시 또는 공항 검색"
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 10
        $0.setImage(UIImage(named: "icon_search"), for: .search, state: .normal)
        $0.searchBarStyle = .minimal
    }
    
    public var tableView = UITableView(frame: .zero, style: .plain).then {
        $0.backgroundColor = .clear
        $0.clipsToBounds = true
        $0.sectionHeaderTopPadding = 0
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupHierarchy()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupHierarchy() {
        [
            settingButton,
            weatherLabel,
            searchBar,
            tableView
        ].forEach {
            self.addSubview($0)
        }
    }
    
    private func setupLayout() {
        settingButton.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaLayoutGuide).offset(8)
            $0.trailing.equalToSuperview().inset(10)
            $0.size.equalTo(44)
        }
        
        weatherLabel.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaLayoutGuide).offset(53)
            $0.leading.equalToSuperview().inset(20)
        }
        
        searchBar.snp.makeConstraints {
            $0.top.equalTo(weatherLabel.snp.bottom).offset(8)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(40)
        }
        
        tableView.snp.makeConstraints {
            $0.top.equalTo(searchBar.snp.bottom).offset(15)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.bottom.equalToSuperview()
        }
    }
}

