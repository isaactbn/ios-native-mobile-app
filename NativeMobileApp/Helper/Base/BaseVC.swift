//
//  BaseVC.swift
//  NativeMobileApp
//
//  Created by Issac on 12/06/22.
//

import UIKit
import ProgressHUD

class BaseVC: UIViewController {
    private let loadingView: UIView = UIView()
    
    override func viewDidLoad() {
        navigationController?.interactivePopGestureRecognizer?.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        navigationController?.interactivePopGestureRecognizer?.isEnabled = navigationController?.viewControllers.count ?? 0 > 1
    }
}

extension BaseVC: UIGestureRecognizerDelegate{
}

extension BaseVC: BaseView {
    func showError(msg: String) {
            let alert = UIAlertController(title: "", message: msg, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (_) in
                alert.dismiss(animated: true, completion: nil)
            }))
            self.present(alert, animated: true)
    }
    
    func onLoading() {
        showLoading()
    }
    
    private func showLoading() {
        ProgressHUD.colorHUD = .clear
        ProgressHUD.colorBackground = .clear
//        ProgressHUD.colorSpinner(#colorLiteral(red: 0.1314774156, green: 0.3921217322, blue: 0.7550290227, alpha: 1))
        ProgressHUD.show()
    }
    
    func onFinishLoading() {
        hideLoading()
    }
    
    private func hideLoading() {
        ProgressHUD.dismiss()
    }
}
