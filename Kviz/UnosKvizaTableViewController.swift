//
//  UnosKvizaTableViewController.swift
//  Kviz
//
//  Created by Antonio Delivuk on 17/05/15.
//  Copyright (c) 2015 Kristijan Delivuk. All rights reserved.
//

import UIKit
import CoreData

class UnosKvizaTableViewController: UITableViewController , NSXMLParserDelegate {

    var parser : NSXMLParser = NSXMLParser()
    var kvizUrl : String = String()
    
    // XML Parseanje
    
    var pitanjaXML = NSMutableArray()
    var element = NSString()
    var pitanjeXML = NSMutableDictionary()
    
    var pitanjeTekstXML = NSMutableString()
    var pitanjeOdgovorJedanXML = NSMutableString()
    var pitanjeOdgovorDvaXML = NSMutableString()
    var pitanjeOdgovorTriXML = NSMutableString()
    var pitanjeTocanOdgovorXML = NSMutableString()
    
    var kvizovi : [KvizModel] = [KvizModel]()
    var kvizParse : KvizModel = KvizModel()
    var pitanja : [PitanjeModel] = [PitanjeModel]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // test parse na linku:
        //
        // http://nastava.tvz.hr/iOS/bazaPitanja.xml
        
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
        let cell = tableView.dequeueReusableCellWithIdentifier("KvizCell", forIndexPath: indexPath) as! UITableViewCell
        
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

        cell.textLabel!.text = kvizovi[indexPath.row].naziv
        cell.detailTextLabel!.text = kvizovi[indexPath.row].opis
        
