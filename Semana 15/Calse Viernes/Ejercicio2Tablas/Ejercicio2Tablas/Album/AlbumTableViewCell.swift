//
//  AlbumTableViewCell.swift
//  Ejercicio2Tablas
//
//  Created by Franco Ruiz on 21/11/25.
//

import UIKit

class AlbumTableViewCell: UITableViewCell {
    @IBOutlet weak var albumTitleLabel: UILabel!
    @IBOutlet weak var albumYearLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
