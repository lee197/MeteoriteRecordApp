//
//  MeteoriteListCell.swift
//  MeteoriteRecordApp
//
//  Created by 李祺 on 28/02/2020.
//  Copyright © 2020 Lee. All rights reserved.
//

import UIKit
class MeteoriteListCell: UITableViewCell {
    
    var meteoriteListCellViewModel : MeteoriteListCellViewModel? {
        didSet {
            nameLabel.text = meteoriteListCellViewModel?.titleText
            sizeLabel.text = meteoriteListCellViewModel?.sizeText
            dateLabel.text = meteoriteListCellViewModel?.dateText
        }
    }
    private var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }()
    
    private var sizeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textColor = .lightGray
        return label
    }()
    
    private var dateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.addSubview(nameLabel)
        self.addSubview(sizeLabel)
        self.addSubview(dateLabel)
        setNameLabelConstraints()
        setSizeLabelConstraints()
        setDataLabelConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
   private func setNameLabelConstraints() {
        let nameLabelConstraints = [
            nameLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            nameLabel.leftAnchor.constraint(equalTo: self.leftAnchor,constant: 20),
            nameLabel.heightAnchor.constraint(equalToConstant: 30)
        ]
        NSLayoutConstraint.activate(nameLabelConstraints)
    }
    
   private func setSizeLabelConstraints() {
        let sizeLabelConstraints = [
            sizeLabel.leftAnchor.constraint(equalTo: self.leftAnchor,constant: 20),
            sizeLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10),
            sizeLabel.heightAnchor.constraint(equalToConstant: 30)
        ]
        NSLayoutConstraint.activate(sizeLabelConstraints)
    }
    
   private func setDataLabelConstraints() {
        let dataLabelConstraints = [
            dateLabel.rightAnchor.constraint(equalTo: self.rightAnchor,constant: -20),
            dateLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            dateLabel.heightAnchor.constraint(equalToConstant: 30)
        ]
        NSLayoutConstraint.activate(dataLabelConstraints)
    }
}
