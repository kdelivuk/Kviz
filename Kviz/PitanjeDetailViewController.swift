//
//  PitanjeDetailViewController.swift
//  Kviz
//
//  Created by Antonio Delivuk on 19/05/15.
//  Copyright (c) 2015 Kristijan Delivuk. All rights reserved.
//

import UIKit
import MediaPlayer

class PitanjeDetailViewController: UIViewController {
    
    var pitanje : PitanjeModel = PitanjeModel()
    
    var moviePlayer : MPMoviePlayerController!
    
    @IBOutlet weak var textPitanje: UILabel!
    @IBOutlet weak var textOdgJedan: UILabel!
    @IBOutlet weak var textOdgDva: UILabel!
    @IBOutlet weak var textOdgTri: UILabel!
    @IBOutlet weak var textOdgTocan: UILabel!
    
    @IBOutlet var viewPitanjeDetail: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var pozadinaSlika = UIImage(named: "pozadina.jpg")
        var imageView = UIImageView(frame: self.view.bounds)
        imageView.image = pozadinaSlika
        imageView.contentMode = UIViewContentMode.ScaleAspectFill
        self.view.addSubview(imageView)
        self.view.sendSubviewToBack(imageView)
        
        
        // Load odgovora
        
        textPitanje.text = pitanje.pitanje
        textOdgJedan.text = pitanje.odgJedan
        textOdgDva.text = pitanje.odgDva
        textOdgTri.text = pitanje.odgTri
        textOdgTocan.text = pitanje.tocanOdgovor
        
        // Stilizacija
        
        stilizirajLabelu(textPitanje)
        stilizirajLabelu(textOdgJedan)
        stilizirajLabelu(textOdgDva)
        stilizirajLabelu(textOdgTri)
        stilizirajLabelu(textOdgTocan)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func stilizirajLabelu ( labela : UILabel) {
        labela.textColor = UIColor.redColor()
        labela.backgroundColor = UIColor.whiteColor().colorWithAlphaComponent(0.7)

    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
