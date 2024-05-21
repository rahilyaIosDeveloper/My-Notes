//
//  SettingsView.swift
//  HW 5 Notes
//
//  Created by Rahilya Nazaralieva on 29/4/24.
//

import Foundation
import UIKit

protocol SettingsDelegate: AnyObject {
    func didChangeTheme(isOn: Bool)
    func navigateToNextController()
}

struct SettingsStruct {
    let image: String
    let title: String
    let type: SettingsCellType
    let description: String
}

enum SettingsCellType {
    case withSwitch
    case withButton
    case none
}

class SettingsCell: UITableViewCell {
    
    static let reuseId = String(describing: SettingsCell.self)
    
    private lazy var imageTable: UIImageView = {
        let view = UIImageView()
        view.tintColor = .label
        return view
    }()
    
    private lazy var lableTable: UILabel = {
        let view = UILabel()
        view.tintColor = .label
        view.font = UIFont.systemFont(ofSize: 18)
        return view
    }()
    
    
    private lazy var switchTable: UISwitch = {
        let view =  UISwitch()
        view.addTarget(self, action: #selector(changeTheme), for: .touchUpInside)
        return view
    }()
    
    
    private lazy var buttonTable: UIButton = {
        let view = UIButton()
        view.setImage(
            UIImage(systemName: "chevron.compact.right"),
            for: .normal)
        view.tintColor = .label
        view.addTarget(self, action: #selector(buttonTableTapped(sender:)), for: .touchUpInside)
        return view
    }()
    
    
    private lazy var lableLanguage: UILabel = {
        let view = UILabel()
        return view
    }()
    
 
    weak var delegate: SettingsDelegate?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
       contentView.backgroundColor = .secondarySystemBackground

        addSubview(imageTable)
        imageTable.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(16)
            make.height.width.equalTo(22)
        }
        addSubview(lableTable)
        lableTable.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(imageTable.snp.trailing).offset(15)
            make.height.equalTo(24)
        }
        
        addSubview(lableLanguage)
        lableLanguage.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalTo(-35)
        }
        contentView.addSubview(buttonTable)
        buttonTable.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.height.equalTo(13.8)
            make.width.equalTo(8)
            make.trailing.equalTo(-16)
        }
        contentView.addSubview(switchTable)
        switchTable.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.width.equalTo(51)
            make.height.equalTo(31)
            make.trailing.equalToSuperview().offset(-26)
        }
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func didSelect() {
        lableTable.font = UIFont.systemFont(ofSize: 17)
        lableLanguage.font = UIFont.systemFont(ofSize: 17)
        imageTable.snp.remakeConstraints { make in
            make.width.height.equalTo(20)
            make.centerY.equalToSuperview()
            make.leading.equalTo(16)
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.lableTable.font = UIFont.systemFont(ofSize: 18)
            self.lableLanguage.font = UIFont.systemFont(ofSize: 18)
            self.imageTable.snp.remakeConstraints { make in
                make.width.height.equalTo(24)
                make.centerY.equalToSuperview()
                make.leading.equalTo(16)
            }
        }
    }
    
    func fill(with: SettingsStruct) {
        imageTable.image = UIImage(named: with.image)?.withRenderingMode(.alwaysTemplate)
        lableTable.text = with.title
        lableLanguage.text = with.description
        buttonTable.setTitle(with.description, for: .normal)
        switch with.type {
        case .withSwitch:
            if UserDefaults.standard.bool(forKey: "theme") == true {
                switchTable.isOn = true
            } else {
                switchTable.isOn = false
            }
            buttonTable.isHidden = true
            switchTable.isHidden = false
        case .withButton:
            switchTable.isHidden = true
            buttonTable.isHidden = false
        case .none:
            switchTable.isHidden = true
            buttonTable.isHidden = true
        }
    }
    
    @objc private func changeTheme(sender: UISwitch) {
        delegate?.didChangeTheme(isOn: switchTable.isOn)
    }
    @objc private func buttonTableTapped(sender: UIButton) {
        delegate?.navigateToNextController()
    }
}



