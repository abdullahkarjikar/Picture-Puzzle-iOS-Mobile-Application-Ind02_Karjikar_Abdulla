//
//  ViewController.swift
//  Ind02_Karjikar_Abdulla
//
//  Created by Abdulla Karjikar on 2/19/22.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var Img_1_1: UIImageView!
    @IBOutlet weak var Img_1_2: UIImageView!
    @IBOutlet weak var Img_1_3: UIImageView!
    @IBOutlet weak var Img_1_4: UIImageView!
    
    @IBOutlet weak var Img_2_1: UIImageView!
    @IBOutlet weak var Img_2_2: UIImageView!
    @IBOutlet weak var Img_2_3: UIImageView!
    @IBOutlet weak var Img_2_4: UIImageView!
    
    @IBOutlet weak var Img_3_1: UIImageView!
    @IBOutlet weak var Img_3_2: UIImageView!
    @IBOutlet weak var Img_3_3: UIImageView!
    @IBOutlet weak var Img_3_4: UIImageView!
    
    @IBOutlet weak var Img_4_1: UIImageView!
    @IBOutlet weak var Img_4_2: UIImageView!
    @IBOutlet weak var Img_4_3: UIImageView!
    @IBOutlet weak var Img_4_4: UIImageView!

    @IBOutlet weak var Img_5_1: UIImageView!
    @IBOutlet weak var Img_5_2: UIImageView!
    @IBOutlet weak var Img_5_3: UIImageView!
    @IBOutlet weak var Img_5_4: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func TapHandler(_ sender: UITapGestureRecognizer) {
        
        let temp : UIImageView = sender.view as! UIImageView
        print(temp.frame)
        
        print(Img_1_1.frame)
        
    }
    

}

