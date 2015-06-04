//
//  UnosPitanjaTableViewController.swift
//  Kviz
//
//  Created by Antonio Delivuk on 17/05/15.
//  Copyright (c) 2015 Kristijan Delivuk. All rights reserved.
//

import UIKit
import CoreData

class UnosPitanjaTableViewController: UITableViewController {
    
    var pitanja : [PitanjeModel] = [PitanjeModel]()
    var kvizModel : KvizModel = KvizModel()
    
    var pitanjaCore = [NSManagedObject]()

    @IBAction func unosPitanja(sender: AnyObject) {
        
        var alert = UIAlertController(title: "Novo pitanje", message: "Unos novog pitanja", preferredStyle: .Alert)
        
        let spremi = UIAlertAction(title: "Spremi", style: .Default) { (action: UIAlertAction!) -> Void in
            
            let upitPitanje = alert.textFields![0] as! UITextField
            let odgJedan = alert.textFields![1] as! UITextField
            let odgDva = alert.textFields![2] as! UITextField
            let odgTri = alert.textFields![3] as! UITextField
            let tocanOdg = alert.textFields![4] as! UITextField
            
            let pitanjeTmp : PitanjeModel = PitanjeModel(pitanje: upitPitanje.text, odgJedan: odgJedan.text, odgDva: odgDva.text, odgTri: odgTri.text, tocanOdgovor: tocanOdg.text)
            
            self.spremiPitanje(pitanjeTmp)
            
            self.tableView.reloadData()
        }
        
        let odustani = UIAlertAction(title: "Odustani", style: .Default) { (action: UIAlertAction!) -> Void in }
        
        alert.addTextFieldWithConfigurationHandler{
            (upitTextField: UITextField!) -> Void in
            
            
            upitTextField.placeholder = "Upit..."
        }
        
        alert.addTextFieldWithConfigurationHandler{
            (odgJedanTextField: UITextField!) -> Void in
            
            
            odgJedanTextField.placeholder = "Odg 1..."
        }
        alert.addTextFieldWithConfigurationHandler{
            (odgDvaTextField: UITextField!) -> Void in
            
            
            odgDvaTextField.placeholder = "Odg 2..."
        }
        
        alert.addTextFieldWithConfigurationHandler{
            (odgTriTextField: UITextField!) -> Void in
            
            
            odgTriTextField.placeholder = "Odg 3..."
        }
        
        alert.addTextFieldWithConfigurationHandler{
            (tocanOdgTextField: UITextField!) -> Void in
            
            
            tocanOdgTextField.placeholder = "Tocan odg.."
        }
        
        alert.addAction(spremi)
        alert.addAction(odustani)
        
        presentViewController(alert, animated: true, completion: nil)
    }
    
    func spremiPitanje(pitanjeZaSpremit : PitanjeModel) {
        
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext!
        
        let fetchRequest = NSFetchRequest(entityName: "Kviz")
        let predicate = NSPredicate(format: "naziv == %@" , kvizModel.naziv)
        
        fetchRequest.predicate = predicate
        
        var error : NSError?
        let fetchResults = managedContext.executeFetchRequest(fetchRequest, error: &error) as! [NSManagedObject]?
        
        if fetchResults!.count > 0 {
            let kvizCoreData = fetchResults?.first as! Kviz
        
        var pitanjaNS : NSMutableSet = NSMutableSet()
        
        println("pitanjeZaSpremit \(pitanjeZaSpremit.tocanOdgovor)")
            
        kvizModel.svaPitanja.append(pitanjeZaSpremit)
        
        for tmpPitanje in kvizModel.svaPitanja {
            
            let entity = NSEntityDescription.entityForName("Pitanje", inManagedObjectContext: managedContext)
            
            let pitanjeCoreData = NSManagedObject(entity: entity!, insertIntoManagedObjectContext: managedContext) as! Pitanje
            
            pitanjeCoreData.pitanje = tmpPitanje.pitanje
            pitanjeCoreData.odgJedan = tmpPitanje.odgJedan
            pitanjeCoreData.odgDva = tmpPitanje.odgDva
            pitanjeCoreData.odgTri = tmpPitanje.odgTri
            pitanjeCoreData.odgTocan = tmpPitanje.tocanOdgovor
            
            println(pitanjeCoreData.odgTocan)
            
            pitanjaNS.addObject(pitanjeCoreData)
            
        }
        
        kvizCoreData.svaPitanja = pitanjaNS
        
        var error : NSError?
        if !managedContext.save(&error) {
            println("Problem sa spremanjem u Core Data")
        }
        }
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var pozadinaSlika = UIImage(named: "pozadina.jpg")
        var imageView = UIImageView(frame: self.view.bounds)
        imageView.image = pozadinaSlika
        imageView.contentMode = UIViewContentMode.ScaleAspectFill
        self.view.addSubview(imageView)
        self.view.sendSubviewToBack(imageView)
        
        self.tableView.rowHeight = 70
        
        var refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: Selector("RefreshPitanja"), forControlEvents: .ValueChanged)
        self.refreshControl = refreshControl
        
        
    }
    
    func RefreshPitanja() {
        
        tableView.reloadData()
        
        refreshControl?.endRefreshing()
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return pitanja.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("PitanjeCell", forIndexPath: indexPath) as! UITableViewCell
        
        if (indexPath.row % 2 == 0) {
            cell.backgroundColor = UIColor.clearColor()
        } else {
            cell.backgroundColor = UIColor.whiteColor().colorWithAlphaComponent(0.5)
            cell.textLabel?.backgroundColor = UIColor.whiteColor().colorWithAlphaComponent(0.5)
            cell.detailTextLabel?.backgroundColor = UIColor.whiteColor().colorWithAlphaComponent(0.5)
        }

        // Configure the cell...
        let pitanje : PitanjeModel = pitanja[indexPath.row]
        cell.textLabel!.text = pitanje.pitanje

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


    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {

        if (segue.identifier == "seguePitanjePitanjeDetail") {
            
            let viewController : PitanjeDetailViewController = segue.destinationViewController as! PitanjeDetailViewController
            let indexPath = self.tableView.indexPathForSelectedRow()!
            let pitanjeTmp = pitanja[indexPath.row]
            
            viewController.pitanje = pitanjeTmp
            
        }
    }


}
