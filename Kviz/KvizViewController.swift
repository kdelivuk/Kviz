//
//  KvizViewController.swift
//  Kviz
//
//  Created by Antonio Delivuk on 27/05/15.
//  Copyright (c) 2015 Kristijan Delivuk. All rights reserved.
//

import UIKit

class KvizViewController: UIViewController {
    
    var pitanja : [PitanjeModel] = [PitanjeModel]()
    var kvizModel : KvizModel = KvizModel()
    var trenutniOdgovori : [Int] = [Int]()
    var trenutnoPitanje : Int = 0;
    
    @IBOutlet weak var buttonOdgJedan: UIButton!
    @IBOutlet weak var buttonOdgDva: UIButton!
    @IBOutlet weak var buttonOdgTri: UIButton!
    @IBOutlet weak var buttonNext: UIButton!
    @IBOutlet weak var buttonPrev: UIButton!
    
    @IBOutlet weak var buttonA: UIButton!
    @IBOutlet weak var buttonB: UIButton!
    @IBOutlet weak var ButtonC: UIButton!
    
    
    @IBOutlet weak var buttonZavrsiKviz: UIButton!

    @IBOutlet weak var labelPitanje: UILabel!
    
    @IBAction func buttonNextAction(sender: AnyObject) {
        
        if (trenutnoPitanje + 1 < pitanja.count) {
            
            trenutnoPitanje++
            
            if (trenutnoPitanje + 1 == pitanja.count) {
                buttonZavrsiKviz.hidden = false
            }
            loadPitanje()
        }

    }
    
    @IBAction func buttonPrevAction(sender: AnyObject) {
        
        if (trenutnoPitanje > 0) {
            
            trenutnoPitanje--
            
            loadPitanje()
        }
        
    }
    
    func svaPitanjaIspunjena() -> Bool {
        for i in 0..<trenutniOdgovori.count {
            if trenutniOdgovori[i] == 99 {
                return false
            }
        }
        
        return true
    }
    
    @IBAction func buttonZavrsiKvizAction(sender: AnyObject) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for i in 0..<pitanja.count {
            trenutniOdgovori.append(99)
        }
        
        for i in 0..<pitanja.count {
            println(trenutniOdgovori[i])
        }
        
        buttonZavrsiKviz.hidden = true
        
        self.buttonOdgJedan.center.x += self.view.center.x * 2
        self.buttonOdgDva.center.x += self.view.center.x * 2
        self.buttonOdgTri.center.x += self.view.center.x * 2
        
        self.buttonA.center.x -= self.view.center.x * 2
        self.buttonB.center.x -= self.view.center.x * 2
        self.ButtonC.center.x -= self.view.center.x * 2
        
        self.buttonA.alpha = 0.0
        self.buttonB.alpha = 0.0
        self.ButtonC.alpha = 0.0
        
        self.buttonOdgJedan.alpha = 0.0
        self.buttonOdgDva.alpha = 0.0
        self.buttonOdgTri.alpha = 0.0
        
