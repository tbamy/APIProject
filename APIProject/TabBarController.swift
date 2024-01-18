//
//  TabBarController.swift
//  APIProject
//
//  Created by WEMA on 18/01/2024.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let _ = BooksController()
        let _ = PopularController()

        // Do any additional setup after loading the view.
    }
    


}
