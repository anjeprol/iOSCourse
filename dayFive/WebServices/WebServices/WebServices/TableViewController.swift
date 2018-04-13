//
//  TableViewController.swift
//  WebServices
//
//  Created by Antonio Prado on 4/13/18.
//  Copyright © 2018 Antonio Prado. All rights reserved.
//

import UIKit
import AVFoundation

class TableViewController: UITableViewController, NetworkManagerDelegate {
    
    var nm_getCars: NetworkManager?
    var makes: [String]?
    var models: [String]?
    var picturesURLs: [String]?
    var picturesImages: [UIImage]?
    var audioPlayer: AVAudioPlayer?
    
    func connectionFinishSuccessfull(session: NetworkManager, response: NSDictionary) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
        
        if session == nm_getCars {
            print(response)
            
            if makes == nil {
                makes = response["carMakes"] as? [String]
            }
            
            if models == nil {
                models = response["carModels"] as? [String]
            }
            
            if picturesURLs == nil {
                picturesURLs = response["carPhotos"] as? [String]
            }
            
            if picturesImages == nil {
                picturesImages = [UIImage]()
            }
            
            // GCD - Grand Central Dispatch
            DispatchQueue.global().async {
                for urlStr in self.picturesURLs ?? [String]() {
                    if let url = URL (string: urlStr) {
                        do {
                            let data = try Data(contentsOf: url)
                            let image = UIImage(data: data)
                            self.picturesImages?.append(image!)
                            
                            let path = Bundle.main.path(forResource: "Mario-coin-sound", ofType: "mp3")
                            self.audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path!))
                            self.audioPlayer?.prepareToPlay()
                            
                            DispatchQueue.main.sync {
                                self.tableView.reloadData()
                                self.audioPlayer?.play()
                            }
                        } catch let error {
                            print(error.localizedDescription)
                        }
                    }
                }
            }
        }

    }
    
    func connectionFinishWithError(session: NetworkManager, error: String) {
        print(error)
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        nm_getCars = NetworkManager()
        nm_getCars?.delegate = self
        nm_getCars?.getCars()
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return picturesImages == nil ? 0 : picturesImages!.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = TableViewCell(withMake: makes?[indexPath.row] ?? "", model: models?[indexPath.row] ?? "", image: picturesImages?[indexPath.row] ?? nil)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130.0
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
