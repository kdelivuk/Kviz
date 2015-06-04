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

    
    // Testiranje
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // test parse na linku:
        //
        // http://nastava.tvz.hr/iOS/bazaPitanja.xml
        
        self.tableView.rowHeight = 70
        
        var pozadinaSlika = UIImage(named: "pozadina.jpg")
        var imageView = UIImageView(frame: self.view.bounds)
        imageView.image = pozadinaSlika
        imageView.contentMode = UIViewContentMode.ScaleAspectFill
        self.view.addSubview(imageView)
        self.view.sendSubviewToBack(imageView)
        
        kvizovi = DohvatiKvizove()
        
    }

    
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
            
            SpremiKviz(kvizParse)
            tableView.reloadData()
            //generirat prazan kviz
            
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

            println(pitanjeCoreData.odgTocan)
            
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
                    
                    
                    println(pitanjeTemp.valueForKey("odgTocan"))
                    
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
        return kvizovi.count
    }


    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("KvizCell", forIndexPath: indexPath) as! UITableViewCell
        
        cell.backgroundColor = UIColor.clearColor()


        // cell.textLabel?.text = pitanjaXML.objectAtIndex(indexPath.row).valueForKey("tekst_pitanja") as? String
        cell.textLabel?.text = kvizovi[indexPath.row].naziv
        cell.detailTextLabel?.text = kvizovi[indexPath.row].opis
        
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

    @IBAction func dohvatiNoviKviz(segue : UIStoryboardSegue){}
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
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
