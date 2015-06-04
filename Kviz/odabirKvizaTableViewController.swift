//
//  odabirKvizaTableViewController.swift
//  Kviz
//
//  Created by Antonio Delivuk on 27/05/15.
//  Copyright (c) 2015 Kristijan Delivuk. All rights reserved.
//

import UIKit
import CoreData

class odabirKvizaTableViewController: UITableViewController {
    
    var kvizovi : [KvizModel] = [KvizModel]()
    
    func DohvatiKvizove() -> [KvizModel] {
        
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext!
        
        let fetchRequest = NSFetchRequest(entityName: "Kviz")
        
        var error: NSError?
        let fetchResults = managedContext.executeFetchRequest(fetchRequest, error: &error) as! [NSManagedObject]?
        
        var kvizModeli : [KvizModel] = [KvizModel]()
        
        if let rezultati = fetchResults {
            for kvizTemp in rezultati as! [Kviz] {
                var kvizModel = KvizModel()
                kvizModel.naziv = kvizTemp.naziv
                kvizModel.opis = kvizTemp.opis
                
                var pitanjaModeli : [PitanjeModel] = [PitanjeModel]()
                
                for pitanjeTemp in kvizTemp.svaPitanja {
                    
                    var pitanjee : PitanjeModel = PitanjeModel(pitanje: pitanjeTemp.valueForKey("pitanje") as! String, odgJedan: pitanjeTemp.valueForKey("odgJedan") as! String, odgDva: pitanjeTemp.valueForKey("odgDva") as! String, odgTri: pitanjeTemp.valueForKey("odgTri") as! String, tocanOdgovor: pitanjeTemp.valueForKey("odgTocan") as! String)
                    
                    kvizModel.svaPitanja.append(pitanjee)
                    
                }
                
                kvizModeli.append(kvizModel)
            }
        } else {
            println("Ne mogu pristupit Core data")
        }
        
        return kvizModeli
        
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.rowHeight = 70
        
        kvizovi = DohvatiKvizove()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return kvizovi.count
    }


    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("OdabirKvizaCell", forIndexPath: indexPath) as! UITableViewCell
        
        if (indexPath.row % 2 == 0) {
            self.tableView.backgroundColor = UIColor(red: 171/255.0, green: 191/255.0, blue: 255/255.0, alpha: 1.0)
            cell.backgroundColor = UIColor(red: 171/255.0, green: 191/255.0, blue: 255/255.0, alpha: 1.0)
            cell.textLabel!.backgroundColor = UIColor(red: 171/255.0, green: 191/255.0, blue: 255/255.0, alpha: 1.0)
            cell.detailTextLabel!.backgroundColor = UIColor(red: 171/255.0, green: 191/255.0, blue: 255/255.0, alpha: 1.0)
        } else {
            self.tableView.backgroundColor = UIColor(red: 171/255.0, green: 191/255.0, blue: 255/255.0, alpha: 0.8)
            cell.backgroundColor = UIColor(red: 171/255.0, green: 191/255.0, blue: 255/255.0, alpha: 0.9)
            cell.textLabel!.backgroundColor = UIColor(red: 171/255.0, green: 191/255.0, blue: 255/255.0, alpha: 0.8)
            cell.detailTextLabel!.backgroundColor = UIColor(red: 171/255.0, green: 191/255.0, blue: 255/255.0, alpha: 0.8)

        }

        
        // cell.textLabel?.text = pitanjaXML.objectAtIndex(indexPath.row).valueForKey("tekst_pitanja") as? String
        cell.textLabel?.text = kvizovi[indexPath.row].naziv
        cell.detailTextLabel?.text = kvizovi[indexPath.row].opis


        return cell
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if (segue.identifier == "odabirKvizSegue") {
        
            let viewController : KvizViewController = segue.destinationViewController as! KvizViewController
            let indexPath = self.tableView.indexPathForSelectedRow()!
            let kviz = kvizovi[indexPath.row]
            
            viewController.pitanja = kviz.svaPitanja
            viewController.kvizModel = kvizovi[indexPath.row]
            
        }
        
    }

}
