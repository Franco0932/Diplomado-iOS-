//
//  HomeViewController.swift
//  AppModulo
//
//  Created by Franco Ruiz on 11/10/25.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var imageType: UISwitch!
    @IBOutlet weak var captionSwitch: UISwitch!
    @IBOutlet weak var captionTextSwitch: UISwitch!
    @IBOutlet weak var customTextFields: UITextView!{
        didSet{
            customTextFields.delegate = self
        }
    }
    @IBOutlet weak var picsButton: UIButton!


    override func viewDidLoad() {
        super.viewDidLoad()
        picsButton.setImage(UIImage(systemName: imageType.isOn ? "dog.fill" : "cat.fill"), for: .normal)
        
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let feedViewController = segue.destination as? FeedViewController{
            feedViewController.pictureType = imageType.isOn ? .dog : .cat
            feedViewController.showCaption = captionSwitch.isOn
            customTextFields.isEditable = captionSwitch.isOn
        }else if segue.identifier == "HomeInformationSegue", let informationViewController = segue.destination as? InformationViewController {
            
            if captionTextSwitch.isOn {
                informationViewController.informationText = customTextFields.text
            }
        }
    }
    
    @IBAction func picsButtonTapped(_ sender: Any){
        
    }
    
    @IBAction func logOutButtonTapped(_ sender: Any){
        self.navigationController?.dismiss(animated: true)
    }
    
    @IBAction func informationButtonTapped(_ sender: Any){
        if captionTextSwitch.isOn{
            if customTextFields.text != "" {
                performSegue(withIdentifier: "HomeInformationSegue", sender: nil)
            }else{
                let alertController = UIAlertController(title: nil, message: "Add Custom Text", preferredStyle: .alert)
                alertController.addAction(UIAlertAction(title: "OK", style: .cancel))
                present(alertController, animated: true)
            }
        }else{
            performSegue(withIdentifier: "HomeInformationSegue", sender: nil)
        }
    }
    
    @IBAction func imageTypeSwitchValueChanged(_ sender: UISwitch){
        picsButton.setImage(UIImage(systemName: imageType.isOn ? "dog.fill" : "cat.fill"), for: .normal)
    }
    
    @IBAction func captionTypeSwitchValueChanged(_ sender: UISwitch){
        customTextFields.isEditable = sender.isOn
    }

}

extension HomeViewController: UITextViewDelegate{
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let allowedCharacterSet = CharacterSet.alphanumerics.union(CharacterSet.whitespacesAndNewlines)
        let maxCharacterCount = 150
        let currentCharactersCount = textView.text.count
        let finalCharacterCount = currentCharactersCount - range.length + text.count
        return text == "" || (CharacterSet(charactersIn: text).isSubset(of: allowedCharacterSet) && finalCharacterCount <= maxCharacterCount)
    }
}
