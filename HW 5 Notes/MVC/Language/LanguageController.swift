//
//  LanguageController.swift
//  HW 5 Notes
//
//  Created by Rahilya Nazaralieva on 15/5/24.
//

import Foundation
import UIKit
import SnapKit

class LanguageController: UIViewController {
    
    lazy var mainLabel: UILabel = {
        let view = UILabel()
        view.text = "Выберите язык"
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
    
    private var someLanguage: [LanguageStruct] = [LanguageStruct(image: "kg_flag", title: "Кыргызча"),
                                                  LanguageStruct(image: "rus_flag", title: "Русский"), LanguageStruct(image: "usa_flag", title: "English")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        
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
        cell.backgroundColor = .clear
        cell.selectionStyle = .none
        return cell
    }

}
extension LanguageController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 55
    }
}
