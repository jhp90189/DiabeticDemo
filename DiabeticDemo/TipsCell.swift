//
//  TipsCell.swift
//  DiabeticDemo
//
//  Created by Apple on 02/04/21.
//

import UIKit

protocol TipsCellDelegate: class {
    func didLikeClick(cell: TipsCell)
    func didDislikeClick(cell: TipsCell)
    func didSaveClick(cell: TipsCell)
}

struct TipsCellModel {
    let title: String
    let subtitle: String
    var isliked: Bool
    var isDisliked: Bool
    var isSaved: Bool
}

class TipsCell: UICollectionViewCell {
    
    private let horizontalMargin: CGFloat = 20
    private let iconSize: CGFloat = 25
    weak public var delegate: TipsCellDelegate? = nil
    
    private lazy var containerStackView: UIStackView = {
       let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = horizontalMargin
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = UIEdgeInsets(top: horizontalMargin, left: horizontalMargin, bottom: horizontalMargin, right: horizontalMargin)
        return stackView
    }()

    private lazy var tipImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "Tip-placeholder")
        return imageView
    }()

    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.numberOfLines = 0
        return label
    }()
    
    lazy var subtitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14)
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var separatorView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .separator
        return view
    }()
    
    private lazy var footerStackView: UIStackView = {
       let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var likeStackView: UIStackView = {
       let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 2
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.addArrangedSubview(likeImageView)
        stackView.addArrangedSubview(likeLabel)
        stackView.isUserInteractionEnabled = true
        stackView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(likeButtonTapped)))
        return stackView
    }()
    
    lazy var likeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.text = "Like"
        return label
    }()
    
    private lazy var likeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "like")
        return imageView
    }()
    
    private lazy var dislikeStackView: UIStackView = {
       let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 2
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.addArrangedSubview(dislikeImageView)
        stackView.addArrangedSubview(dislikeLabel)
        stackView.isUserInteractionEnabled = true
        stackView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(dislikeButtonTapped)))
        return stackView
    }()
    
    private lazy var dislikeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "dislike")
        return imageView
    }()
    
    lazy var dislikeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.text = "Dislike"
        return label
    }()
    
    private lazy var spacerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        view.setContentHuggingPriority(.defaultLow, for: .horizontal)
        return view
    }()
    
    private lazy var heartImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "heart")
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(saveButtonTapped)))
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        contentView.addSubview(containerStackView)
        containerStackView.addArrangedSubview(tipImageView)
        containerStackView.addArrangedSubview(titleLabel)
        containerStackView.addArrangedSubview(subtitleLabel)
        containerStackView.addArrangedSubview(separatorView)
        containerStackView.addArrangedSubview(footerStackView)

        footerStackView.addArrangedSubview(likeStackView)
        footerStackView.addArrangedSubview(dislikeStackView)
        footerStackView.addArrangedSubview(spacerView)
        footerStackView.addArrangedSubview(heartImageView)
        
        let screenWidth = UIScreen.main.bounds.size.width
        
        NSLayoutConstraint.activate([
            containerStackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            containerStackView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            containerStackView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            containerStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            separatorView.heightAnchor.constraint(equalToConstant: 1),
            
            tipImageView.widthAnchor.constraint(equalToConstant: screenWidth - 70),
            tipImageView.heightAnchor.constraint(equalToConstant: 150),
            
            likeImageView.widthAnchor.constraint(equalToConstant: iconSize),
            likeImageView.heightAnchor.constraint(equalToConstant: iconSize),
            
            dislikeImageView.widthAnchor.constraint(equalToConstant: iconSize),
            dislikeImageView.heightAnchor.constraint(equalToConstant: iconSize),
            
            heartImageView.widthAnchor.constraint(equalToConstant: iconSize),
            heartImageView.heightAnchor.constraint(equalToConstant: iconSize)
        ])
        contentView.layer.borderWidth = 2.0
        contentView.layer.borderColor = UIColor.darkGray.cgColor
        contentView.layer.cornerRadius = 15.0
    }
    
    @objc func likeButtonTapped() {
        delegate?.didLikeClick(cell: self)
    }
    
    @objc func dislikeButtonTapped() {
        delegate?.didDislikeClick(cell: self)
    }
    
    @objc func saveButtonTapped() {
        delegate?.didSaveClick(cell: self)
    }
    
    func updateDetails(model: TipsCellModel) {
        titleLabel.text = model.title
        subtitleLabel.text = model.subtitle
        likeImageView.image = model.isliked ? UIImage(named: "like_active") : UIImage(named: "like_inactive") // put active/inactive image accordingly
        dislikeImageView.image = UIImage(named: model.isDisliked ? "dislike_active" : "dislike_inactive")
        heartImageView.image = model.isSaved ? UIImage(named: "heart_active") : UIImage(named: "heart_inactive") // put active/inactive image accordingly
    }
}
