//
//  SongTableViewCell.swift
//  Ejercicio2Tablas
//
//  Created by Franco Ruiz on 21/11/25.
//

import UIKit

class SongTableViewCell: UITableViewCell {
    @IBOutlet weak var songNameLabel: UILabel!
    @IBOutlet weak var durationLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
