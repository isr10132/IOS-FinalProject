//
//  FoodViewController.swift
//  FinalProject
//
//  Created by User01 on 2018/6/26.
//  Copyright © 2018年 isr10132. All rights reserved.
//

import UIKit
import GooglePlaces
import GooglePlacePicker

class FoodViewController: UIViewController, GMSPlacePickerViewControllerDelegate{
    
    var food: Food?

    @IBOutlet weak var storeLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var foodTextField: UITextField!
    @IBOutlet weak var descriptionTextField: UITextField!
    @IBOutlet weak var score: UISegmentedControl!
    
    @IBAction func pickPlace(_ sender: UIButton) {
        let config = GMSPlacePickerConfig(viewport: nil)
        let placePicker = GMSPlacePickerViewController(config: config)
        placePicker.delegate = self
        
        present(placePicker, animated: true, completion: nil)
    }
    
    func placePicker(_ viewController: GMSPlacePickerViewController, didPick place: GMSPlace) {
        viewController.dismiss(animated: true, completion: nil)
        
        self.storeLabel.text = place.name
        self.addressLabel.text = place.formattedAddress?.components(separatedBy: ", ").joined(separator: "\n")
    }
    
    func placePickerDidCancel(_ viewController: GMSPlacePickerViewController) {
        
        viewController.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func doneButtonPress(_ sender: Any) {
        performSegue(withIdentifier: "goBackToLoverTableWithSegue", sender: nil)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if food == nil {
            food = Food(store: storeLabel.text!, address: addressLabel.text!, name: foodTextField.text!, description: descriptionTextField.text!, star: score.selectedSegmentIndex)
        } else {
            food?.store = storeLabel.text!
            food?.address = addressLabel.text!
            food?.name = foodTextField.text!
            food?.description = descriptionTextField.text!
            food?.star = score.selectedSegmentIndex
        }
    }
}
