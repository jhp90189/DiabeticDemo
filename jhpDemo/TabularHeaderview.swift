//
//  TabularHeaderview.swift
//  DiabeticDemo
//
//  Created by Apple on 02/04/21.
//

import UIKit

class TabularHeaderview: UIView {
    
    private let verticalMargin: CGFloat = 10.0
    private let horizontalMargin: CGFloat = 5.0

    private lazy var tipsHeaderView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = verticalMargin
        layout.minimumInteritemSpacing = verticalMargin
        layout.sectionInset = UIEdgeInsets(top: verticalMargin, left: horizontalMargin, bottom: verticalMargin, right: horizontalMargin)
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
        collectionView.register(TabularViewCell.self, forCellWithReuseIdentifier: "TabularViewCell")
        return collectionView
    }()
    
    let items = ["Tips of the day", "Insulin", "Healthy Meal", "Category4","Tips of the day",]
    
    private var selectedIndexpath: IndexPath? = nil

    public init() {
        super.init(frame: .zero)
        setupSubViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupSubViews() {
        addSubview(tipsHeaderView)
        NSLayoutConstraint.activate([
            tipsHeaderView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            tipsHeaderView.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor),
            tipsHeaderView.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor),
            tipsHeaderView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
        ])
        tipsHeaderView.delegate = self
        tipsHeaderView.dataSource = self
        let numberOfRow = Double(items.count) / 2.5
        heightAnchor.constraint(equalToConstant: CGFloat(numberOfRow * 55)).isActive = true
    }
}

extension TabularHeaderview: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TabularViewCell", for: indexPath) as! TabularViewCell
        cell.titleLabel.text = items[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        cell?.isSelected = true
        if let oldIndex = selectedIndexpath {
            let oldCell = collectionView.cellForItem(at: oldIndex)
            oldCell?.isSelected = false
        }
        selectedIndexpath = indexPath
    }
}
