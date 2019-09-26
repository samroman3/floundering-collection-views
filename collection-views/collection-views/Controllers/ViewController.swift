//
//  ViewController.swift
//  collection-views
//
//  Created by David Rifkin on 9/26/19.
//  Copyright © 2019 David Rifkin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var elementCollection: UICollectionView!
    
    var elements = [Element]() {
        didSet {
            elementCollection.reloadData()
        }
    }
    
    override func viewDidLoad() {
        elementCollection.delegate = self
        elementCollection.dataSource = self
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



extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    
//    func numberOfSections(in collectionView: UICollectionView) -> Int {
//        1
//    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return elements.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let element = elements[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "elementCell", for: indexPath) as? ElementCollectionViewCell
        cell?.atomicWeight.text = String(element.atomicMass)
        cell?.symbol.text = element.symbol
        cell?.name.text = element.name
        cell?.number.text = String(element.number)
        ImageHelper.shared.fetchFullSizeImage(elementName: element.name, elementID: element.number) { (result) in
            switch result{
            case .success(let image):
                cell?.elementImage.image = image
            case .failure(let error):
                print(error)
            }
        }
        return cell ?? UICollectionViewCell()
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 120, height: 115)
    }
    
    
}
