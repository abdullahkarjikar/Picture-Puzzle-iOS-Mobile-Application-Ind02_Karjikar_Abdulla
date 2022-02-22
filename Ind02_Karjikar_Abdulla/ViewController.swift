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
    
    var solvedPuzzleCenters: [CGPoint] = []
    var currentStateImageCenters: [CGPoint] = []
    var imageArrays: [UIImageView] = []

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageViewArray()
        UpdateSolvedPuzzleCenters(isOrignialState: true)
    }
    
    func UpdateSolvedPuzzleCenters(isOrignialState: Bool){
        var temp : [CGPoint] = []
        
        for index in 0...19{
            temp.append(CGPoint(x: imageArrays[index].center.x, y: imageArrays[index].center.y))
        }
        
        if(isOrignialState){
            solvedPuzzleCenters = temp
        }else{
            currentStateImageCenters = temp
        }
    }

    @IBAction func TapHandler(_ sender: UITapGestureRecognizer) {
        if (showAnswer.titleLabel?.text == "Show Answer"){
            let imageView = sender.view!
            let canSwapAndWith: ((CGFloat, CGFloat), Bool) = checkValidSwapAndGetCenter(imageCoordinate: imageView)
            
            if(canSwapAndWith.1){
                swapWithBlank(imageView: imageView)
                if(isPuzzleSolved()){
                    showAnswer.setTitle("Puzzle Solved! Play Again", for: .normal)
                }
            }
//            let isSolved = isPuzzleSolved()
//            print("========IsPuzzleSovled: \(isSolved)")
        }
        
    }
    
    func isPuzzleSolved() -> Bool{
        var currentImageCoordinate: [Bool] = []
        //print("InPuzzledSolved ================")
        for index in 0...19{
            //print("Current Loc: \(imageArrays[index].center.x), \(imageArrays[index].center.y); Solved: \(solvedPuzzleCenters[index].x), \(solvedPuzzleCenters[index].y)")
            if(imageArrays[index].center.x != solvedPuzzleCenters[index].x || imageArrays[index].center.y != solvedPuzzleCenters[index].y){
                currentImageCoordinate.append(false)
            }
        }
        //print("============================\(currentImageCoordinate.count)")
        if(currentImageCoordinate.contains(false)){
            return false
        }
        return true
    }
    
    func swapWithBlank(imageView: UIView){
        let temp = (xCoordinate: imageView.center.x, yCoordinate: imageView.center.y)
        imageView.center.x = Img_1_1.center.x
        imageView.center.y = Img_1_1.center.y
        Img_1_1.center.x = temp.xCoordinate
        Img_1_1.center.y = temp.yCoordinate
    }
    
    @IBAction func showHideAnswer(_ sender: UIButton) {
 
        if(sender.titleLabel?.text == "Show Answer"){
            UpdateSolvedPuzzleCenters(isOrignialState: false)
            updateImageCenters(imageCenter: solvedPuzzleCenters)
            sender.setTitle("Hide Answer", for: .normal)
        } else if(sender.titleLabel?.text == "Puzzle Solved! Play Again"){
            shufflePuzzle(showAnswer)
            sender.setTitle("Show Answer", for: .normal)
        } else{
            updateImageCenters(imageCenter: currentStateImageCenters)
            sender.setTitle("Show Answer", for: .normal)
        }
    }
    
    @IBAction func shufflePuzzle(_ sender: UIButton) {
        for _ in 1...Int.random(in: 50...60){
            swapWithBlank(imageView: validSwapCombinationsBasedOnBlankImage())
        }
    }
    
    
    func updateImageCenters(imageCenter: [CGPoint]){
        for index in 0...19{
            imageArrays[index].center.x = imageCenter[index].x
            imageArrays[index].center.y = imageCenter[index].y
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
    
    func validSwapCombinationsBasedOnBlankImage() -> UIView{
        let blank_x = Img_1_1.center.x
        let blank_y = Img_1_1.center.y
        
        let left = CGPoint(x: blank_x - 93 - 93, y: blank_y )
        let right = CGPoint(x: blank_x + 93, y: blank_y )
        let up = CGPoint(x: blank_x, y: blank_y - 93)
        let down = CGPoint(x: blank_x, y: blank_y + 93)
        
        let allValidSwapCenters: [CGPoint] = [left, right, up, down]
        var possibleSwapCenters: [UIView] = []
        
        for index in 0...19{
            if(allValidSwapCenters.contains(CGPoint(x: imageArrays[index].center.x, y: imageArrays[index].center.y))){
                possibleSwapCenters.append(imageArrays[index])
            }
        }
        
        //print(possibleSwapCenters.count)
        return possibleSwapCenters.randomElement()!
    }
    
    func imageViewArray(){
        imageArrays.append(contentsOf: [Img_1_1, Img_1_2, Img_1_3, Img_1_4])
        imageArrays.append(contentsOf: [Img_2_1, Img_2_2, Img_2_3, Img_2_4])
        imageArrays.append(contentsOf: [Img_3_1, Img_3_2, Img_3_3, Img_3_4])
        imageArrays.append(contentsOf: [Img_4_1, Img_4_2, Img_4_3, Img_4_4])
        imageArrays.append(contentsOf: [Img_5_1, Img_5_2, Img_5_3, Img_5_4])
    }

}


