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
    func successSave()
    func failuresave()
    func successDelete()
    func failureDelete()
    func successUpdateNote()
}


class NoteView: UIViewController {
    
    private let coreDataService = CoreDataService.shared
    
    weak var delegate: NoteViewProtocol?
    
    private var controller: NoteControllerProtocol?
    
    var note: Note?
    
    private var colors: [UIColor] = [.systemPink, .cyan, .systemOrange, .systemPurple]
    
    private lazy var titleTextField: UITextField = {
        let view = UITextField()
        view.placeholder = "Title"
        view.layer.borderWidth = 1
        view.layer.cornerRadius = 12
        view.placeholder = "Название"
        let spacerView = UIView(frame: CGRect(x: 0, y: 0, width: 12, height: 0))
        view.leftView = spacerView
        view.leftViewMode = .always
        return view
    }()
    
    private lazy var descriptionTextView: UITextView = {
        let view = UITextView()
        view.layer.cornerRadius = 10
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
        return view
    }()
    
    private func setupNavigationItem() {
        let rightBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "trash"),
            style: .plain,
            target: self,
            action: #selector(deleteButtonTapped))
        navigationItem.rightBarButtonItem = rightBarButtonItem
    }
    
    private lazy var dateLabel: UILabel = {
        let view = UILabel()
        view.textAlignment = .right
        return view
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        controller = NoteController(view: self)
        setupConstraints()
        setupNavigationItem()
        setupData()
    }
    
    @objc func saveButtonTapped() {
        let color = generateColor()
        
        
        guard let title = titleTextField.text, let description = descriptionTextView.text else {
            return
        }
        if !title.isEmpty && !description.isEmpty {
            controller?.onAddNote(title: titleTextField.text ?? "", description: description, color: color)
        }
}
    
    func setupData() {
        guard let note = note else {
            return
        }
        titleTextField.text = note.title
        descriptionTextView.text = note.desc
        
        let date = note.date
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let dateString = dateFormatter.string(from: date ?? Date())
        
        dateLabel.text = dateString
    }
    
    
    @objc func deleteButtonTapped() {
        guard let note = note, let id = note.id else {
            return
        }
        coreDataService.delete(id: id) { response in
            if response == .success {
                self.controller?.onSuccessDelete()
            } else {
                self.controller?.onFailureDelete()
            }
        }
    }
        

    
        @objc func copyButtonTapped() {
    }
    
    @objc func settingsButtonTapped() {
        let vc = SettingsController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    private func generateColor() -> String {
        let color = colors.randomElement()
        print(color!)
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
        
        view.addSubview(dateLabel)
        dateLabel.snp.makeConstraints { make in
            make.right.equalTo(descriptionTextView.snp.right)
            make.top.equalTo(descriptionTextView.snp.bottom).offset(5)
            make.width.equalToSuperview()
            make.height.equalTo(20)
        }
    }
}

extension NoteView: NoteViewProtocol {
    func successSave() {
        navigationController?.popViewController(animated: true)
    }
    
    func failuresave() {
        let alert = UIAlertController(title: "Ошибка", message: "Не удалось сохранить заметку, повторите попытку заново!", preferredStyle: .alert)
        let acceptAlert = UIAlertAction(title: "Ок", style: .cancel)
        alert.addAction(acceptAlert)
        present(alert, animated: true)
    }
    func successDelete() {
        navigationController?.popViewController(animated: true)
    }
    func failureDelete() {
        let alert = UIAlertController(title: "Ошибка", message: "Не удалось удалить заметку", preferredStyle: .alert)
        let acceptAlert = UIAlertAction(title: "Назад", style: .destructive)
        alert.addAction(acceptAlert)
        present(alert, animated: true)
    }
    func successUpdateNote() {
        navigationController?.popViewController(animated: true)
    }
    
}
