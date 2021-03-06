//
//  FavouritesTableViewController.swift
//  Tyme
//
//  Created by elev on 25/01/2018.
//  Copyright © 2018 Mads Bock. All rights reserved.
//

import UIKit

class FavouritesTableViewController: UITableViewController {
    private let controller = FavouritesController.instance
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.reloadData()
        let path = IndexPath(row: 0, section: 0)
        let sender = tableView.cellForRow(at: path)
        sender?.setSelected(true, animated: true)
        performSegue(withIdentifier: "show detail", sender: sender)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let res = controller.favourites.count
        return res
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "fav cell", for: indexPath)
        let index = indexPath.row
        cell.textLabel?.text = controller.getIndex(index)?.name

        return cell
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
        if(segue.identifier == "show detail") {
            if let detail = segue.destination as? DetailViewController, let cell = sender as? UITableViewCell, let index = tableView.indexPath(for: cell)?.row, let data = controller.getIndex(index) {
                
                detail.data = data
            } else {
                print("Something Went Wrong!")
            }
        } else {
            print("Segue was \(segue.identifier)")
        }
    }

}

extension FavouritesController {
    func getIndex(_ index: Int) -> FavouritesController.Favourite? {
        let keyArray = Array(self.favourites.keys)
        return self.favourites[keyArray[index]]
    }
}
