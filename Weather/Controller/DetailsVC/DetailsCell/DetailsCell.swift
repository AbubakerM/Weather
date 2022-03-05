//
//  DetailsCell.swift
//  Weather
//
//  Created by Mohammed Abubaker on 05/03/2022.
//

import UIKit

class DetailsCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setup(object: DetailsCellViewModel) {
        titleLabel.text = object.title
        valueLabel.text = object.value
    }
    
}
