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
        SettingsStruct(image: "language", title: "Choose language".localised(), type: .withButton, description: "English".localised()),
        SettingsStruct(image: "moon", title: "Choose Theme".localised(), type: .withSwitch, description: ""),
        SettingsStruct(image: "trash", title: "Clear data".localised(), type: .none, description: "")]
    
    func updateSettingsLanguage() {
        settingData = [SettingsStruct(image: "language", title: "Choose language".localised(),
                                      type: .withButton, description: "English".localised()),
                       SettingsStruct(image: "moon", title: "Choose Theme".localised(),
                                      type: .withSwitch, description: ""),
                       SettingsStruct(image: "trash", title: "Clear data".localised(),
                                      type: .none, description: "")]
        settingsTableView.reloadData()
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupLocalizedText()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
        let appearance = UINavigationBarAppearance()
        if UserDefaults.standard.bool(forKey: "theme") == true {
            navigationController?.navigationBar.barTintColor = .white
            navigationItem.rightBarButtonItem?.tintColor = .white
            view.overrideUserInterfaceStyle = .dark
            appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        } else {
            navigationController?.navigationBar.barTintColor = .black
            navigationItem.rightBarButtonItem?.tintColor = .black
            view.overrideUserInterfaceStyle = .light
            appearance.titleTextAttributes = [.foregroundColor: UIColor.black]
        }
        navigationItem.standardAppearance = appearance
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
        title = "Settings".localised()
        
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
    
    @objc
    private func languageChanged() {
        setupLocalizedText()
    }
    
    private func setupLocalizedText() {
        title = "Настройки".localised()
        settingData = [
            SettingsStruct(image: "language", title: "Language".localised(), type: .withButton, description: "English".localised()),
            SettingsStruct(image: "moon", title: "Choose Theme".localised(), type: .withSwitch, description: ""),
            SettingsStruct(image: "trash", title: "Clear data".localised(), type: .none, description: "")
        ]
        settingsTableView.reloadData()
        setupNavBar()
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
            let alertController = UIAlertController(title: "Delete?".localised(), message: "Are you sure you want to delete the notes?".localised(), preferredStyle: .alert)
            let acceptAction = UIAlertAction(title: "Yes".localised(), style: .cancel) { action in
                self.coreDataService.deleteAllNotes { response in
                    if response == .success {
                        let homeView = HomeView()
                        self.navigationController?.popViewController(animated: true)
                    } else {
                    }
                }
            }
            let declineAction = UIAlertAction(title: "No".localised(), style: .default) { action in
            }
            alertController.addAction(acceptAction)
            alertController.addAction(declineAction)
            present(alertController, animated: true)
        } else if indexPath.row == 0 {
            let languageView = LanguageController()
            languageView.delegate = self
            let multiplier = 0.30
            let customDetent = UISheetPresentationController.Detent.custom(resolver: { context in
                languageView.view.frame.height * multiplier
            })
            if let sheet = languageView.sheetPresentationController {
                sheet.detents = [customDetent, .medium()]
                sheet.prefersGrabberVisible = true
                self.present(languageView, animated: true)
            }
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
//        setupNavBar()
    }
}
extension SettingsController: LanguageViewDelegate {
    func didLanguageSelect(languageType: LanguageType) {
        updateSettingsLanguage()
        setupLocalizedText()
    }
    
    func didLanguageSelect() {
        setupLocalizedText()
        updateSettingsLanguage()
    }
}

