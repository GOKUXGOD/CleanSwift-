//
//  SearchResultsCell.swift
//  Sample1
//
//  Created by Nitin Upadhyay on 03/07/22.
//

import UIKit

class SearchResultsCell: BaseCollectionViewCell {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    func setupViews() {
        contentView.addSubview(imageView)
        contentView.addSubview(label)
        contentView.addSubview(loader)
    
        setupConstraints()
    }

    func setupConstraints() {
        var constraints = [NSLayoutConstraint]()
        
        constraints.append(imageView.topAnchor.constraint(equalTo: contentView.topAnchor))
        constraints.append(imageView.heightAnchor.constraint(equalToConstant: 100))
        constraints.append(imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor))
        constraints.append(imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor))
        
        constraints.append(label.bottomAnchor.constraint(equalTo: contentView.bottomAnchor))
        constraints.append(label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor))
        constraints.append(label.trailingAnchor.constraint(equalTo: contentView.trailingAnchor))
        constraints.append(label.topAnchor.constraint(equalTo: imageView.bottomAnchor))
        
        constraints.append(loader.centerXAnchor.constraint(equalTo: imageView.centerXAnchor))
        constraints.append(loader.centerYAnchor.constraint(equalTo: imageView.centerYAnchor))
        NSLayoutConstraint.activate(constraints)
    }
}
