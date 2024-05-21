//
//  SettingsController.swift
//  HW 5 Notes
//
//  Created by Rahilya Nazaralieva on 29/4/24.
//

import SnapKit
import UIKit

class SettingsController: UIViewController {
    
    private let coreDataService = CoreDataService.shared
    
    private lazy var settingsTableView: UITableView = {
        let view = UITableView()
        view.delegate = self
        view.dataSource = self
        view.layer.cornerRadius = 10
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
            make.height.equalTo(160)
            make.horizontalEdges.equalToSuperview().inset(12)
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
        cell.selectionStyle = .none
        return cell
    }
}

extension SettingsController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 55
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! SettingsCell
        cell.didSelect()
        if indexPath.row == 2 {
            let alertController = UIAlertController(title: "Удалить?", message: "Вы уверены, что хотите удалить заметки?", preferredStyle: .alert)
            let acceptAction = UIAlertAction(title: "Да", style: .cancel) { action in
                self.coreDataService.deleteAllNotes { response in
                    if response == .success {
                        let homeView = HomeView()
                        self.navigationController?.popViewController(animated: true)
                    } else {
                    }
                }
            }
            let declineAction = UIAlertAction(title: "Нет", style: .default) { action in
            }
            alertController.addAction(acceptAction)
            alertController.addAction(declineAction)
            present(alertController, animated: true)
        } else if indexPath.row == 0 {
            let languageView = LanguageController()
            navigationController?.present(languageView, animated: true)
           
        }
    }
    
}
extension SettingsController: SettingsDelegate {
    func navigateToNextController() {
        let languageController = LanguageController()
        navigationController?.present(languageController, animated: true)
    }
    
    func didChangeTheme(isOn: Bool) {
        UserDefaults.standard.set(isOn, forKey: "theme")
        if isOn {
            view.overrideUserInterfaceStyle = .dark
        } else {
            view.overrideUserInterfaceStyle = .light
        }
    }
}
