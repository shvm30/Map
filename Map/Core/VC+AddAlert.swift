//
//  VC+AddAlert.swift
//  Map
//
//  Created by Владимир on 22.02.2023.
//

import UIKit

extension ViewController {
    
    func addAlert(complition:@escaping(String) -> Void) {
        let alert = UIAlertController(title: "Добавить адрес", message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ок", style: .default, handler: { action in
            guard let adress = alert.textFields?.first?.text else { return }
            complition(adress)
        }))
        alert.addAction(UIAlertAction(title: "Отмена", style: .default))
        alert.addTextField(configurationHandler: { textField in
            textField.placeholder = "Введите адрес"
        })
                           
        present(alert, animated: true)
    }
    
    func addErrorAlert() {
        let alert = UIAlertController(title: "Ошибка", message: "Сервер недоступен", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ок", style: .cancel))
        present(alert, animated: true)
    }
    
}
