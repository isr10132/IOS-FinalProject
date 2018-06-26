//
//  EditFoodTableViewController.swift
//  FinalProject
//
//  Created by User02 on 2018/6/26.
//  Copyright © 2018年 isr10132. All rights reserved.
//

import UIKit
import GooglePlaces
import GooglePlacePicker

class EditFoodTableViewController: UITableViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate ,GMSPlacePickerViewControllerDelegate {

    var food: Food?
    
    @IBOutlet weak var storeLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var foodTextField: UITextField!
    @IBOutlet weak var priceTextField: UITextField!
    @IBOutlet weak var descriptionTextField: UITextField!
    @IBOutlet weak var score: UISegmentedControl!
    
    var latitude: String?
    var longitude: String?
    
    @IBAction func pickPlace(_ sender: UIButton) {
        let center = CLLocationCoordinate2DMake(25.1504331,121.7728744)
        let northEast = CLLocationCoordinate2DMake(center.latitude + 0.001, center.longitude + 0.001)
        let southWest = CLLocationCoordinate2DMake(center.latitude - 0.001, center.longitude - 0.001)
        let viewport = GMSCoordinateBounds(coordinate: northEast, coordinate: southWest)
        let config = GMSPlacePickerConfig(viewport: viewport)
        let placePicker = GMSPlacePickerViewController(config: config)
        placePicker.delegate = self
        present(placePicker, animated: true, completion: nil)
    }
    
    func placePicker(_ viewController: GMSPlacePickerViewController, didPick place: GMSPlace) {
        viewController.dismiss(animated: true, completion: nil)
        latitude = "\(place.coordinate.latitude)"
        longitude = "\(place.coordinate.longitude)"
        self.storeLabel.text = place.name
        self.addressLabel.text = place.formattedAddress?.components(separatedBy: ", ").joined(separator: "\n")
    }
    
    func placePickerDidCancel(_ viewController: GMSPlacePickerViewController) {
        viewController.dismiss(animated: true, completion: nil)
    }
    
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let image = info[UIImagePickerControllerOriginalImage] as? UIImage
        imageView.image = image
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func choosePhoto(_ sender: Any) {
        let controller = UIImagePickerController()
        controller.sourceType = .photoLibrary
        controller.delegate = self
        present(controller, animated: true, completion: nil)
    }
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let food = food {
            storeLabel.text = food.store
            addressLabel.text = food.address
            foodTextField.text = food.food
            priceTextField.text = "\(food.price)"
            descriptionTextField.text = food.description
            score.selectedSegmentIndex = food.star
            let fileManager = FileManager.default
            let docUrls =
                fileManager.urls(for: .documentDirectory, in: .userDomainMask)
            let docUrl = docUrls.first
            let url = docUrl?.appendingPathComponent(food.photo)
            imageView.image = UIImage(contentsOfFile: url!.path)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func doneButtonPress(_ sender: Any) {
        if (imageView.image == nil) {
            let alertController = UIAlertController(title: "請選擇圖片", message: nil, preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(action)
            present(alertController, animated: true, completion: nil)
            return
        }
        if storeLabel.text?.count == 0 {
            let alertController = UIAlertController(title: "請選擇地點", message: nil, preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(action)
            present(alertController, animated: true, completion: nil)
            return
        }
        if addressLabel.text?.count == 0 {
            let alertController = UIAlertController(title: "請選擇地點", message: nil, preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(action)
            present(alertController, animated: true, completion: nil)
            return
        }
        if foodTextField.text?.count == 0 {
            let alertController = UIAlertController(title: "請輸入食物", message: nil, preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(action)
            present(alertController, animated: true, completion: nil)
            return
        }
        if priceTextField.text?.count == 0 {
            let alertController = UIAlertController(title: "請輸入價格", message: nil, preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(action)
            present(alertController, animated: true, completion: nil)
            return
        }
        if descriptionTextField.text?.count == 0 {
            let alertController = UIAlertController(title: "請輸入評語", message: nil, preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(action)
            present(alertController, animated: true, completion: nil)
            return
        }
        
        performSegue(withIdentifier: "goBackToTableWithSegue", sender: nil)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let fileManager = FileManager.default
        let docUrls = fileManager.urls(for: .documentDirectory, in: .userDomainMask)
        let docUrl = docUrls.first
        
        let interval = Date.timeIntervalSinceReferenceDate
        let photo = "\(interval)"
        let url = docUrl?.appendingPathComponent(photo)
        
        let data = UIImageJPEGRepresentation(imageView.image!, 0.9)
        try! data?.write(to: url!)
        
        if food == nil {
            food = Food(store: storeLabel.text!, address: addressLabel.text!, food: foodTextField.text!, price: Int(priceTextField.text!)!, description: descriptionTextField.text!, star: score.selectedSegmentIndex, photo: photo, latitude: latitude!, longitude: longitude!)
        } else {
            food?.store = storeLabel.text!
            food?.address = addressLabel.text!
            food?.food = foodTextField.text!
            food?.price = Int(priceTextField.text!)!
            food?.description = descriptionTextField.text!
            food?.star = score.selectedSegmentIndex
            food?.photo = photo
        }
//        NotificationCenter.default.post(name: Notification.Name(rawValue: "noti"), object: nil, userInfo: ["food":"food!"])
//        print("sent")
    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
