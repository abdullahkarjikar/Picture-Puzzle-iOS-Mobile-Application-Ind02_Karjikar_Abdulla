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
    
    @IBOutlet weak var showAnswer: UIButton!
    @IBOutlet weak var shuffle: UIButton!
    
    var solvedPuzzleCenters: [(CGFloat, CGFloat)] = []
    var currentStateImageCenters: [(CGFloat, CGFloat)] = []
    var imageArrays: [UIImageView] = []

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageViewArray()
        UpdateSolvedPuzzleCenters(isOrignialState: true)
        // Do any additional setup after loading the view.
    }
    
    func UpdateSolvedPuzzleCenters(isOrignialState: Bool){
        var temp : [(CGFloat, CGFloat)] = []
        
        for index in 0...19{
            temp.append((imageArrays[index].center.x, imageArrays[index].center.y))
        }
        
        if(isOrignialState){
            solvedPuzzleCenters = temp
        }else{
            currentStateImageCenters = temp
        }
    }

    @IBAction func TapHandler(_ sender: UITapGestureRecognizer) {
        
        let imageView = sender.view!
        let canSwapAndWith: ((CGFloat, CGFloat), Bool) = checkValidSwapAndGetCenter(imageCoordinate: imageView)
        
        if(canSwapAndWith.1){
            swapWithBlank(imageView: imageView)
        }
    }
    
    func swapWithBlank(imageView: UIView){
        let temp = (xCoordinate: imageView.center.x, yCoordinate: imageView.center.y)
        imageView.center.x = Img_1_1.center.x
        imageView.center.y = Img_1_1.center.y
        Img_1_1.center.x = temp.xCoordinate
        Img_1_1.center.y = temp.yCoordinate
    }
    
    @IBAction func demo(_ sender: Any) {
    }
    
    @IBAction func showHideAnswer(_ sender: UIButton) {
 
        if(sender.titleLabel?.text == "Show Answer"){
            UpdateSolvedPuzzleCenters(isOrignialState: false)
            updateImageCenters(imageCenter: solvedPuzzleCenters)
            sender.setTitle("Hide Answer", for: .normal)
        }else{
            updateImageCenters(imageCenter: currentStateImageCenters)
            sender.setTitle("Show Answer", for: .normal)
        }
    }
    
    func updateImageCenters(imageCenter: [(CGFloat, CGFloat)]){
        for index in 0...19{
            imageArrays[index].center.x = imageCenter[index].0
            imageArrays[index].center.y = imageCenter[index].1
        }
    }
    
    func checkValidSwapAndGetCenter(imageCoordinate: UIView) -> ((CGFloat, CGFloat), Bool){
        let center_x = imageCoordinate.center.x
        let center_y = imageCoordinate.center.y
        let blank_x = Img_1_1.center.x
        let blank_y = Img_1_1.center.y
        
        if(center_x - 93 == blank_x && center_y == blank_y ){
            return ((xCoordinate: blank_x, yCoordinate: blank_y), canSwap: true)
        }
        if(center_x + 93 == blank_x && center_y == blank_y ){
            return ((xCoordinate: blank_x, yCoordinate: blank_y), canSwap: true)
        }
        if(center_x == blank_x && center_y - 93 == blank_y ){
            return ((xCoordinate: blank_x, yCoordinate: blank_y), canSwap: true)
        }
        if(center_x == blank_x && center_y + 93 == blank_y ){
            return ((xCoordinate: blank_x, yCoordinate: blank_y), canSwap: true)
        }
        return ((xCoordinate: 0.00, yCoordinate: 0.00), canSwap: false)
    }
    
    func imageViewArray(){
        imageArrays.append(contentsOf: [Img_1_1, Img_1_2, Img_1_3, Img_1_4])
        imageArrays.append(contentsOf: [Img_2_1, Img_2_2, Img_2_3, Img_2_4])
        imageArrays.append(contentsOf: [Img_3_1, Img_3_2, Img_3_3, Img_3_4])
        imageArrays.append(contentsOf: [Img_4_1, Img_4_2, Img_4_3, Img_4_4])
        imageArrays.append(contentsOf: [Img_5_1, Img_5_2, Img_5_3, Img_5_4])
    }

}


