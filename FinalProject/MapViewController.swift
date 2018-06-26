//
//  MapViewController.swift
//  FinalProject
//
//  Created by User02 on 2018/6/26.
//  Copyright © 2018年 isr10132. All rights reserved.
//

import UIKit
import GoogleMaps

class MapViewController: UIViewController {
    var foods = [Food]()
    var row: Int!
    override func viewDidLoad() {
        super.viewDidLoad()
//        NotificationCenter.default.addObserver(self, selector: #selector(self.editFoodNoti(noti:)), name: Notification.Name(rawValue: "noti"), object: nil)
        // Do any additional setup after loading the view.
    }
    
//    @objc func editFoodNoti(noti: Notification) {
//        print("Edit")
//        if let userInfo = noti.userInfo, let food = userInfo["food"] as? Food {
//            foods[row] = food
//            print(food)
//        }
//    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if let foods = Food.readLoversFromFile() {
            self.foods = foods
        }
        
        let camera = GMSCameraPosition.camera(withLatitude: 25.1504331, longitude: 121.7728744, zoom: 15.0)
        let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        view = mapView
        
        // 放 Marker
        for food in foods {
            
            let marker = GMSMarker()
            marker.position = CLLocationCoordinate2D(latitude: Double(food.latitude)!, longitude: Double(food.longitude)!)
            marker.title = food.store
            marker.snippet = food.description
            marker.map = mapView
        }
    }
    
    override func loadView() {
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
