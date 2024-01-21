//
//  AutoSizeCollectionViewCell.swift
//  AutoSizeCollectionView
//
//  Created by Arjun Mohan on 21/01/24.
//

import UIKit

let cellIdentifier = "AutoSizeCollectionViewCell"

class AutoSizeCollectionViewCell: UICollectionViewCell {
    // MARK: - PROPERTIES
    lazy var cellLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        label.numberOfLines = 0
        label.textColor = .red
        label.lineBreakMode = .byWordWrapping
        label.setContentHuggingPriority(.defaultHigh, for: .vertical)
        label.backgroundColor = .clear
        return label
    }()
    
    // MARK: - LIFE CYCLE
    override init(frame: CGRect) {
        super.init(frame: frame)
        configUI()
    }
    
    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        let targetSize = CGSize(width: layoutAttributes.frame.width, height: 0)
        layoutAttributes.frame.size = contentView.systemLayoutSizeFitting(targetSize, withHorizontalFittingPriority: .required, verticalFittingPriority: .fittingSizeLevel)
        return layoutAttributes
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    // MARK: - CONFIG
    private func configUI() {
        backgroundColor = .clear
        contentView.backgroundColor = .systemTeal
        contentView.addSubview(cellLabel)
        NSLayoutConstraint.activate([
            cellLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0),
            cellLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0),
            cellLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0),
            cellLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            cellLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: cellLabel.intrinsicContentSize.height)
        ])
    }
    
    // MARK: - HELPERS
    func setupCell(text: String) {
        cellLabel.text = text
    }
}
