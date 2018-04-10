//
//  TableViewController.swift
//  tableViewController
//
//  Created by Antonio Prado on 4/10/18.
//  Copyright © 2018 Antonio Prado. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
    var selectedCells: Set<IndexPath>?
    let headers = [#imageLiteral(resourceName: "b1"), #imageLiteral(resourceName: "b2") , #imageLiteral(resourceName: "b3"), #imageLiteral(resourceName: "b4") ]

    override func viewDidLoad() {
        super.viewDidLoad()
        selectedCells = Set<IndexPath>()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 4
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 10
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Section: \(section+1)"
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: nil)
        cell.textLabel?.text = "Section: \(indexPath.section), Row: \(indexPath.row)"
        if (indexPath.row % 2 == 0) {
            cell.backgroundColor = UIColor.gray
        } else {
            cell.backgroundColor = UIColor.darkGray
        }
        
        if selectedCells!.contains(indexPath){
            cell.accessoryType = .checkmark
            
        }
        return cell
    }
    
    //Celda seleccionada
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let referenceToCell = tableView.cellForRow(at: indexPath)
        
        if selectedCells!.contains(indexPath){
            referenceToCell?.accessoryType = .none
            selectedCells?.remove(indexPath)
        } else {
            referenceToCell?.accessoryType = .checkmark
            selectedCells?.insert(indexPath)
        }
        print("Celda seleccionada: \(indexPath)")
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let background = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height*0.3))
        background.backgroundColor = .gray
        
        let containerIV = UIImageView(frame: background.frame)
        containerIV.image = headers[section]
        background.addSubview(containerIV)
        
        return background
    }


    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return view.frame.height*0.3
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
