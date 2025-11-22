//
//  ViewController.swift
//  TableView
//
//  Created by Franco Ruiz on 15/11/25.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var button2: UIButton!
    
    var array: [String] = ["Papel", "Carne", "Cebollas", "Alimento para perros"]
        
        override func viewDidLoad() {
            super.viewDidLoad()
            
            tableView.dataSource = self
            tableView.delegate = self
            tableView.register(UINib(nibName: "CustomTableViewCell", bundle: nil), forCellReuseIdentifier: "customCell")
        }
        
        @IBAction func addButton(_ sender: Any) {
            guard let newItem = textField.text, !newItem.isEmpty else { return }
            array.append(newItem)
            tableView.reloadData()
            print(array)
            textField.text = ""
        }
        
        @IBAction func button2Action(_ sender: Any) {
            tableView.isEditing.toggle()
            print("Modo edición: \(tableView.isEditing)")
        }
    }

    // MARK: - Data Source
    extension ViewController: UITableViewDataSource {
        
        func numberOfSections(in tableView: UITableView) -> Int {
            return 1 // Solo una sección
        }
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return array.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "customCell", for: indexPath) as! CustomTableViewCell
            cell.customName.text = array[indexPath.row]
            
            return cell
        }
    }

    extension ViewController: UITableViewDelegate {
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            print("Seleccionado: \(array[indexPath.row])")
            tableView.deselectRow(at: indexPath, animated: true)
        }
        
        func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
            return true
        }
        
        func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
            let itemToMove = array[sourceIndexPath.row]
            array.remove(at: sourceIndexPath.row)
            array.insert(itemToMove, at: destinationIndexPath.row)
        }
        
        func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
            return "Eliminar"
        }
        
        func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
            return true
        }
        
        func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
            if editingStyle == .delete {
                let alert = UIAlertController(title: "¿Estas seguro de eliminar?",
                                              message: "No se puede deshacer.",
                                              preferredStyle: .alert)
                
                let deleteAction = UIAlertAction(title: "Eliminar", style: .destructive) { _ in
                    self.array.remove(at: indexPath.row)
                    tableView.deleteRows(at: [indexPath], with: .fade)
                }
                
                let cancelAction = UIAlertAction(title: "Cancelar", style: .cancel) { _ in
                    tableView.setEditing(false, animated: true)
                }
                alert.addAction(deleteAction)
                alert.addAction(cancelAction)
                
                present(alert, animated: true)
            }
        }
        
        func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
            return "Lista de Compras"
        }
        
        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 50
        }
    }
