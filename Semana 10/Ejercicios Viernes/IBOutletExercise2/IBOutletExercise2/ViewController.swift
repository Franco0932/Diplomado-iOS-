//
//  ViewController.swift
//  IBOutletExercise2
//
//  Created by Franco Ruiz on 17/10/25.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var redSlider: UISlider!
    @IBOutlet weak var greenSlider: UISlider!
    @IBOutlet weak var blueSlider: UISlider!

    @IBOutlet weak var redValueLabel: UILabel!
    @IBOutlet weak var greenValueLabel: UILabel!
    @IBOutlet weak var blueValueLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        updateBackgroundColor()
    }
    
    @IBAction func RsliderDidChange(_ sender: Any) {
        updateBackgroundColor()
    }
    @IBAction func GsliderDidChange(_ sender: Any) {
        updateBackgroundColor()
    }
    @IBAction func BsliderDidChange(_ sender: Any) {
        updateBackgroundColor()
    }

    @IBAction func resetColorButtonTapped(_ sender: Any) {
        redSlider.value = 0.0
        greenSlider.value = 0.0
        blueSlider.value = 0.0
        updateBackgroundColor()
    }

    func updateBackgroundColor() {
        let red = redSlider.value
        let green = greenSlider.value
        let blue = blueSlider.value

        let redForLabel = red * 255
        let greenForLabel = green * 255
        let blueForLabel = blue * 255
            
        redValueLabel.text = String(format: "%.0f", redForLabel)
        greenValueLabel.text = String(format: "%.0f", greenForLabel)
        blueValueLabel.text = String(format: "%.0f", blueForLabel)
        view.backgroundColor = UIColor(red: CGFloat(red), green: CGFloat(green), blue: CGFloat(blue), alpha: 1.0)
    }

}
