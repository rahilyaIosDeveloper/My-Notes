//
//  SettingsController.swift
//  HW 5 Notes
//
//  Created by Rahilya Nazaralieva on 29/4/24.
//

import SnapKit
import UIKit

class SettingsController: UIViewController {
    
    private lazy var settingsTableView: UITableView = {
        let view = UITableView()
        view.delegate = self
        view.dataSource = self
        view.register(SettingsCell.self, forCellReuseIdentifier: SettingsCell.reuseId)
        return view
    }()
    
    
    private var settingData: [SettingsStruct] = [
        SettingsStruct(image: "language", title: "Язык", type: .withButton, description: "Русский"), 
        SettingsStruct(image: "moon", title: "Темная тема", type: .withSwitch, description: ""),
        SettingsStruct(image: "trash", title: "Очистить данные", type: .none, description: "")]

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if UserDefaults.standard.bool(forKey: "theme") {
            view.overrideUserInterfaceStyle = .dark
        } else {
            view.overrideUserInterfaceStyle = .light
        }
        settingsTableView.reloadData()
    }
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
        setupConstraints()
        setupNavBar()
    }
    
    private func setupConstraints() {
        view.addSubview(settingsTableView)
        settingsTableView.snp.makeConstraints {make in 
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(151)
            make.horizontalEdges.equalToSuperview().inset(11)
        }
    }

    private func setupNavBar() {
        title = "Settings"
        
        let rightBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "gear"),
            style: .plain,
            target: self,
            action: #selector(settingsButtonTapped))
        navigationItem.rightBarButtonItem = rightBarButtonItem
    }
    
    @objc
    private func settingsButtonTapped() {
        
    }
}

extension SettingsController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settingData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SettingsCell.reuseId, for: indexPath) as! SettingsCell
        cell.fill(with: settingData[indexPath.row])
        cell.delegate = self
        return cell
    }
    
    
}

extension SettingsController: UITableViewDelegate {
    
}

extension SettingsController: SettingsDelegate {
    func didChangeTheme(isOn: Bool) {
        UserDefaults.standard.set(isOn, forKey: "theme")
        if isOn {
            view.overrideUserInterfaceStyle = .dark
        } else {
            view.overrideUserInterfaceStyle = .light
        }
    }
}
