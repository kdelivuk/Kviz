//
//  MainMenuViewController.swift
//  Kviz
//
//  Created by Antonio Delivuk on 17/05/15.
//  Copyright (c) 2015 Kristijan Delivuk. All rights reserved.
//

import UIKit


class MainMenuViewController: UIViewController {

    @IBOutlet weak var labelKvizNaslov: UILabel!
    @IBOutlet weak var buttonNovaIgra: UIButton!
    @IBOutlet weak var buttonUnosKviza: UIButton!
    @IBOutlet var viewMainMenu: UIView!



    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Background
        
        var pozadinaSlika = UIImage(named: "pozadina.jpg")
        var imageView = UIImageView(frame: self.view.bounds)
        imageView.image = pozadinaSlika
        imageView.contentMode = UIViewContentMode.ScaleAspectFill
        self.view.addSubview(imageView)
        self.view.sendSubviewToBack(imageView)
        
        // Button styles
        
        stilizirajGumb(buttonUnosKviza)
        stilizirajGumb(buttonNovaIgra)
    }
    

    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)

        self.labelKvizNaslov.alpha = 0.0
        
        self.buttonNovaIgra.center.x -= self.view.center.x * 2
        self.buttonUnosKviza.center.x -= self.view.center.x * 2
        
        labelKvizNaslov.textColor = UIColor.redColor()
   

        // Animations
        
        UIView.animateWithDuration(0.5, delay: 0.0, usingSpringWithDamping: 0.9, initialSpringVelocity: 0.0, options: nil, animations: {
            
            self.labelKvizNaslov.alpha = 1.0
            
            }, completion: nil)
        
        UIView.animateWithDuration(0.5, delay: 0.5, usingSpringWithDamping: 0.9, initialSpringVelocity: 0.0, options: nil, animations: {
            
            self.buttonNovaIgra.center.x += self.view.center.x * 2
            
            }, completion: nil)
        
        UIView.animateWithDuration(0.5, delay: 0.7, usingSpringWithDamping: 0.9, initialSpringVelocity: 0.0, options: nil, animations: {
            
            self.buttonUnosKviza.center.x += self.view.center.x * 2
            
            } , completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func stilizirajGumb (objectname : UIButton) {
    
        objectname.backgroundColor = UIColor.clearColor()
        objectname.layer.cornerRadius = 3


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
