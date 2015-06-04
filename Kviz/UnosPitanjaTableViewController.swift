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
    }

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pitanja.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("PitanjeCell", forIndexPath: indexPath) as! UITableViewCell
        
        if (indexPath.row % 2 == 0) {
            self.tableView.backgroundColor = UIColor(red: 171/255.0, green: 191/255.0, blue: 255/255.0, alpha: 1.0)
            cell.backgroundColor = UIColor(red: 171/255.0, green: 191/255.0, blue: 255/255.0, alpha: 1.0)
            cell.textLabel!.backgroundColor = UIColor(red: 171/255.0, green: 191/255.0, blue: 255/255.0, alpha: 1.0)
            cell.detailTextLabel?.backgroundColor = UIColor(red: 171/255.0, green: 191/255.0, blue: 255/255.0, alpha: 1.0)
        } else {
            self.tableView.backgroundColor = UIColor(red: 171/255.0, green: 191/255.0, blue: 255/255.0, alpha: 0.8)
            cell.backgroundColor = UIColor(red: 171/255.0, green: 191/255.0, blue: 255/255.0, alpha: 0.9)
            cell.textLabel!.backgroundColor = UIColor(red: 171/255.0, green: 191/255.0, blue: 255/255.0, alpha: 0.8)
            cell.detailTextLabel?.backgroundColor = UIColor(red: 171/255.0, green: 191/255.0, blue: 255/255.0, alpha: 0.8)
            
        }

        let pitanje : PitanjeModel = pitanja[indexPath.row]
        cell.textLabel!.text = pitanje.pitanje

        return cell
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {

        if (segue.identifier == "seguePitanjePitanjeDetail") {
            
            let viewController : PitanjeDetailViewController = segue.destinationViewController as! PitanjeDetailViewController
            let indexPath = self.tableView.indexPathForSelectedRow()!
            let pitanjeTmp = pitanja[indexPath.row]
            
            viewController.pitanje = pitanjeTmp
            
        }
    }


}
