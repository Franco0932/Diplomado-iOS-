//
//  HomeViewController.swift
//  AppModulo
//
//  Created by Franco Ruiz on 11/10/25.
//

import UIKit

class HomeViewController: UIViewController {
    
//    @IBOutlet weak var imageType: UISwitch!
//    @IBOutlet weak var captionSwitch: UISwitch!
//    @IBOutlet weak var captionTextSwitch: UISwitch!
//    @IBOutlet weak var customTextFields: UITextView!{
//        didSet{
//            customTextFields.delegate = self
//        }
//    }
//    @IBOutlet weak var picsButton: UIButton!
    
    var customView: HomeView{
        return view as! HomeView
    }
    
    override func loadView() {
        view = HomeView()
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        customView.picsButton.setImage(UIImage(systemName: customView.imageType.isOn ? "dog.fill" : "cat.fill"), for: .normal)
        customView.customTextField.isEditable = customView.captionSwitch.isOn
        setBarButtonItemGroup()
        
    }
    
    // MARK: - Navigation
    // In a storyboard-based application, you will often want to do a little preparation before navigation
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.destination is FeedViewController{
//        }else if segue.identifier == "HomeInformationSegue", let informationViewController = segue.destination as? InformationViewController {
//            
//            if customView.captionTextSwitch.isOn {
//                informationViewController.informationText = customView.customTextField.text
//            }
//        }
//    }
    
    @IBAction func picsButtonTapped(_ sender: Any){
        
    }
    
//    @IBAction func logOutButtonTapped(_ sender: Any){
//        self.navigationController?.dismiss(animated: true)
//    }
    
    @IBAction func informationButtonTapped(_ sender: Any){
        if customView.customTextSwitch.isOn{
            if customView.customTextField.text != "" {
                navigateToInformationViewController()
                //performSegue(withIdentifier: "HomeInformationSegue", sender: nil)
            }else{
                let alertController = UIAlertController(title: nil, message: "Add Custom Text", preferredStyle: .alert)
                alertController.addAction(UIAlertAction(title: "OK", style: .cancel))
                present(alertController, animated: true)
                return
            }
        }else{
            navigateToInformationViewController()
        }
    }
    
    private func setBarButtonItemGroup(){
        let logoutbutton = UIBarButtonItem(title: "Log Out", image: UIImage(systemName: "multiply.circle.fill"), target: self, action: #selector(logout))
        let informationbutton = UIBarButtonItem(title: "Information", image: UIImage(systemName: "info.circle.fill"), target: self, action: #selector(informationButtonTapped))
        navigationItem.centerItemGroups = [UIBarButtonItemGroup.fixedGroup(items: [logoutbutton, informationbutton])]
    }
    
    @objc private func logout(){
        navigationController?.dismiss(animated: true)
    }
    
    private func navigateToInformationViewController(){
        let infoViewController = InformationViewController()
        if customView.customTextSwitch.isOn {
            infoViewController.informationText = customView.customTextField.text
        }
        present(infoViewController, animated: true)
    }
    
    @IBAction func imageTypeSwitchValueChanged(_ sender: UISwitch){
        customView.picsButton.setImage(UIImage(systemName: customView.imageType.isOn ? "dog.fill" : "cat.fill"), for: .normal)
    }
    
    @IBAction func captionTypeSwitchValueChanged(_ sender: UISwitch){
        customView.customTextField.isEditable = sender.isOn
    }
    
    @IBAction func picsButton(_ sender: UIButton){
        let feedViewController = FeedViewController(nibName: nil, bundle: nil)
        feedViewController.pictureType = customView.imageType.isOn ? .dog : .cat
        feedViewController.showCaption = customView.captionSwitch.isOn
        navigationController?.pushViewController(feedViewController, animated: true)
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
