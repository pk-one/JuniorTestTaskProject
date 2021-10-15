//
//  UIViewController + Extension.swift
//  JuniorTestTaskProject
//
//  Created by Pavel Olegovich on 14.10.2021.
//

import UIKit

extension UIViewController {
    func createCustomBarButtonItem(selector: Selector) -> UIBarButtonItem {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "person.fill"), for: .normal)
        button.tintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        button.addTarget(self, action: selector, for: .touchUpInside)
        
        let menuBarItem = UIBarButtonItem(customView: button)
        return menuBarItem
    }
    
    func show(title: String, message: String, action: Bool) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        if action == true {
            let okButton = UIAlertAction(title: "Ок", style: .default) { action in
                self.dismiss(animated: true, completion: nil)
            }
            alertController.addAction(okButton)
        } else if action == false {
            let okButton = UIAlertAction(title: "Ок", style: .default, handler: nil)
            alertController.addAction(okButton)
        }
        
        present(alertController, animated: true, completion: nil)
    }
}
