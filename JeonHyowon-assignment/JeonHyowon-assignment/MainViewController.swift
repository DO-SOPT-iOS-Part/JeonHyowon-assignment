//
//  MainViewController.swift
//  JeonHyowon-assignment
//
//  Created by Hyowon Jeon on 10/25/23.
//

import UIKit

import SnapKit
import Then

class MainViewController: UIViewController {
    
    let cityList: [String] = ["seoul", "jeju", "gwangju", "daegu", "cheonan"]
    
    private var settingButton = UIButton().then {
        $0.setImage(UIImage(named: "icon_setting"), for: .normal)
    }
    
    private var weatherLabel = UILabel().then {
        $0.text = "날씨"
        $0.font = UIFont(name: "SFProDisplay-Bold", size: 36)
        $0.textColor = .white
    }
    
    private var searchBar = UISearchBar().then {
        $0.placeholder = "도시 또는 공항 검색"
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 10
        $0.setImage(UIImage(named: "icon_search"), for: .search, state: .normal)
        $0.searchBarStyle = .minimal
    }
    
    private lazy var tableView = UITableView(frame: .zero, style: .plain).then {
        $0.backgroundColor = .clear
        $0.clipsToBounds = true
        $0.sectionHeaderTopPadding = 0
        $0.delegate = self
        $0.dataSource = self
        $0.register(LocationTableViewCell.self, forCellReuseIdentifier: LocationTableViewCell.identifier)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .black
        
        self.navigationController?.navigationBar.isHidden = true
        
        setLayout()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}

extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.navigationController?.pushViewController(WeatherDetailViewController(), animated: true)
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 16
    }
}

extension MainViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return cityList.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: LocationTableViewCell.identifier,
            for: indexPath
        ) as? LocationTableViewCell else {return UITableViewCell()}
        
        cell.selectionStyle = .none
        cell.bindData(city: cityList[indexPath.section])
        return cell
    }
}

private extension MainViewController {
    func setLayout() {
        [
            settingButton,
            weatherLabel,
            searchBar,
            tableView
        ].forEach {
            view.addSubview($0)
        }
        
        settingButton.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(8)
            $0.trailing.equalToSuperview().inset(10)
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
        
        tableView.snp.makeConstraints {
            $0.top.equalTo(searchBar.snp.bottom).offset(15)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.bottom.equalToSuperview()
        }
    }
}

