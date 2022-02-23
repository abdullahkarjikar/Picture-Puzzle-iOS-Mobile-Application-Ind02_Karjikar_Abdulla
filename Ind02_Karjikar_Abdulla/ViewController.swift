//
//  ViewController.swift
//  Ind02_Karjikar_Abdulla
//
//  Created by Abdulla Karjikar on 2/19/22.
//

import UIKit

class ViewController: UIViewController {

    // Images in first row
    @IBOutlet weak var Img_1_1: UIImageView!
    @IBOutlet weak var Img_1_2: UIImageView!
    @IBOutlet weak var Img_1_3: UIImageView!
    @IBOutlet weak var Img_1_4: UIImageView!
    
    // Images in second row
    @IBOutlet weak var Img_2_1: UIImageView!
    @IBOutlet weak var Img_2_2: UIImageView!
    @IBOutlet weak var Img_2_3: UIImageView!
    @IBOutlet weak var Img_2_4: UIImageView!
    
    // Images in third row
    @IBOutlet weak var Img_3_1: UIImageView!
    @IBOutlet weak var Img_3_2: UIImageView!
    @IBOutlet weak var Img_3_3: UIImageView!
    @IBOutlet weak var Img_3_4: UIImageView!
    
    // Images in fourth row
    @IBOutlet weak var Img_4_1: UIImageView!
    @IBOutlet weak var Img_4_2: UIImageView!
    @IBOutlet weak var Img_4_3: UIImageView!
    @IBOutlet weak var Img_4_4: UIImageView!
    
    // Images in fifth row
    @IBOutlet weak var Img_5_1: UIImageView!
    @IBOutlet weak var Img_5_2: UIImageView!
    @IBOutlet weak var Img_5_3: UIImageView!
    @IBOutlet weak var Img_5_4: UIImageView!
    
    // Outlets for buttons
    @IBOutlet weak var showAnswer: UIButton!
    @IBOutlet weak var shuffle: UIButton!
    
    // Array to store initial/solved image coordinates
    var solvedPuzzleCenters: [CGPoint] = []
    
    // Array to store current coordinates of images when user taps on "Show Answer"
    var currentStateImageCenters: [CGPoint] = []
    
    // Array to of all ImageViews. This will be initialized in "viewDidLoad()" while starting the app
    var imageArrays: [UIImageView] = []

    /*
     Below function during App Startup
     */
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // This will initialize "imageArrays" with all UIImageViews
        imageViewArray()
        
