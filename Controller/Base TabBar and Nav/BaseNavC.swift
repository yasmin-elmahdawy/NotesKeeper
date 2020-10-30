//
//  BaseNavC.swift
//  NotesKeeper
//
//  Created by G50 on 5/13/20.
//  Copyright © 2020 NotesKeeper. All rights reserved.
//

import UIKit

class BaseNavC: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
   //Add properties to the navigation bar
        self.isNavigationBarHidden = false
        self.navigationBar.isTranslucent = false //setting opacity
        
        //we can give the navigation bar a background color or background image
        self.navigationBar.barTintColor = #colorLiteral(red: 0.05045407647, green: 0.2297388561, blue: 0.3413865963, alpha: 1)
        //self.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationBar.shadowImage = UIImage()

        self.navigationBar.tintColor = #colorLiteral(red: 1, green: 0.4932718873, blue: 0.4739984274, alpha: 1)
        
        let titleTextAttributes : [NSAttributedString.Key : Any] = [.foregroundColor :#colorLiteral(red: 1, green: 0.4932718873, blue: 0.4739984274, alpha: 1) ,.font : UIFont(name: "Cairo-ExtraLight", size: 35)!]
        self.navigationBar.titleTextAttributes = titleTextAttributes

       // self.navigationBar.prefersLargeTitles = true
        
    }
}
