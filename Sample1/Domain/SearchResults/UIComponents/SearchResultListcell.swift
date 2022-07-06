//
//  SearchResultListcell.swift
//  Sample1
//
//  Created by Nitin Upadhyay on 04/07/22.
//

import UIKit

class SearchResultListcell: BaseCollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    var typeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        label.numberOfLines = 0

        return label
    }()
    
    private func setupViews() {
        addSubview(label)
        addSubview(typeLabel)
        addSubview(imageView)
        imageView.addSubview(loader)
        setUpConstraints()
    }

    private func setUpConstraints() {
        var constraints = [NSLayoutConstraint]()
        
        constraints.append(imageView.topAnchor.constraint(equalTo: contentView.topAnchor))
        constraints.append(imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor))
        constraints.append(imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor))
        constraints.append(imageView.widthAnchor.constraint(equalToConstant: 60))
        
        constraints.append(typeLabel.topAnchor.constraint(equalTo: imageView.topAnchor))
        constraints.append(typeLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 8))
        constraints.append(typeLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8))
        constraints.append(typeLabel.heightAnchor.constraint(equalToConstant: 14))
        typeLabel.setContentCompressionResistancePriority(.defaultHigh, for: .vertical)
        
        constraints.append(label.topAnchor.constraint(equalTo: typeLabel.bottomAnchor, constant: 8))
        constraints.append(label.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8))
        constraints.append(label.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 8))
        constraints.append(label.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8))
        
        
        constraints.append(loader.centerXAnchor.constraint(equalTo: imageView.centerXAnchor))
        constraints.append(loader.centerYAnchor.constraint(equalTo: imageView.centerYAnchor))
        
        label.setContentCompressionResistancePriority(.defaultLow, for: .vertical)
        NSLayoutConstraint.activate(constraints)
    }
    
    override func updateWith(viewModel: RailItem, imageFetcher: ImageFetcher) {
        super.updateWith(viewModel: viewModel, imageFetcher: imageFetcher)
        typeLabel.text = "Type: \(viewModel.kind)"
    }
}