        // This initializes "solvedPuzzle" center with initial/solved puzzle coordinates
        UpdateSolvedPuzzleCenters(isOrignialState: true)
    }
    
    /*
     Create Array of all tiles/ImageViews
     */
    func imageViewArray(){
        imageArrays.append(contentsOf: [Img_1_1, Img_1_2, Img_1_3, Img_1_4])
        imageArrays.append(contentsOf: [Img_2_1, Img_2_2, Img_2_3, Img_2_4])
        imageArrays.append(contentsOf: [Img_3_1, Img_3_2, Img_3_3, Img_3_4])
        imageArrays.append(contentsOf: [Img_4_1, Img_4_2, Img_4_3, Img_4_4])
        imageArrays.append(contentsOf: [Img_5_1, Img_5_2, Img_5_3, Img_5_4])
    }
    
    /*
     This function updates either  "solvedPuzzleCenters" with solved coordinates or updates "currentStateImageCenters" with current state when user taps "ShowAnswer". isOriginalState is true only when this function is called initially in viewDidLoad()
     */
    func UpdateSolvedPuzzleCenters(isOrignialState: Bool){
        
        // Creating and appending Center of ImageView
        var temp : [CGPoint] = []
        for index in 0...19{
            temp.append(CGPoint(x: imageArrays[index].center.x, y: imageArrays[index].center.y))
        }
        
        // Only once isOrginalState is true i.e. initially. Later isOriginal is always false which will store current ImageView Centers which will be used to restore puzzle to state before  tapping "Show Answer"
        if(isOrignialState){
            solvedPuzzleCenters = temp
        }else{
            currentStateImageCenters = temp
        }
    }
    
    /*
     This single function is linked with all ImageView having TapGestureRecognizer.
     */
    @IBAction func TapHandler(_ sender: UITapGestureRecognizer) {
        
        // User will be able to move tile if and only if he is not viewing the answer of the puzzle
        if (showAnswer.titleLabel?.text != "Hide Answer"){
            let imageView = sender.view!
            
            // CanSwapAndWith is a tupple. First part holds the coordinate with which the blank image can be swapped. Second part holds a boolean value which identifies if the tap image should be swapped. This code is implemented to swap only tiles which are adjacent to blank tile.
            let canSwapAndWith: ((CGFloat, CGFloat), Bool) = checkIfImageCanBeSwappedAndWithWhichTile(imageCoordinate: imageView)
            
            // Checking if a valid swap is possible. If yes then swap it with blank image.
            if(canSwapAndWith.1){
                swapWithBlank(imageView: imageView)
                
                // If puzzle is solved then button with "ShowAnswer" Label is changed to "Puzzle Solved! Play Again". This function is invoked everytime a tile is swapped.
                if(isPuzzleSolved()){
                    showAnswer.setTitle("Puzzle Solved! Play Again", for: .normal)
                    showAnswer.setTitleColor(UIColor.systemPink, for: .normal)
                    showAnswer.titleLabel?.font = UIFont.systemFont(ofSize: 20)
                } else {
                    showAnswer.setTitle("Show Answer", for: .normal)
                    showAnswer.setTitleColor(UIColor.white, for: .normal)
                    showAnswer.titleLabel?.font = UIFont.systemFont(ofSize: 20)
                }
            }
        }
        
    }
    
    /*
     isPuzzleSolved compares coordinates of ImageViews with solvedPuzzleCenters after a tile is swapped in Puzzle.
     */
    func isPuzzleSolved() -> Bool{
        
        // Comparing center of imageview in current position with solvedImageView centers for all image views and return false if it is not in solved state.
        for index in 0...19{
            if(imageArrays[index].center.x != solvedPuzzleCenters[index].x || imageArrays[index].center.y != solvedPuzzleCenters[index].y){
                return false
            }
        }
        
        // Image is solved if every imageview coordinates matches with original/initial state. i.e. IsImageViewInSolvedState does not contain any false values
        return true
    }
    
    /*
     This function simply swaps the blank tile with selected tile. temp contains coordinates of tile which is to be swapped with blank tile.
     */
    func swapWithBlank(imageView: UIView){
        let temp = (xCoordinate: imageView.center.x, yCoordinate: imageView.center.y)
        imageView.center.x = Img_1_1.center.x
        imageView.center.y = Img_1_1.center.y
        Img_1_1.center.x = temp.xCoordinate
        Img_1_1.center.y = temp.yCoordinate
    }
    
    /*
     This function is invoked everytime ShowAnswer button is tapped
     */
    @IBAction func showHideAnswer(_ sender: UIButton) {
        
        // If user taps "ShowAnswer", then storing current coordinates of image with UpdateSolvedPuzzleCenters() and updating all image view center with solvedPuzzleCenters. Also changing button label to "Hide Answer"
        if(sender.titleLabel?.text == "Show Answer"){
            UpdateSolvedPuzzleCenters(isOrignialState: false)
            updateImageCenters(imageCenter: solvedPuzzleCenters)
            sender.setTitle("Hide Answer", for: .normal)
            sender.titleLabel?.textColor = UIColor.white
            sender.titleLabel?.font = UIFont.systemFont(ofSize: 20)
            
            // If Puzzle is Solved, then tapping "Puzzle Solved! Play Again" will invoke shufflePuzzle function to shuffle the tiles in solvable manner and update button label with "Show Answer"
        } else if(sender.titleLabel?.text == "Puzzle Solved! Play Again"){
            shufflePuzzle(showAnswer)
            sender.setTitle("Show Answer", for: .normal)
            sender.titleLabel?.textColor = UIColor.white
            sender.titleLabel?.font = UIFont.systemFont(ofSize: 20)
            
            // This code is executed if label is "Hide Answer" and loads then image view centers with saved image view center which were stored when "Show Answer" was tapped and change button label to "Show Answer"
        } else{
            updateImageCenters(imageCenter: currentStateImageCenters)
            sender.setTitle("Show Answer", for: .normal)
            sender.setTitleColor(UIColor.white, for: .normal)
            sender.titleLabel?.font = UIFont.systemFont(ofSize: 20)
            
        }
    }
    
    
    /*
     This function will shuffle the tile in solvable order
     */
    @IBAction func shufflePuzzle(_ sender: UIButton) {
        
        // If we are shuffling tiles after puzzle is solved change button label to "Show Answer"
        if(showAnswer.titleLabel?.text == "Puzzle Solved! Play Again"){
            showAnswer.setTitle("Show Answer", for: .normal)
            showAnswer.setTitleColor(UIColor.white, for: .normal)
            showAnswer.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        }
        
        // Randomly shuffling 50 to 60 times blank tile with randomly selected adjacent tile. At most blank tile can be valid swapped with 4 tiles and atleast with 2 tiles
        for _ in 1...Int.random(in: 15...25){
            swapWithBlank(imageView: validSwapCombinationsBasedOnBlankImage())
        }
    }
    
    /*
     This function updates image center with desired centers for all tiles
     */
    func updateImageCenters(imageCenter: [CGPoint]){
        for index in 0...19{
            imageArrays[index].center.x = imageCenter[index].x
            imageArrays[index].center.y = imageCenter[index].y
        }
    }
    
    /*
     This function will identify if the tapped image is adjacent(left, right, up, down) to the blank tile and if it is then return a tupple with coordinates of blank tile and a boolean flag indicating if the tile can be swaped with blank tile.
     */
    func checkIfImageCanBeSwappedAndWithWhichTile(imageCoordinate: UIView) -> ((CGFloat, CGFloat), Bool){
        let center_x = imageCoordinate.center.x
        let center_y = imageCoordinate.center.y
        
        // Blank Tile center point
        let blank_x = Img_1_1.center.x
        let blank_y = Img_1_1.center.y
        
        // Checking blank tile is on the left side of tapped tile
        if(center_x - 93 == blank_x && center_y == blank_y ){
            return ((xCoordinate: blank_x, yCoordinate: blank_y), canSwap: true)
        }
        
        // Checking blank tile is on the right side of tapped tile
        if(center_x + 93 == blank_x && center_y == blank_y ){
            return ((xCoordinate: blank_x, yCoordinate: blank_y), canSwap: true)
        }
        
        // Checking blank tile is above tapped tile
        if(center_x == blank_x && center_y - 93 == blank_y ){
            return ((xCoordinate: blank_x, yCoordinate: blank_y), canSwap: true)
        }
        
        // Checking blank tile is below tapped tile
        if(center_x == blank_x && center_y + 93 == blank_y ){
            return ((xCoordinate: blank_x, yCoordinate: blank_y), canSwap: true)
        }
        
        // Blank tile is not adjacent to tapped tile and cannot be swapped.
        return ((xCoordinate: 0.00, yCoordinate: 0.00), canSwap: false)
    }
    
    /*
     This function will identify with which all tiles blank tile can be swapped with. At max a blank tile can be swapped with 4 adjacent tiles and at minimum blank tile can be swapped with 2 adjacent tiles if the blank tile is in corner.
     */
    func validSwapCombinationsBasedOnBlankImage() -> UIView{
        
        // Blank Tile center point
        let blank_x = Img_1_1.center.x
        let blank_y = Img_1_1.center.y
        
        // Calculating coordinates of left, right, up, down tile and appending it to a list.
        let left = CGPoint(x: blank_x - 93 - 93, y: blank_y )
        let right = CGPoint(x: blank_x + 93, y: blank_y )
        let up = CGPoint(x: blank_x, y: blank_y - 93)
        let down = CGPoint(x: blank_x, y: blank_y + 93)
        let allValidSwapCenters: [CGPoint] = [left, right, up, down]
        
        // Array to store possible image with which blank can be swapped
        var possibleSwapCenters: [UIView] = []
        
        // This array will store at max 4 UIView object if the blank tile is not in corner or in sides and at max 2 UIView object if the blank tile is in corner with which the blank can be swapped.
        for index in 0...19{
            if(allValidSwapCenters.contains(CGPoint(x: imageArrays[index].center.x, y: imageArrays[index].center.y))){
                possibleSwapCenters.append(imageArrays[index])
            }
        }
        
        // Select and return a random tile with blank tile is to be swapped
        //print(possibleSwapCenters.count)
        return possibleSwapCenters.randomElement()!
    }
}
