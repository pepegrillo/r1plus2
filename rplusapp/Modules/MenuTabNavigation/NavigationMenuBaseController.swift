//
//  NavigationMenuBaseController.swift
//  rplusapp
//
//  Created by Josué López on 11/10/20.
//

import UIKit

class NavigationMenuBaseController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
//        navigationController?.setNavigationBarHidden(true, animated: animated)
//        selectedIndex = 0
        self.navigationItem.setHidesBackButton(true, animated: false)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
//        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
        
    
    /*
    let bottomNavBar = MDCBottomNavigationBar()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        commonBottomNavigationTypicalUseSwiftExampleInit()
        
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden( true, animated: animated )
    }
    
    
    // Bottom Bar Customization
    func commonBottomNavigationTypicalUseSwiftExampleInit()
    {
        view.backgroundColor = .lightGray
        view.addSubview(bottomNavBar)
        
        // Always show bottom navigation bar item titles.
        bottomNavBar.titleVisibility = .always
        
        // Cluster and center the bottom navigation bar items.
        bottomNavBar.alignment = .centered
        
        // Add items to the bottom navigation bar.
        let tabBarItem1 = UITabBarItem( title: "",   image: UIImage(named: "IconMenuHome"), tag: 0 )
        let tabBarItem2 = UITabBarItem( title: "",   image: UIImage(named: "IconMenuHome"), tag: 1 )
        let tabBarItem3 = UITabBarItem( title: "", image: UIImage(named: "IconMenuHome"), tag: 2 )
        let tabBarItem4 = UITabBarItem( title: "", image: UIImage(named: "IconMenuHome"), tag: 3 )
        let tabBarItem5 = UITabBarItem( title: "", image: UIImage(named: "IconMenuHome"), tag: 4 )
        bottomNavBar.items = [ tabBarItem1, tabBarItem2, tabBarItem3, tabBarItem4, tabBarItem5 ]
        
        // Select a bottom navigation bar item.
        bottomNavBar.selectedItem = tabBarItem1;
        bottomNavBar.delegate = self
    }
    
//    func bottomNavigationBar(_ bottomNavigationBar: MDCBottomNavigationBar, didSelect item: UITabBarItem)
//    {
//        self.selectedIndex = item.tag
//    }
//
    override func viewWillLayoutSubviews()
    {
        super.viewWillLayoutSubviews()
        layoutBottomNavBar()
    }
    
    // Setting Bottom Bar
    func layoutBottomNavBar()
    {
        let size = bottomNavBar.sizeThatFits(view.bounds.size)
        let bottomNavBarFrame = CGRect( x: 0,
                                        y: view.bounds.height - (size.height + 100),
                                        width: size.width,
                                        height: size.height + 100 )
        bottomNavBar.frame = bottomNavBarFrame
    }
 
 */
}

/*
extension NavigationMenuBaseController: MDCBottomNavigationBarDelegate {
    func bottomNavigationBar(_ bottomNavigationBar: MDCBottomNavigationBar, didSelect item: UITabBarItem) {
        print("did select item \(item.tag)")
        self.selectedViewController = self.viewControllers![item.tag]
    }
}

*/

