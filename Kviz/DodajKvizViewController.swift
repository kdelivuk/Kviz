//
//  DodajKvizViewController.swift
//  Kviz
//
//  Created by Antonio Delivuk on 17/05/15.
//  Copyright (c) 2015 Kristijan Delivuk. All rights reserved.
//

import UIKit

class DodajKvizViewController: UIViewController {

    @IBOutlet weak var textNazivKviza: UITextField!
    @IBOutlet weak var textOpisKviza: UITextField!
    @IBOutlet weak var textURLKviza: UITextField!
    @IBOutlet var viewUnosKviza: UIView!
    @IBOutlet weak var buttonDodaj: UIButton!
    
    @IBAction func dodajKvizAction(sender: AnyObject) {
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        buttonDodaj.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resoußßrces that can be recreated.
    }
    


    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        let kvizoviViewController = segue.destinationViewController as! UnosKvizaTableViewController
        
        var tmpKviz : KvizModel = KvizModel()
        
        tmpKviz.naziv = textNazivKviza.text
        tmpKviz.opis = textOpisKviza.text
        if textURLKviza.text.isEmpty {
            textURLKviza.text = ""
        } else {
            tmpKviz.url = textURLKviza.text
        }
        kvizoviViewController.DodajNoviKviz(tmpKviz)
        
    }


}
