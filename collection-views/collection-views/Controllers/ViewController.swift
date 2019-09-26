//
//  ViewController.swift
//  collection-views
//
//  Created by David Rifkin on 9/26/19.
//  Copyright © 2019 David Rifkin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var elements = [Element]() {
        didSet {
            //Do something??
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        // Do any additional setup after loading the view.
    }
    
    private func loadData() {
        ElementAPIClient.manager.getElements { (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let ElementsFromOnline):
                    self.elements = ElementsFromOnline
                case .failure(let error):
                    print(error)
                }
            }
        }
    }


}

