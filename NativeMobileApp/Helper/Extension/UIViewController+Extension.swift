//
//  UIViewController+Extension.swift
//  Storial
//
//  Created by Azmi Muhammad on 14/10/19.
//  Copyright © 2019 Clapping Ape. All rights reserved.
//

import UIKit

extension UIViewController {
    func setupHideKeyboard() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    @objc private func hideKeyboard() {
        view.endEditing(true)
    }
}

extension UIViewController {
    
    func hideNavigationBar() {
        navigationController?.isNavigationBarHidden = true
    }
    
    func showNavigationBar() {
        navigationController?.extendedLayoutIncludesOpaqueBars = true
        navigationController?.isNavigationBarHidden = false
        if #available(iOS 13.0, *) {
            let appearance = UINavigationBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.backgroundColor = .white
            navigationController?.navigationBar.standardAppearance = appearance
            navigationController?.navigationBar.scrollEdgeAppearance = navigationController?.navigationBar.standardAppearance
        } else {
            // Fallback on earlier versions
        }
    }
    
    func backToPreviousVC() {
        if let navigationController = navigationController {
            if navigationController.viewControllers.count <= 2{
                NotificationCenter.default.post(name: Notification.Name("ShowTab"), object: nil)
            }
            navigationController.popViewController(animated: true)
        } else {
            dismiss(animated: true, completion: nil)
        }
        
    }
    
    func backToPreviousSpecificVC(vc: AnyClass){
        if let navigationController = navigationController {
            for controller in navigationController.viewControllers as Array {
                if controller.isKind(of: vc.self) {
                    navigationController.popToViewController(controller, animated: true)
                    break
                }
            }
        }
    }
    
    func backToRootVC() {
        NotificationCenter.default.post(name: Notification.Name("ShowTab"), object: nil)
        navigationController?.popToRootViewController(animated: true)
    }
    
    func pushVC<V: BaseVC>(_ vc: V) {
        if navigationController?.viewControllers.count ?? 0 > 0{
            NotificationCenter.default.post(name: Notification.Name("ShowTab"), object: nil)
        }
        navigationController?.pushViewController(vc, animated: true)
        navigationController?.interactivePopGestureRecognizer?.isEnabled = false
    }
    
    func dismissVC() {
        if navigationController?.viewControllers.count ?? 0 <= 2{
            NotificationCenter.default.post(name: Notification.Name("ShowTab"), object: nil)
        }
        dismiss(animated: false, completion: nil)
    }
    
    
    func present<V: UIViewController>(_ vc: V, isFullScreen: Bool = false, isWithNavController: Bool = false, completion: (()->Void)? = nil) {
        if navigationController?.viewControllers.count ?? 0 > 0{
            NotificationCenter.default.post(name: Notification.Name("ShowTab"), object: nil)
        }
        if isWithNavController {
            let navController = UINavigationController(rootViewController: vc)
            if #available(iOS 13.0, *) {
                navController.modalPresentationStyle = isFullScreen ? .fullScreen : .automatic
            }
            present(navController, animated: true, completion: completion)
        } else {
            if #available(iOS 13.0, *) {
                vc.modalPresentationStyle = isFullScreen ? .fullScreen : .automatic
            }
            present(vc, animated: true, completion: completion)
        }
        
    }
    
    
    func navItem(icon: String = "", title: String = "", color: UIColor = .black, onTap: (() -> Void)?) -> UIBarButtonItem? {
        if !icon.elementsEqual("") {
            let image = UIImage(named: icon)
            let button = UIButton(type: .custom)
            button.setImage(image, for: .normal)
            button.tapGesture(action: onTap)
            button.setTitle(" \(title)", for: .normal)
            button.setTitleColor(color, for: .normal)
            let item = UIBarButtonItem(customView: button)
            return item
        } else {return nil}
    }
    
    func setupDefaultDPLKNavbar(){
        guard let nav = navigationController else {return}
        nav.navigationBar.tintColor = .white
        nav.navigationBar.barTintColor = .white
        nav.navigationBar.isTranslucent = false
        nav.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        nav.navigationBar.shadowImage = UIImage()
        let dplkImage = #imageLiteral(resourceName: "logo-dplk-indolife-2").withRenderingMode(.alwaysOriginal)
        let backButton = UIBarButtonItem(image: dplkImage,  style: .plain, target: self, action: nil)
        nav.navigationBar.topItem?.leftBarButtonItem = backButton
    }
    
    func buildBarButtonItem(title: String = "", color: UIColor = #colorLiteral(red: 0, green: 0.21322909, blue: 0.5749545693, alpha: 1), image: UIImage, action: (()->Void)?) -> UIBarButtonItem {
        let button: UIButton = UIButton(frame: CGRect(x: 0, y: 0, width: 41, height: 41))
        button.setImage(image, for: .normal)
        button.setTitle(title, for: .normal)
        button.setTitleColor(color, for: .normal)
        button.titleLabel?.font = UIFont(name: "WorkSans-Regular", size: 14)
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: -20, bottom: 0, right: 0)
        button.tapGesture(action: action)
        return UIBarButtonItem(customView: button)
    }
    
    func setupCurvedNavBar(title: String = "", color: UIColor = #colorLiteral(red: 0, green: 0.21322909, blue: 0.5749545693, alpha: 1), icon: String = "back-square", back: (()->Void)? = nil){
        guard let nav = navigationController else {return}
        nav.navigationBar.tintColor = .white
        nav.navigationBar.barTintColor = .white
        nav.navigationBar.backgroundColor = .white
        nav.navigationBar.isTranslucent = false
        nav.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        nav.navigationBar.shadowImage = UIImage()
        nav.navigationBar.layer.applySketchShadow(color: color, alpha: 0.06, x: 4, y: 6, blur: 6, spread: 0)
        nav.navigationBar.setupRadius(type: .custom(12))
        nav.navigationBar.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        
        let back = navItem(icon: icon, onTap: back ?? backToPreviousVC)
        navigationItem.leftBarButtonItem = back
        
        ///centered title nav bar
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: nav.navigationBar.bounds.width / 2, height: 30))
        label.textAlignment = .center
        label.backgroundColor = UIColor.clear
        label.textColor = color
        label.font = UIFont(name: "WorkSans-Bold", size: 16)
        label.text = title
        navigationItem.titleView = label
    }
}
