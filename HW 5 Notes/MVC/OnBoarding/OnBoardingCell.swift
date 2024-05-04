//
//  OnBoardingCell.swift
//  HW 5 Notes
//
//  Created by Rahilya Nazaralieva on 4/5/24.
//

import Foundation
import SnapKit
import UIKit

struct OnBoardingStruct {
    let image: String
    let title: String
    let description: String
}

class OnBoardingCell: UICollectionViewCell {
    
    static let reiseId = "onBoarding_cell"
    
    private lazy var descriptionLabel: UILabel = {
        let view = UILabel()
        view.numberOfLines = 0
        view.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        return view
    }()
    
    private lazy var titleLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont.systemFont(ofSize: 22, weight: .medium)
        return view
    }()
    
    private lazy var imageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        return view
    }()
    
    private lazy var conteinerView: UIView = {
        let view = UIView()
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        setupConstraints()
    }
    private func setupConstraints() {
        contentView.addSubview(conteinerView)
        conteinerView.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-335)
            make.horizontalEdges.equalToSuperview().inset(40) //
            make.height.equalTo(319)
        }
        conteinerView.addSubview(descriptionLabel)
        descriptionLabel.snp.makeConstraints { make in
            make.bottom.equalTo(conteinerView.snp.bottom)
            make.height.equalTo(80)
            make.width.equalTo(conteinerView.snp.width)
        }
        conteinerView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.bottom.equalTo(descriptionLabel.snp.top).offset(-16)
            make.centerX.equalTo(conteinerView)
            make.height.equalTo(31)
        }
        conteinerView.addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.bottom.equalTo(titleLabel.snp.top).offset(-52)
            make.width.equalTo(211)
            make.height.equalTo(140)
            make.centerX.equalTo(conteinerView)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func fill(onBoarding: OnBoardingStruct) {
        imageView.image = UIImage(named: onBoarding.image)
        titleLabel.text = onBoarding.title
        descriptionLabel.text = onBoarding.description
    }
}
