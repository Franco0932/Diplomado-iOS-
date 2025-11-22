//
//  BandTableViewCell.swift
//  Ejercicio2Tablas
//
//  Created by Franco Ruiz on 21/11/25.
//

import UIKit

class BandTableViewCell: UITableViewCell {
    @IBOutlet weak var bandImage: UIImageView!
    @IBOutlet weak var bandName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Redondear imagen (opcional)
        bandImage.layer.cornerRadius = bandImage.frame.height / 2
        bandImage.clipsToBounds = true
    }
}
