//
//  SectionHeader.swift
//  Sample1
//
//  Created by Nitin Upadhyay on 03/07/22.
//

import UIKit

class SectionHeader: UICollectionReusableView {
    var label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
    
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(label)
        var constraints = [NSLayoutConstraint]()
        constraints.append(label.topAnchor.constraint(equalTo: topAnchor))
        constraints.append(label.bottomAnchor.constraint(equalTo: bottomAnchor))
        constraints.append(label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8))
        constraints.append(label.trailingAnchor.constraint(equalTo: trailingAnchor))

        NSLayoutConstraint.activate(constraints)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
