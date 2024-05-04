//
//  OnBoardingView.swift
//  HW 5 Notes
//
//  Created by Rahilya Nazaralieva on 4/5/24.
//

import Foundation
import UIKit

class OnBoardingView: UIViewController {

    var currentPage = 0
    
    private let onBoardingData: [OnBoardingStruct] = [
        OnBoardingStruct(image: "swipeFirst",
                         title: "Welcome to The Note",
                         description: "Welcome to The Note – your new companion for tasks, goals, health – all in one place. Let's get started!"),
        OnBoardingStruct(image: "swipeSecond",
                         title: "Set Up Your Profile",
                         description: "Now that you're with us, let's get to know each other better. Fill out your profile, share your interests, and set your goals. "),
        OnBoardingStruct(image: "swipeThird",
                         title: "Dive into The Note",
                         description: "You're fully equipped to dive into the world of The Note. Remember, we're here to assist you every step of the way. Ready to start? Let's go!")]
    
    private lazy var onBoardingCV: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.register(OnBoardingCell.self, forCellWithReuseIdentifier: OnBoardingCell.reiseId)
        view.delegate = self
        view.dataSource = self
        view.isPagingEnabled = true
        view.showsHorizontalScrollIndicator = false
        return view
    }()
    
    private lazy var pageControl: UIPageControl = {
        let view = UIPageControl()
        view.currentPageIndicatorTintColor = .black
        view.pageIndicatorTintColor = .gray
        view.currentPage = 0
        view.numberOfPages = 3
        return view
    }()
    
    private lazy var skipButton: UIButton = {
        let view = UIButton(type: .system)
        view.setTitle("Skip", for: .normal)
        view.setTitleColor(.systemRed, for: .normal)
        view.addTarget(self, action: #selector(skipButtonTapped), for: .touchUpInside)
        return view
    }()
    
    private lazy var nextButton: UIButton = {
        let view = UIButton(type: .system)
        view.setTitle("Next", for: .normal)
        view.setTitleColor(.white, for: .normal)
        view.layer.cornerRadius = 20
        view.backgroundColor = UIColor(hex: "#FF3D3D")
        view.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
        return view
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupConstraints()
    }
    
    @objc func skipButtonTapped() {
        navigationController?.pushViewController(HomeView(), animated: true)
    }
    
    @objc func nextButtonTapped() {
        if currentPage == 2 {
            UserDefaults.standard.set(true, forKey: "onBoardShow")
            navigationController?.pushViewController(HomeView(), animated: true)
        } else {
            onBoardingCV.isPagingEnabled = false
            onBoardingCV.scrollToItem(at: IndexPath(row: currentPage + 1, section: 0), at: .centeredHorizontally, animated: true)
            onBoardingCV.isPagingEnabled = true
        }
    }
    
    private func setupNavBar() {
        
    }
    
    private func setupConstraints() {
        
        view.addSubview(onBoardingCV)
        onBoardingCV.snp.makeConstraints { make in
            make.bottom.equalTo(view.snp.bottom)
            make.width.equalTo(view.snp.width)
            make.top.equalToSuperview()
        }
        view.addSubview(pageControl)
        pageControl.snp.makeConstraints { make in
            make.bottom.equalTo(view.snp.bottom).offset(-205)
            make.centerX.equalToSuperview()
        }
        view.addSubview(skipButton)
        skipButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-133)
            make.leading.equalToSuperview().offset(16)
            make.height.equalTo(42)
            make.width.equalTo(173)
        }
        view.addSubview(nextButton)
        nextButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-133)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(42)
            make.width.equalTo(173)
        }
    }
}

extension OnBoardingView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        onBoardingData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OnBoardingCell.reiseId,
                                                      for: indexPath) as! OnBoardingCell
        cell.fill(onBoarding: onBoardingData[indexPath.row])
        return cell
    }
}

extension OnBoardingView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let contentOffset = scrollView.contentOffset.x
        
        let page = Int(round(contentOffset / view.frame.width))
        currentPage = max(0, min(page, onBoardingData.count - 1))
          pageControl.currentPage = currentPage
        
        switch page {
        case 0:
            pageControl.currentPage = 0
            currentPage = 0
            print("Первая стр")
        case 1:
            currentPage = 1
            pageControl.currentPage = 1
            print("Вторая стр")
        case 2:
            currentPage = 2
            pageControl.currentPage = 2
            print("Третья стр")
        default:
            ()
        }
    }
}
