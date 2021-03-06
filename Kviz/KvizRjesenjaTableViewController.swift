//
//  KvizRjesenjaTableViewController.swift
//  Kviz
//
//  Created by Antonio Delivuk on 03/06/15.
//  Copyright (c) 2015 Kristijan Delivuk. All rights reserved.
//

import UIKit

class KvizRjesenjaTableViewController: UITableViewController {
    
    var pitanja : [PitanjeModel] = [PitanjeModel]()
    var trenutniOdgovori : [Int] = [Int]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.rowHeight = 70
        tableView.reloadData()


    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }


    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pitanja.count
    }


    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("rjesenjaCell", forIndexPath: indexPath) as! UITableViewCell
        
        cell.textLabel?.text = pitanja[indexPath.row].pitanje
        cell.detailTextLabel?.text = "Tocan odgovor: \(pitanja[indexPath.row].tocanOdgovor) ; Odabrani odgovor: \(trenutniOdgovori[indexPath.row])"
        

        // Configure the cell...
        if (pitanja[indexPath.row].tocanOdgovor.toInt() == trenutniOdgovori[indexPath.row]){
            self.tableView.backgroundColor = UIColor(red: 138/255.0, green: 230/255.0, blue: 138/255.0, alpha: 1.0)
            cell.backgroundColor = UIColor(red: 138/255.0, green: 230/255.0, blue: 138/255.0, alpha: 1.0)
            cell.textLabel!.backgroundColor = UIColor(red: 138/255.0, green: 230/255.0, blue: 138/255.0, alpha: 1.0)
            cell.detailTextLabel!.backgroundColor = UIColor(red: 138/255.0, green: 230/255.0, blue: 138/255.0, alpha: 1.0)
        } else {
            self.tableView.backgroundColor = UIColor(red: 255/255.0, green: 115/255.0, blue: 115/255.0, alpha: 1.0)
            cell.backgroundColor = UIColor(red: 255/255.0, green: 115/255.0, blue: 115/255.0, alpha: 1.0)
            cell.textLabel!.backgroundColor = UIColor(red: 255/255.0, green: 115/255.0, blue: 115/255.0, alpha: 1.0)
            cell.detailTextLabel!.backgroundColor = UIColor(red: 255/255.0, green: 115/255.0, blue: 115/255.0, alpha: 1.0)
        }

        return cell
    }


    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}