        stilizirajGumb(buttonOdgJedan)
        stilizirajGumb(buttonOdgDva)
        stilizirajGumb(buttonOdgTri)
        stilizirajGumb(buttonA)
        stilizirajGumb(buttonB)
        stilizirajGumb(ButtonC)
        stilizirajGumb(buttonNext)
        stilizirajGumb(buttonPrev)
        stilizirajGumb(buttonZavrsiKviz)
        
        
        loadPitanje()
    }
    
    func stilizirajGumb( gumb : UIButton) {
        gumb.layer.shadowColor = UIColor.blackColor().CGColor
        gumb.layer.shadowOffset = CGSizeMake(2, 2)
        gumb.layer.shadowRadius = 2
        gumb.layer.shadowOpacity = 0.5
    }
    
    func loadPitanje() -> Void {
        
        labelPitanje.text = pitanja[trenutnoPitanje].pitanje
        
        buttonOdgJedan.setTitle(pitanja[trenutnoPitanje].odgJedan, forState: UIControlState.Normal)
        
        buttonOdgDva.setTitle(pitanja[trenutnoPitanje].odgDva, forState: UIControlState.Normal)
        
        buttonOdgTri.setTitle(pitanja[trenutnoPitanje].odgTri, forState: UIControlState.Normal)
        
        self.buttonOdgJedan.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        self.buttonA.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        
        self.buttonOdgDva.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        self.buttonB.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        
        self.buttonOdgTri.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        self.ButtonC.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        
        
        // Animacije
        
        UIView.animateWithDuration(0.5, delay: 0.0, usingSpringWithDamping: 0.9, initialSpringVelocity: 0.0, options: nil, animations: {
            
            self.buttonOdgJedan.center.x -= self.view.center.x * 2
            self.buttonOdgJedan.alpha = 1.0
            
            self.buttonA.center.x += self.view.center.x * 2
            self.buttonA.alpha = 1.0
            
            }, completion: nil)
        
        UIView.animateWithDuration(0.5, delay: 0.2, usingSpringWithDamping: 0.9, initialSpringVelocity: 0.0, options: nil, animations: {
            
            self.buttonOdgDva.center.x -= self.view.center.x * 2
            self.buttonOdgDva.alpha = 1.0
            
            self.buttonB.center.x += self.view.center.x * 2
            self.buttonB.alpha = 1.0
            
            }, completion: nil)
        
        UIView.animateWithDuration(0.5, delay: 0.4, usingSpringWithDamping: 0.9, initialSpringVelocity: 0.0, options: nil, animations: {
            
            self.buttonOdgTri.center.x -= self.view.center.x * 2
            self.buttonOdgTri.alpha = 1.0
            
            self.ButtonC.center.x += self.view.center.x * 2
            self.ButtonC.alpha = 1.0
            
            } , completion: nil)

    
    }
    
    @IBAction func buttonOdgJedanAction(sender: AnyObject) {
        
        trenutniOdgovori[trenutnoPitanje] = 0;
        
        UIView.animateWithDuration(0.5, delay: 0.0, usingSpringWithDamping: 0.9, initialSpringVelocity: 0.0, options: nil, animations: {

            
            }, completion: nil)
        
        UIView.animateWithDuration(0.5, delay: 0.2, usingSpringWithDamping: 0.9, initialSpringVelocity: 0.0, options: nil, animations: {
            
            self.buttonOdgDva.center.x += self.view.center.x * 2
            self.buttonOdgDva.alpha = 0.0
            
            self.buttonB.center.x -= self.view.center.x * 2
            self.buttonB.alpha = 0.0
            
            }, completion: nil)
        
        UIView.animateWithDuration(0.5, delay: 0.4, usingSpringWithDamping: 0.9, initialSpringVelocity: 0.0, options: nil, animations: {
            
            self.buttonOdgTri.center.x += self.view.center.x * 2
            self.buttonOdgTri.alpha = 0.0
            
            self.ButtonC.center.x -= self.view.center.x * 2
            self.ButtonC.alpha = 0.0
            
            } , completion: nil)
        
        UIView.animateWithDuration(0.5, delay: 0.4, usingSpringWithDamping: 0.9, initialSpringVelocity: 0.0, options: nil, animations: {
            
            self.buttonOdgJedan.setTitleColor(UIColor(red: 171/255.0, green: 191/255.0, blue: 255/255.0, alpha: 1.0), forState: UIControlState.Normal)
            self.buttonA.setTitleColor(UIColor(red: 171/255.0, green: 191/255.0, blue: 255/255.0, alpha: 1.0), forState: UIControlState.Normal)

            
            } , completion: nil)
        
        enableZavrsetakKviza()
        
    }
    
    @IBAction func buttonOdgDvaAction(sender: AnyObject) {
        
        trenutniOdgovori[trenutnoPitanje] = 1;

        
        UIView.animateWithDuration(0.5, delay: 0.2, usingSpringWithDamping: 0.9, initialSpringVelocity: 0.0, options: nil, animations: {
            
            self.buttonOdgJedan.center.x += self.view.center.x * 2
            self.buttonOdgJedan.alpha = 0.0
            
            self.buttonA.center.x -= self.view.center.x * 2
            self.buttonA.alpha = 0.0
            
            
            }, completion: nil)
        
        UIView.animateWithDuration(0.5, delay: 0.2, usingSpringWithDamping: 0.9, initialSpringVelocity: 0.0, options: nil, animations: {
            

            
            }, completion: nil)
        
        UIView.animateWithDuration(0.5, delay: 0.4, usingSpringWithDamping: 0.9, initialSpringVelocity: 0.0, options: nil, animations: {
            
            self.buttonOdgTri.center.x += self.view.center.x * 2
            self.buttonOdgTri.alpha = 0.0
            
            self.ButtonC.center.x -= self.view.center.x * 2
            self.ButtonC.alpha = 0.0
            
            } , completion: nil)
        
        UIView.animateWithDuration(0.5, delay: 0.4, usingSpringWithDamping: 0.9, initialSpringVelocity: 0.0, options: nil, animations: {
            
            self.buttonOdgDva.setTitleColor(UIColor(red: 171/255.0, green: 191/255.0, blue: 255/255.0, alpha: 1.0), forState: UIControlState.Normal)
            self.buttonB.setTitleColor(UIColor(red: 171/255.0, green: 191/255.0, blue: 255/255.0, alpha: 1.0), forState: UIControlState.Normal)

            
            } , completion: nil)
        
        enableZavrsetakKviza()
    }
    
    @IBAction func buttonOdgTriAction(sender: AnyObject) {
        
        trenutniOdgovori[trenutnoPitanje] = 2;
        
        UIView.animateWithDuration(0.5, delay: 0.2, usingSpringWithDamping: 0.9, initialSpringVelocity: 0.0, options: nil, animations: {
            
            self.buttonOdgJedan.center.x += self.view.center.x * 2
            self.buttonOdgJedan.alpha = 0.0
            
            self.buttonA.center.x -= self.view.center.x * 2
            self.buttonA.alpha = 0.0
            
            
            }, completion: nil)
        
        UIView.animateWithDuration(0.5, delay: 0.4, usingSpringWithDamping: 0.9, initialSpringVelocity: 0.0, options: nil, animations: {
            
            self.buttonOdgDva.center.x += self.view.center.x * 2
            self.buttonOdgDva.alpha = 0.0
            
            self.buttonB.center.x -= self.view.center.x * 2
            self.buttonB.alpha = 0.0
            
            }, completion: nil)
        
        UIView.animateWithDuration(0.5, delay: 0.2, usingSpringWithDamping: 0.9, initialSpringVelocity: 0.0, options: nil, animations: {
            

            
            } , completion: nil)
        UIView.animateWithDuration(0.5, delay: 0.4, usingSpringWithDamping: 0.9, initialSpringVelocity: 0.0, options: nil, animations: {
            
            self.buttonOdgTri.setTitleColor(UIColor(red: 171/255.0, green: 191/255.0, blue: 255/255.0, alpha: 1.0), forState: UIControlState.Normal)
            self.ButtonC.setTitleColor(UIColor(red: 171/255.0, green: 191/255.0, blue: 255/255.0, alpha: 1.0), forState: UIControlState.Normal)

            
            } , completion: nil)
        
            enableZavrsetakKviza()

    }
    
    func enableZavrsetakKviza() -> Void {
        if (buttonZavrsiKviz.hidden == false && svaPitanjaIspunjena()) {
            self.buttonZavrsiKviz.enabled = true
            self.buttonZavrsiKviz.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {

        if (segue.identifier == "segueKvizRjesenja") {
            
            let viewController : KvizRjesenjaTableViewController = segue.destinationViewController as! KvizRjesenjaTableViewController

            viewController.pitanja = pitanja
            viewController.trenutniOdgovori = trenutniOdgovori
        }
    }


}
