//
//  HomeTableViewController.swift
//  FinalProject
//
//  Created by User01 on 2018/6/23.
//  Copyright © 2018年 isr10132. All rights reserved.
//

import UIKit

class HomeTableViewController: UITableViewController {
    
    var foods = [Food]()
    var priceMinFlag: Bool = true
    var scoreMinFlag: Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let foods = Food.readLoversFromFile() {
            self.foods = foods
        }
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    // 回到首頁
    @IBAction func goBackToTable(segue: UIStoryboardSegue){
        let controller = segue.source as? EditFoodTableViewController
        
        if let food = controller?.food {
            if let row = tableView.indexPathForSelectedRow?.row  {
                foods[row] = food
            } else {
                foods.insert(food, at: 0)
            }
        }
        Food.saveToFile(foods: foods)
        tableView.reloadData()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    // 回傳數量
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return foods.count
    }
    // 刪除
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        foods.remove(at: indexPath.row)
        Food.saveToFile(foods: foods)
        tableView.reloadData()
    }
    // 設定表格內容
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "foodCell", for: indexPath) as! FoodTableViewCell

        let food = foods[indexPath.row]
        cell.storeLabel.text = food.store
        cell.foodLabel.text = food.food
        cell.priceLabel.text = "$\(food.price)"
        cell.scoreLabel.text = "\(food.star + 1)"

        return cell
    }
    // 排序分數
    @IBAction func starSortButton(_ sender: Any) {
        if scoreMinFlag {
            foods.sort(by: {$0.star > $1.star})
        } else {
            foods.sort(by: {$0.star < $1.star})
        }
        scoreMinFlag = !scoreMinFlag
        tableView.reloadData()
    }
    // 排序價格
    @IBAction func priceSortButton(_ sender: Any) {
        if priceMinFlag {
            foods.sort(by: {$0.price > $1.price})
        } else {
            foods.sort(by: {$0.price < $1.price})
        }
        priceMinFlag = !priceMinFlag
        tableView.reloadData()
    }
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

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let row = tableView.indexPathForSelectedRow?.row {
            let food = foods[row]
            let controller = segue.destination as? EditFoodTableViewController
            controller?.food = food
        }
    }

}
