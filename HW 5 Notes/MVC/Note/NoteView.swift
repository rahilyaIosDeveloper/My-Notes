//
//  NoteView.swift
//  HW 5 Notes
//
//  Created by Rahilya Nazaralieva on 8/5/24.
//

import Foundation
import UIKit
import SnapKit

protocol NoteViewProtocol: AnyObject {
}


class NoteView: UIViewController {
    
    weak var delegate: NoteViewProtocol?
 
    private let coreDataService = CoreDataService.shared
    
    private var colors: [UIColor] = [.systemPink, .cyan, .systemOrange, .systemPurple]
    
    private lazy var titleTextField: UITextField = {
        let view = UITextField()
        view.placeholder = "Title"
        view.layer.borderWidth = 1
        view.layer.cornerRadius = 16
        return view
    }()
    
    private lazy var descriptionTextView: UITextView = {
        let view = UITextView()
        view.layer.cornerRadius = 14
        view.backgroundColor = UIColor(hex: "#EEEEEF")
        return view
    }()
    
    private lazy var saveButton: UIButton = {
        let view = UIButton(type: .system)
        view.setTitle("Сохранить", for: .normal)
        view.tintColor = .white
        view.backgroundColor = .systemPink
        view.layer.cornerRadius = 44 / 2
        view.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
        return view
    }()
    
    private lazy var copyButton: UIButton = {
        let view = UIButton(type: .system)
        view.setImage(UIImage(named: "copy"), for: .normal)
        view.tintColor = .lightGray
        view.addTarget(self, action: #selector(copyButtonTapped), for: .touchUpInside)
        return  view
    }()
    
    private func setupNavigationItem() {
        title = "NoteView"
        let rightBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "gear"),
            style: .plain,
            target: self,
            action: #selector(settingsButtonTapped))
        navigationItem.rightBarButtonItem = rightBarButtonItem
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupConstraints()
        setupNavigationItem()
    }
    
    @objc func saveButtonTapped() {
        let id = UUID().uuidString
        print(id)
        let date = Date()
        let color = generateColor()
        coreDataService.addNote(id: id, title: titleTextField.text ?? "", description: descriptionTextView.text ?? "", date: date, color: color)
    }
    
        @objc func copyButtonTapped() {
    }
    
    @objc func settingsButtonTapped() {
        let vc = SettingsController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    private func generateColor() -> String {
        let color = colors.randomElement()
        print(color)
        switch color! {
        case .systemPink:
            return "pink"
        case .cyan:
            return "cyan"
        case .systemOrange:
            return "orange"
        case .systemPurple:
            return "purple"
        default:
            return ""
        }
    }
    
    private func setupConstraints() {
        view.addSubview(titleTextField)
        titleTextField.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(104)
            make.left.equalToSuperview().offset(18)
            make.right.equalToSuperview().offset(-25)
            make.height.equalTo(34)
        }
        
        view.addSubview(descriptionTextView)
        descriptionTextView.snp.makeConstraints { make in
            make.top.equalTo(titleTextField.snp.bottom).offset(26)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.bottom.equalToSuperview().offset(-207)
        }
        
        view.addSubview(saveButton)
        saveButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-60)
            make.centerX.equalToSuperview()
            make.width.equalTo(347)
            make.height.equalTo(42)
        }
        
        view.addSubview(copyButton)
        copyButton.snp.makeConstraints { make in
            make.bottom.equalTo(descriptionTextView.snp.bottom).offset(-12)
            make.trailing.equalTo(descriptionTextView.snp.trailing).offset(-15)
            make.height.width.equalTo(32)
        }
    }
}
