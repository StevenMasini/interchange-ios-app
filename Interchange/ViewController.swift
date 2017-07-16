//
//  ViewController.swift
//  Interchange
//
//  Created by Steven Masini on 13/07/2017.
//  Copyright © 2017 Steven Masini. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    // MARK: IBOutlets
    @IBOutlet weak var textField:           UITextField!
    @IBOutlet weak var combinaisonLabel:    UILabel!
    @IBOutlet weak var timeLabel:           UILabel!
    @IBOutlet weak var spinner:             UIActivityIndicatorView!
    @IBOutlet weak var containerView:       UIView!
    
    let operationQueue  = OperationQueue()
    var permutationSet  = Set<String>()
    var executionTime   = 0.0
    var permutationCollectionViewController: PermutationCollectionViewController?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 1- set the text field delegate
        self.textField.delegate = self
        
        for childVC in self.childViewControllers {
            if let permutationVC = childVC as? PermutationCollectionViewController {
                self.permutationCollectionViewController = permutationVC
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: UITextFieldDelegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        // 1- cancel all the previous operation
        self.operationQueue.cancelAllOperations()
        
        // 2- start the spinner
        self.spinner.startAnimating()
        
        // 3- define the operation
        weak var wself = self
        let op = BlockOperation {
            if let wself = wself {
                let startTime = Date()
                if let str = self.textField.text {
                    if !str.isEmpty {
                        wself.permutationSet = str.permutation()
                    } else {
                        wself.permutationSet = "ATGC".permutation()
                    }
                }
                wself.executionTime = Date().timeIntervalSince(startTime)
            }
        }
        
        op.completionBlock = {
            DispatchQueue.main.async {
                if let wself = wself {
                    // 1- stop the spinner
                    wself.spinner.stopAnimating()
                    
                    // 2- update the ui
                    wself.combinaisonLabel.text = "Combinaison: \(wself.permutationSet.count)"
                    wself.timeLabel.text        = "Time: " + String(format: "%.3fs", wself.executionTime)
                    wself.permutationCollectionViewController?.permutations = wself.permutationSet.map({$0})
                }
            }
        }
        // 4- add the operation to the queue
        self.operationQueue.addOperation(op)
        
        // 5- resign the keyboard
        self.textField.resignFirstResponder()
        
        return true
    }
    
    // MARK: IBAction
    @IBAction func nucleobaseAction(_ sender: Any) {
        if let url = URL(string: "https://en.wikipedia.org/wiki/Nucleobase") {
            UIApplication.shared.openURL(url)
        }
    }
}

