//
//  MainViewController.swift
//  JeonHyowon-assignment
//
//  Created by Hyowon Jeon on 10/25/23.
//

import UIKit

import SnapKit
import Then

final class MainViewController: UIViewController {
    
    private let rootView = MainView()
    
    override func loadView() {
        self.view = rootView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        register()
        delegate()
        setupStyle()

    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    private func register() {
        rootView.tableView.register(LocationTableViewCell.self, forCellReuseIdentifier: LocationTableViewCell.identifier)
    }
    
    private func delegate() {
        rootView.tableView.dataSource = self
        rootView.tableView.delegate = self
    }
    
    private func setupStyle() {
        view.backgroundColor = .black
        self.navigationController?.navigationBar.isHidden = true
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
        return rootView.cityList.count
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
        cell.bindData(city: rootView.cityList[indexPath.section])
        return cell
    }
}
