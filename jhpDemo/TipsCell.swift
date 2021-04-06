//
//  TipsCell.swift
//  DiabeticDemo
//
//  Created by Apple on 02/04/21.
//

import UIKit

protocol TipsCellDelegate: class {
    func didUpdateCellLayout(cell: TipsCell, isCollapsed: Bool)
}

let MaxNumberOfCharacters = 250

struct TipsCellModel {
    let title: String
    let subtitle: String
    var isCollapsed: Bool
    var isReadMoreRequired: Bool {
        return subtitle.count > MaxNumberOfCharacters
    }
}

class TipsCell: UICollectionViewCell {
    
    private let horizontalMargin: CGFloat = 20
    private let iconSize: CGFloat = 25
    private var subtitleHeightConstraint: NSLayoutConstraint? = nil
    private var originalSubtitle: String = ""
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
    
    lazy var subtitleLabel: UITextView = {
        let label = UITextView()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14)
        label.isEditable = false
        label.isUserInteractionEnabled = true
        label.isSelectable = true
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
    
    private lazy var likeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "like")
        return imageView
    }()
    
    private lazy var dislikeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "dislike")
        return imageView
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
        return imageView
    }()
    
    private let readMoreText = "...Read more"
    private let readLessText = "...Read less"
    
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

        footerStackView.addArrangedSubview(likeImageView)
        footerStackView.addArrangedSubview(dislikeImageView)
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
            heartImageView.heightAnchor.constraint(equalToConstant: iconSize),
            
        ])
        subtitleHeightConstraint = subtitleLabel.heightAnchor.constraint(equalToConstant: 0)
        subtitleHeightConstraint?.isActive = true
        contentView.layer.borderWidth = 2.0
        contentView.layer.borderColor = UIColor.darkGray.cgColor
        contentView.layer.cornerRadius = 15.0
        subtitleLabel.delegate = self
    }
    
    func updateDetails(model: TipsCellModel) {
        titleLabel.text = model.title
        if originalSubtitle.isEmpty {
            originalSubtitle = model.subtitle
            let bodyText = originalSubtitle
            subtitleLabel.attributedText = NSAttributedString(string: bodyText)
            if model.isReadMoreRequired {  checkForReadMore() }
        } else {
            if model.isReadMoreRequired {
                toggleSubtitleText(isReadMore: model.isCollapsed)
            }
        }
        subtitleHeightConstraint?.constant = (subtitleLabel.attributedText.string as NSString).size(withAttributes: [NSAttributedString.Key.font : subtitleLabel.font as Any]).height + 20
    }
    
    private func toggleSubtitleText(isReadMore: Bool) {
        if isReadMore {
            subtitleLabel.attributedText = NSAttributedString(string: originalSubtitle)
            appendLinkTextToSubtitle(text: readLessText)
        } else {
            subtitleLabel.attributedText = NSMutableAttributedString(string: String(originalSubtitle.prefix(MaxNumberOfCharacters - readMoreText.count)))
            appendLinkTextToSubtitle(text: readMoreText)
        }
    }
    
    private func checkForReadMore() {
        if let subTitleText = subtitleLabel.attributedText, subTitleText.string.count > MaxNumberOfCharacters {
            subtitleLabel.attributedText = NSMutableAttributedString(string: String(subTitleText.string.prefix(MaxNumberOfCharacters - readMoreText.count)))
            appendLinkTextToSubtitle(text: readMoreText)
        }
       
    }
    
    private func appendLinkTextToSubtitle(text: String) {
        guard let subTitleText = subtitleLabel.attributedText else { return }
        let attributedText = NSMutableAttributedString(attributedString: subTitleText)
        attributedText.append(NSAttributedString(string: text))
        subtitleLabel.attributedText = attributedText
        addLinkAttributes(originalText: subtitleLabel.attributedText.string)
    }

    private func addLinkAttributes(originalText: String) {
        subtitleLabel.hyperLink(originalText: originalText, linkTextsAndTypes: [readMoreText: "readmoreURL", readLessText : "readlessURL"])
    }
}

extension TipsCell: UITextViewDelegate {
    func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
        if URL.absoluteString == "readmoreURL" {
            delegate?.didUpdateCellLayout(cell: self, isCollapsed: true)
        } else if URL.absoluteString == "readlessURL" {
            delegate?.didUpdateCellLayout(cell: self, isCollapsed: false)
        }
        return false
    }
}
