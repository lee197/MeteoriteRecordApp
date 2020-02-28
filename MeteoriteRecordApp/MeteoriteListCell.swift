//
//  MeteoriteListCell.swift
//  MeteoriteRecordApp
//
//  Created by 李祺 on 28/02/2020.
//  Copyright © 2020 Lee. All rights reserved.
//

import UIKit
class MeteoriteListCell: UITableViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var sizeLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    var meteoriteListCellViewModel : MeteoriteListCellViewModel? {
        didSet {
            nameLabel.text = meteoriteListCellViewModel?.titleText
            sizeLabel.text = meteoriteListCellViewModel?.sizeText
            dateLabel.text = meteoriteListCellViewModel?.dateText
        }
    }
}
