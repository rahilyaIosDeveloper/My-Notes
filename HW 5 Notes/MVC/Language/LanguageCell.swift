//
//  LanguageView.swift
//  HW 5 Notes
//
//  Created by Rahilya Nazaralieva on 15/5/24.
//

import Foundation
import UIKit
import SnapKit

struct LanguageStruct {
    let image: String
    let title: String
}

class LanguageCell: UITableViewCell {
    
    static let reuseId = "language_cell"
    
    lazy var imageTable: UIImageView = {
        let view = UIImageView()
        return view
    }()
    
    lazy var titleTable: UILabel = {
        let view = UILabel()
        view.textColor = .black
        view.textAlignment = .center
        view.font = UIFont.systemFont(ofSize: 18)
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .secondarySystemBackground
        
        addSubview(imageTable)
        imageTable.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(16)
            make.height.width.equalTo(32)
        }
        
        addSubview(titleTable)
        titleTable.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
            make.leading.equalTo(imageTable.snp.trailing).offset(15)
            make.height.equalTo(24)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


