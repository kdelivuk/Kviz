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
        
        var pozadinaSlika = UIImage(named: "pozadina.jpg")
        var imageView = UIImageView(frame: self.view.bounds)
        imageView.image = pozadinaSlika
        imageView.contentMode = UIViewContentMode.ScaleAspectFill
        self.view.addSubview(imageView)
        self.view.sendSubviewToBack(imageView)
        
        self.buttonOdgJedan.center.x -= self.view.center.x * 2
        self.buttonOdgDva.center.x -= self.view.center.x * 2
        self.buttonOdgTri.center.x -= self.view.center.x * 2
        
        self.buttonOdgJedan.alpha = 0.0
        self.buttonOdgDva.alpha = 0.0
        self.buttonOdgTri.alpha = 0.0
        
        stilizirajGumb(buttonOdgJedan)
        stilizirajGumb(buttonOdgDva)
        stilizirajGumb(buttonOdgTri)
        
        loadPitanje()
    }
    
    func stilizirajGumb( gumb : UIButton) {
        gumb.backgroundColor = UIColor.clearColor()
        gumb.layer.shadowColor = UIColor.blackColor().CGColor
        gumb.layer.shadowOffset = CGSizeMake(2, 2)
        gumb.layer.shadowRadius = 2
        gumb.layer.shadowOpacity = 0.5
    }
    
    func loadPitanje() -> Void {
        
        buttonNext.enabled = false
        
        labelPitanje.text = pitanja[trenutnoPitanje].pitanje
        
        buttonOdgJedan.setTitle(pitanja[trenutnoPitanje].odgJedan, forState: UIControlState.Normal)
        
        buttonOdgDva.setTitle(pitanja[trenutnoPitanje].odgDva, forState: UIControlState.Normal)
        
        buttonOdgTri.setTitle(pitanja[trenutnoPitanje].odgTri, forState: UIControlState.Normal)
        
        // Animacije
        
        UIView.animateWithDuration(0.5, delay: 0.0, usingSpringWithDamping: 0.9, initialSpringVelocity: 0.0, options: nil, animations: {
            
            self.buttonOdgJedan.center.x += self.view.center.x * 2
            self.buttonOdgJedan.alpha = 1.0
            
            
            }, completion: nil)
        
        UIView.animateWithDuration(0.5, delay: 0.2, usingSpringWithDamping: 0.9, initialSpringVelocity: 0.0, options: nil, animations: {
            
            self.buttonOdgDva.center.x += self.view.center.x * 2
            self.buttonOdgDva.alpha = 1.0
            
            }, completion: nil)
        
        UIView.animateWithDuration(0.5, delay: 0.4, usingSpringWithDamping: 0.9, initialSpringVelocity: 0.0, options: nil, animations: {
            
            self.buttonOdgTri.center.x += self.view.center.x * 2
            self.buttonOdgTri.alpha = 1.0
            
            } , completion: nil)

    
    }
    
    @IBAction func buttonOdgJedanAction(sender: AnyObject) {
        
        trenutniOdgovori[trenutnoPitanje] = 0;
        
        for i in 0..<pitanja.count {
            println(trenutniOdgovori[i])
        }
        
        UIView.animateWithDuration(0.5, delay: 0.0, usingSpringWithDamping: 0.9, initialSpringVelocity: 0.0, options: nil, animations: {

            
            }, completion: nil)
        
        UIView.animateWithDuration(0.5, delay: 0.2, usingSpringWithDamping: 0.9, initialSpringVelocity: 0.0, options: nil, animations: {
            
            self.buttonOdgDva.center.x += self.view.center.x * 2
            self.buttonOdgDva.alpha = 0.0
            
            }, completion: nil)
        
        UIView.animateWithDuration(0.5, delay: 0.4, usingSpringWithDamping: 0.9, initialSpringVelocity: 0.0, options: nil, animations: {
            
            self.buttonOdgTri.center.x += self.view.center.x * 2
            self.buttonOdgTri.alpha = 0.0
            
            } , completion: nil)
        
        UIView.animateWithDuration(0.5, delay: 0.4, usingSpringWithDamping: 0.9, initialSpringVelocity: 0.0, options: nil, animations: {
            
            self.buttonNext.enabled = true
            self.buttonNext.setTitleColor(UIColor.greenColor(), forState: UIControlState.Normal)
            
            } , completion: nil)
        
        enableZavrsetakKviza()
        
    }
    
    @IBAction func buttonOdgDvaAction(sender: AnyObject) {
        
        trenutniOdgovori[trenutnoPitanje] = 1;
        for i in 0..<pitanja.count {
            println(trenutniOdgovori[i])
        }
        UIView.animateWithDuration(0.5, delay: 0.2, usingSpringWithDamping: 0.9, initialSpringVelocity: 0.0, options: nil, animations: {
            
            self.buttonOdgJedan.center.x += self.view.center.x * 2
            self.buttonOdgJedan.alpha = 0.0
            
            
            }, completion: nil)
        
        UIView.animateWithDuration(0.5, delay: 0.2, usingSpringWithDamping: 0.9, initialSpringVelocity: 0.0, options: nil, animations: {
            

            
            }, completion: nil)
        
        UIView.animateWithDuration(0.5, delay: 0.4, usingSpringWithDamping: 0.9, initialSpringVelocity: 0.0, options: nil, animations: {
            
            self.buttonOdgTri.center.x += self.view.center.x * 2
            self.buttonOdgTri.alpha = 0.0
            
            } , completion: nil)
        
        UIView.animateWithDuration(0.5, delay: 0.4, usingSpringWithDamping: 0.9, initialSpringVelocity: 0.0, options: nil, animations: {
            
            self.buttonNext.enabled = true
            self.buttonNext.setTitleColor(UIColor.greenColor(), forState: UIControlState.Normal)
            
            } , completion: nil)
        
        enableZavrsetakKviza()
    }
    
    @IBAction func buttonOdgTriAction(sender: AnyObject) {
        
        trenutniOdgovori[trenutnoPitanje] = 2;
        for i in 0..<pitanja.count {
            println(trenutniOdgovori[i])
        }
        
        UIView.animateWithDuration(0.5, delay: 0.2, usingSpringWithDamping: 0.9, initialSpringVelocity: 0.0, options: nil, animations: {
            
            self.buttonOdgJedan.center.x += self.view.center.x * 2
            self.buttonOdgJedan.alpha = 0.0
            
            
            }, completion: nil)
        
        UIView.animateWithDuration(0.5, delay: 0.4, usingSpringWithDamping: 0.9, initialSpringVelocity: 0.0, options: nil, animations: {
            
            self.buttonOdgDva.center.x += self.view.center.x * 2
            self.buttonOdgDva.alpha = 0.0
            
            }, completion: nil)
        
        UIView.animateWithDuration(0.5, delay: 0.2, usingSpringWithDamping: 0.9, initialSpringVelocity: 0.0, options: nil, animations: {
            

            
            } , completion: nil)
        UIView.animateWithDuration(0.5, delay: 0.4, usingSpringWithDamping: 0.9, initialSpringVelocity: 0.0, options: nil, animations: {
            
            self.buttonNext.enabled = true
            self.buttonNext.setTitleColor(UIColor.greenColor(), forState: UIControlState.Normal)
            
            } , completion: nil)
        
            enableZavrsetakKviza()

    }
    
    func enableZavrsetakKviza() -> Void {
        if (buttonZavrsiKviz.hidden == false && svaPitanjaIspunjena()) {
            self.buttonZavrsiKviz.enabled = true
            self.buttonZavrsiKviz.setTitleColor(UIColor.greenColor(), forState: UIControlState.Normal)
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {

        if (segue.identifier == "segueKvizRjesenja") {
            
            let viewController : KvizRjesenjaTableViewController = segue.destinationViewController as! KvizRjesenjaTableViewController

            
            
            viewController.pitanja = pitanja
            viewController.trenutniOdgovori = trenutniOdgovori
        }
    }


}
