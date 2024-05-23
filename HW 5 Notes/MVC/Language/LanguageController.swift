//
//  LanguageController.swift
//  HW 5 Notes
//
//  Created by Rahilya Nazaralieva on 15/5/24.
//

import Foundation
import UIKit
import SnapKit

protocol LanguageViewDelegate: AnyObject {
    func didLanguageSelect(languageType: LanguageType)
}

class LanguageController: UIViewController {
    
   weak var delegate: LanguageViewDelegate?
    
    lazy var mainLabel: UILabel = {
        let view = UILabel()
        view.font = .systemFont(ofSize: 22, weight: .bold)
        return view
    }()
    
    
    private lazy var languageTableView: UITableView = {
        let view = UITableView()
        view.delegate = self
        view.dataSource = self
        view.layer.cornerRadius = 10
        view.register(LanguageCell.self, forCellReuseIdentifier: LanguageCell.reuseId)
        return view
    }()
    
    private var someLanguage: [LanguageStruct] = [LanguageStruct(image: "kg_flag", title: "Кыргызча", languageType: .kg),
                                                  LanguageStruct(image: "rus_flag", title: "Русский", languageType: .ru), LanguageStruct(image: "usa_flag", title: "English", languageType: .en)]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupLocalizedText()
        if UserDefaults.standard.bool(forKey: "theme") == true {
            view.overrideUserInterfaceStyle = .dark
        } else {
            view.overrideUserInterfaceStyle = .light
        }
        
        
        view.addSubview(mainLabel)
        mainLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.horizontalEdges.equalToSuperview().inset(16)
        }
        
        view.addSubview(languageTableView)
        languageTableView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(80)
            make.height.equalTo(160)
            make.horizontalEdges.equalToSuperview().inset(12)
        }
    }
    func setupLocalizedText() {
        mainLabel.text = "Choose language".localised()
    }
}

extension LanguageController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return someLanguage.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: LanguageCell.reuseId, for: indexPath) as! LanguageCell
        let language = someLanguage[indexPath.row]
        cell.imageTable.image = UIImage(named: language.image)
        cell.titleTable.text = language.title
        cell.titleTable.textColor = UserDefaults.standard.bool(forKey: "theme") ? .white : .black
        cell.backgroundColor = .clear
        cell.selectionStyle = .none
        return cell
    }
}

extension LanguageController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 55
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let languageType = someLanguage[indexPath.row].languageType
        AppLanguageManager.shared.setAppLanguage(languageType: languageType)
        UserDefaults.standard.set(languageType.rawValue, forKey: "selectedLanguage")
        setupLocalizedText()
        delegate?.didLanguageSelect(languageType: languageType)
    }
}
