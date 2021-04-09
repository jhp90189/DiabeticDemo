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
    private let selectedCategory = 0
    private var listHeightConstraint: NSLayoutConstraint? = nil

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
    
    var items: [String] = [] {
        didSet {
            updateListHeight()
            tipsHeaderView.reloadData()
        }
    }
    
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
        updateListHeight()
    }
    
    private func updateListHeight() {
        let numberOfRow = Int(Double(items.count) / 2.5)
        let height = CGFloat(numberOfRow * 50)
        if let heightConstraint = listHeightConstraint {
            heightConstraint.constant = height
        } else {
            listHeightConstraint = heightAnchor.constraint(equalToConstant: height)
            listHeightConstraint?.isActive = true
        }
    }
}

extension TabularHeaderview: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TabularViewCell", for: indexPath) as! TabularViewCell
        cell.isSelected = (indexPath.item == selectedCategory)
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
