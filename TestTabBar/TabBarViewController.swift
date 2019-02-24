//
//  TabBarViewController.swift
//  TestTabBar
//
//  Created by under on 26/01/2019.
//  Copyright © 2019 under. All rights reserved.
//

import UIKit

public class TabBarViewController: UIViewController {
    var tabBar: TabBar { return self.view as! TabBar}
    
  
    override public func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
    
        //tabBar.setContainer(container: self)
        tabBar.setTabBarColor(color: .blue)
        let position = tabBar.definePosition(position: Position.LEFT)
        let buttons = tabBar.selectNumberOfButton(numberButton: 6)
        tabBar.chooseSizeButton(buttons: buttons, position: position, sizeButtons: 0.1, 0.3, 0.2, 0.1, 0.2, 0.1)
        
        tabBar.addImageView(buttons: buttons, position: position, icone: "home", "profile", "info", "folder", "settings", "home")
        
        
        //tabBar.addButtonToTabBar(buttons: buttons)
        

    
        //self.view.addSubview(tabBar)

    }
    
    override public func loadView() {
        self.view = TabBar(frame: UIScreen.main.bounds)
    }
    
    override public func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        tabBar.isLandscape()
    }
    
}
