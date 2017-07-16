//
//  PermutationCollectionViewController.swift
//  Interchange
//
//  Created by Steven Masini on 16/07/2017.
//  Copyright © 2017 Steven Masini. All rights reserved.
//

import Foundation
import UIKit

class PermutationCollectionViewController: UICollectionViewController {
    var permutations = [String]() {
        didSet {
            self.collectionView?.reloadData()
        }
    }
    
    // MARK: UIViewController inherited methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    // MARK: UICollectionViewDataSource
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return permutations.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PermutationCell", for: indexPath) as! PermutationCell
        let permutation = self.permutations[indexPath.row]
        cell.textLabel.text = permutation
        
        return cell
    }
    
    // MARK: UICollectionViewDelegate
    
}
