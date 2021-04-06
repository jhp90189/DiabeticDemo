//
//  TabularViewCell.swift
//  DiabeticDemo
//
//  Created by Apple on 02/04/21.
//

import UIKit

class TabularViewCell: UICollectionViewCell {
    
    private lazy var containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .blue
        return label
    }()
    
    private let horizontalMargin: CGFloat = 20
    private let verticalMargin: CGFloat = 10
    
    override var isSelected: Bool {
        didSet {
            self.updateSelection()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
    }
    
    private func setupViews() {
        containerView.addSubview(titleLabel)
        contentView.addSubview(containerView)
        contentView.layer.cornerRadius = 18
        contentView.layer.borderWidth = 2.0
        contentView.layer.borderColor = UIColor.blue.cgColor
    }
    
    private func updateSelection() {
        titleLabel.textColor = isSelected ? .white : .blue
        contentView.backgroundColor = isSelected ? .blue : .clear
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: verticalMargin),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: horizontalMargin),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -horizontalMargin),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -verticalMargin),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