        return cell
    }

    
    // Custom functions
    
    func DodajNoviKviz(tmpKviz : KvizModel) {
        
        kvizParse.naziv = tmpKviz.naziv
        kvizParse.opis = tmpKviz.opis
        kvizParse.url = tmpKviz.url
        
        if !kvizParse.url.isEmpty {
            
            let urlTmp : NSURL = NSURL(string: kvizParse.url)!
            
            parser = NSXMLParser(contentsOfURL: urlTmp)!
            
            parser.delegate = self
            parser.parse()
            
            
            kvizParse.svaPitanja = pitanja
            
            SpremiKviz(kvizParse)
            
            tableView.reloadData()
            
        } else {
            //generirat prazan kviz
            SpremiKviz(kvizParse)
            tableView.reloadData()
            
        }
    }

    func SpremiKviz(kvizModel : KvizModel) {
        
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext!
        
        let entity = NSEntityDescription.entityForName("Kviz", inManagedObjectContext: managedContext)
        
        let kvizCoreData = NSManagedObject(entity: entity!, insertIntoManagedObjectContext: managedContext) as! Kviz
        
        kvizCoreData.naziv = kvizModel.naziv
        kvizCoreData.opis = kvizModel.opis
        
        var pitanjaNS : NSMutableSet = NSMutableSet()
        
        for tmpPitanje in kvizModel.svaPitanja {
            
            let entity = NSEntityDescription.entityForName("Pitanje", inManagedObjectContext: managedContext)
            
            let pitanjeCoreData = NSManagedObject(entity: entity!, insertIntoManagedObjectContext: managedContext) as! Pitanje
            
            pitanjeCoreData.pitanje = tmpPitanje.pitanje
            pitanjeCoreData.odgJedan = tmpPitanje.odgJedan
            pitanjeCoreData.odgDva = tmpPitanje.odgDva
            pitanjeCoreData.odgTri = tmpPitanje.odgTri
            pitanjeCoreData.odgTocan = tmpPitanje.tocanOdgovor
            
            pitanjaNS.addObject(pitanjeCoreData)
            
        }
        
        kvizCoreData.svaPitanja = pitanjaNS
        
        var error : NSError?
        if !managedContext.save(&error) {
            println("Problem sa spremanjem u Core Data")
        }
        
    }
    
    func KvizPostoji(naziv : String) -> Bool {
    
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext!
        
        let fetchRequest = NSFetchRequest(entityName: "Kviz")
        let predicate = NSPredicate(format: "naziv == %@" , naziv)
        
        fetchRequest.predicate = predicate
        
        var error : NSError?
        let fetchResults = managedContext.executeFetchRequest(fetchRequest, error: &error) as! [NSManagedObject]?
        
        if fetchResults!.count > 0 {
            return true;
        }
        
        return false
    }
    
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
            println("Ne mogu pristupit core data")
        }
        
        return kvizModeli
    
    }
    
    func parser(parser: NSXMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [NSObject : AnyObject]) {
        
        element = elementName
        if (elementName as NSString).isEqualToString("pitanje") {
            
            pitanjeXML = NSMutableDictionary.alloc()
            pitanjeXML = [:]
            pitanjeTekstXML = NSMutableString.alloc()
            pitanjeTekstXML = ""
            pitanjeOdgovorJedanXML = NSMutableString.alloc()
            pitanjeOdgovorJedanXML = ""
            pitanjeOdgovorDvaXML = NSMutableString.alloc()
            pitanjeOdgovorDvaXML = ""
            pitanjeOdgovorTriXML = NSMutableString.alloc()
            pitanjeOdgovorTriXML = ""
            pitanjeTocanOdgovorXML = NSMutableString.alloc()
            pitanjeTocanOdgovorXML = ""
        }

        
    }
    
    func parser(parser: NSXMLParser, foundCharacters string: String?) {
        
        let data = string?.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
        
        if (!data!.isEmpty) {
            if element.isEqualToString("tekst_pitanja") {
                pitanjeTekstXML.appendString(string!)
            } else if element.isEqualToString("odgovor0") {
                pitanjeOdgovorJedanXML.appendString(string!)
            } else if element.isEqualToString("odgovor1") {
                pitanjeOdgovorDvaXML.appendString(string!)
            } else if element.isEqualToString("odgovor2") {
                pitanjeOdgovorTriXML.appendString(string!)
            } else if element.isEqualToString("index_tocnog") {
                pitanjeTocanOdgovorXML.appendString(string!)
            }
        }
        

    }
    
    func parser(parser: NSXMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        
        if (elementName as NSString).isEqualToString("pitanje") {
            if !pitanjeTekstXML.isEqual(nil) {
                pitanjeXML.setObject(pitanjeTekstXML, forKey: "tekst_pitanja")
            }
            if !pitanjeOdgovorJedanXML.isEqual(nil) {
                pitanjeXML.setObject(pitanjeOdgovorJedanXML, forKey: "odgovor0")
            }
            if !pitanjeOdgovorDvaXML.isEqual(nil) {
                pitanjeXML.setObject(pitanjeOdgovorDvaXML, forKey: "odgovor1")
            }
            if !pitanjeOdgovorTriXML.isEqual(nil) {
                pitanjeXML.setObject(pitanjeOdgovorTriXML, forKey: "odgovor2")
            }
            if !pitanjeTocanOdgovorXML.isEqual(nil) {
                pitanjeXML.setObject(pitanjeTocanOdgovorXML, forKey: "index_tocnog")
            }
            
            var tmpPitanje : PitanjeModel = PitanjeModel(pitanje: pitanjeTekstXML as String, odgJedan: pitanjeOdgovorJedanXML as String, odgDva: pitanjeOdgovorDvaXML as String, odgTri: pitanjeOdgovorTriXML as String, tocanOdgovor: pitanjeTocanOdgovorXML as String)
            
            
            pitanja.append(tmpPitanje)
            
            pitanjaXML.addObject(pitanjeXML)
        }

    }

    @IBAction func dohvatiNoviKviz(segue : UIStoryboardSegue){}
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if (segue.identifier == "KvizPitanjeSegue") {
            
            let viewController : UnosPitanjaTableViewController = segue.destinationViewController as! UnosPitanjaTableViewController
            let indexPath = self.tableView.indexPathForSelectedRow()!
            let kviz = kvizovi[indexPath.row]
            
            viewController.pitanja = kviz.svaPitanja
            viewController.kvizModel = kvizovi[indexPath.row]
            
        }
 
    }

}
