//
//  ViewController.swift
//  cred-ai
//
//  Created by leyo babu on 23/01/22.
//

import UIKit

class ViewController: UIViewController {

    let tabSelectedImageArray = ["D_Home_Blue","D_Bag_Blue","D_Order_Blue"]
    let tabImageArray = ["D_Home_Gray","D_Bag_Gray","D_Order_Gray"]
    let tabBarNameArray = ["Home","Bag","Orders"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DispatchQueue.main.async {
            self.didTapButton()
        }
    }
    
    @objc func didTapButton(){
        let tabBarVC = UITabBarController()
        let vc1 = HomeViewController()
        let vc2 = SecondVC()
        let vc3 = ThirdVC()
        
        tabBarVC.setViewControllers([vc1,vc2,vc3], animated: true)
        guard let items = tabBarVC.tabBar.items else {
            return
        }
        
        for i in 0..<items.count {
            items[i].selectedImage = UIImage(named: tabSelectedImageArray[i])?.withRenderingMode(.alwaysOriginal)
            items[i].image = UIImage(named: tabImageArray[i])?.withRenderingMode(.alwaysOriginal)
//            items[i].title = tabBarNameArray[i]
            if i > 0{
                items[i].imageInsets = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
            }
        }
        tabBarVC.modalPresentationStyle = .fullScreen
        present(tabBarVC, animated: false)
    }
    
    class SecondVC:UIViewController{
        override func viewDidLoad() {
            super.viewDidLoad()
            view.backgroundColor = .white
        }
    }
    class ThirdVC:UIViewController{
        override func viewDidLoad() {
            super.viewDidLoad()
            view.backgroundColor = .white
        }
    }



}

