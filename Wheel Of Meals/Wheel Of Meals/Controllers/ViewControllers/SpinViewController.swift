//
//  ViewController.swift
//  Wheel Of Meals
//
//  Created by Collin Rentz on 12/12/22.
//

import UIKit
import Lottie

class SpinViewController: UIViewController {
    
    
    @IBOutlet weak var spinButton: UIButton!
    
    
    
    @IBOutlet weak var myWheelAnimationView: LottieAnimationView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

        @IBAction func spinButtonTapped(_ sender: Any) {
            myWheelAnimationView.contentMode = .scaleAspectFit
            //        myWheelAnimationView.loopMode = .loop
            myWheelAnimationView.animationSpeed = 1
            myWheelAnimationView.play()
        }
        
    }
