//
//  MainMenuViewController.swift
//  Kviz
//
//  Created by Antonio Delivuk on 17/05/15.
//  Copyright (c) 2015 Kristijan Delivuk. All rights reserved.
//

import UIKit


class MainMenuViewController: UIViewController {

    @IBOutlet weak var labelKvizPodnaslov: UILabel!
    @IBOutlet weak var labelKvizNaslov: UILabel!
    @IBOutlet weak var buttonNovaIgra: UIButton!
    @IBOutlet weak var buttonUnosKviza: UIButton!
    @IBOutlet var viewMainMenu: UIView!



    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.labelKvizNaslov.alpha = 0
        self.labelKvizPodnaslov.alpha = 0
        
        // Button styles
       stilizirajGumb(buttonNovaIgra)  
        stilizirajGumb(buttonUnosKviza)
       
    }
    
    override func viewWillAppear(animated: Bool) {
        
        // Start position
        
        self.buttonNovaIgra.center.x -= self.view.center.x * 2
        self.buttonUnosKviza.center.x += self.view.center.x * 2
        self.labelKvizPodnaslov.center.y -= 167
        self.labelKvizNaslov.center.y -= 167
        
        // Animations
        
        UIView.animateWithDuration(0.5, delay: 0.9, usingSpringWithDamping: 0.9, initialSpringVelocity: 0.0, options: nil, animations: {
            
            self.labelKvizPodnaslov.center.y += 167

            self.labelKvizPodnaslov.alpha = 1
            
            }, completion: nil)
        
        UIView.animateWithDuration(1, delay: 1.3, usingSpringWithDamping: 0.4, initialSpringVelocity: 0.1, options: nil, animations: {

            self.labelKvizNaslov.center.y += 167
            
            self.labelKvizNaslov.alpha = 1

            
            }, completion: nil)
        
        UIView.animateWithDuration(0.5, delay: 0.5, usingSpringWithDamping: 0.9, initialSpringVelocity: 0.0, options: nil, animations: {
            
            self.buttonNovaIgra.center.x += self.view.center.x * 2
            
            }, completion: nil)
        
        UIView.animateWithDuration(0.5, delay: 0.7, usingSpringWithDamping: 0.9, initialSpringVelocity: 0.0, options: nil, animations: {
            
            self.buttonUnosKviza.center.x -= self.view.center.x * 2
            
            } , completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    // Custom functions
    
    func stilizirajGumb (objectname : UIButton) {
        objectname.layer.shadowColor = UIColor.blackColor().CGColor
        objectname.layer.shadowOffset = CGSizeMake(2, 2)
        objectname.layer.shadowRadius = 2
        objectname.layer.shadowOpacity = 0.5
    }
}
