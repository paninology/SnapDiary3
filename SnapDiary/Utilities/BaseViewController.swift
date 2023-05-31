//
//  BaseViewController.swift
//  SnapDiary
//
//  Created by yongseok lee on 2023/05/19.
//

import UIKit

class BaseViewController: UIViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        setUI()
    }

    
    func configure() {
        
    }
    
    func setUI() {
        
    }
    
    func showAlertWithCompletion(title: String, message: String, hasCancelButton: Bool, completion: ( (UIAlertAction) -> Void)? ) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default, handler: completion)
        let cancel = UIAlertAction(title: "Cancel", style: .cancel)
        alert.addAction(ok)
        if hasCancelButton {
            alert.addAction(cancel)
        }
        present(alert, animated: true, completion: nil)
    }
}
