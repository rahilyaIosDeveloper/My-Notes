//
//  NoteCell.swift
//  HW 5 Notes
//
//  Created by Rahilya Nazaralieva on 27/4/24.
//

import Foundation
import UIKit

class NoteCell: UICollectionViewCell {
    
    static var reuseId = "note_cell"
                
    let colors: [UIColor] = [UIColor(hex: "#D9BBF9"),
                             UIColor(hex: "#D7F7F2"),
                             UIColor(hex: "#D7EDF8"),
                             UIColor(hex: "#FFF5E1") ]
    
    private lazy var titleLabel: UILabel = {
        let view = UILabel()
        view.textColor = .black
        return view
    }()
    
    private lazy var notesTextView: UITextView = {
        let view = UITextView()
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layer.cornerRadius = 10
        backgroundColor = colors.randomElement()
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        layer.cornerRadius = 10
        backgroundColor = colors.randomElement()
        setupConstraints()
    }

    private func setupConstraints() {
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(10)
            make.left.equalToSuperview().offset(10)
            make.height.equalTo(17)
            make.right.equalToSuperview().offset(-10)
        }
    }
    
    func fill(title: String) {
        titleLabel.text = title
      
    }
}
