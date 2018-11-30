//
//  ViewController.swift
//  MiglaniSrishtiHW4
//
//  Created by Srishti on 14/10/18.
//  Copyright © 2018 Srishti Miglani. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var QuestionLabel: UILabel!
    var fadeOutAnimator: UIViewPropertyAnimator?
    var fadeInAnimator: UIViewPropertyAnimator?
    var question = true
    
    @IBOutlet weak var doubleTap: UITapGestureRecognizer!
    @IBOutlet weak var singleTap: UITapGestureRecognizer!
    

    var sharedFlashcardsModel = FlashcardsModel.sharedInstance
    var index:Int = 0
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        if sharedFlashcardsModel.numberOfFlashcards() <= 0{
            QuestionLabel.text = "There are no more flashcards."                           ////////////no card
        }else{
            var curr = sharedFlashcardsModel.getCurrentIndex()
            print("curr, \(curr)")
            QuestionLabel.text = sharedFlashcardsModel.flashcard(atIndex: sharedFlashcardsModel.getCurrentIndex())?.getQuestion()
            curr = sharedFlashcardsModel.getCurrentIndex()
            print("curr, \(curr)")
        }
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
        if sharedFlashcardsModel.numberOfFlashcards() > 0{
            let randomCard = sharedFlashcardsModel.randomFlashcard()
            QuestionLabel.text = randomCard!.getQuestion()
        }
        else{
            QuestionLabel.text = "There are no more flashcards."                       ////////////no card
        }
        singleTap.require(toFail: doubleTap)
    }
    
    @IBAction func SingleTap(_ sender: UITapGestureRecognizer) {
        self.QuestionLabel.backgroundColor = UIColor.white
        self.QuestionLabel.textColor = UIColor.black
        self.QuestionLabel.layer.borderWidth = 0
        
        fadeOutAnimator = UIViewPropertyAnimator(duration: 3, curve: UIViewAnimationCurve.linear, animations: {()in
            self.QuestionLabel.alpha = 0
        })
        fadeOutAnimator?.addCompletion { (position) in
            if self.sharedFlashcardsModel.numberOfFlashcards() > 0{
                let randomCard = self.sharedFlashcardsModel.randomFlashcard()
                self.QuestionLabel.text = randomCard!.getQuestion()
            }else{
                self.QuestionLabel.text = "There are no more flashcards."               ////////////no card
            }
            let animator = UIViewPropertyAnimator(duration: 3, curve: .linear, animations: {()in
                self.QuestionLabel.alpha = 1
            })
            animator.startAnimation()
            
        }
        fadeOutAnimator?.startAnimation()

    }
    
    @IBAction func DoubleTap(_ sender: UITapGestureRecognizer) {
        //question = true
        fadeOutAnimator = UIViewPropertyAnimator(duration: 3, curve: UIViewAnimationCurve.linear, animations: {()in
            self.QuestionLabel.alpha = 0
        })
        fadeOutAnimator?.addCompletion { (position) in
            self.index = self.sharedFlashcardsModel.getCurrentIndex()
            if (self.sharedFlashcardsModel.numberOfFlashcards() > 0){
                if(self.question){
                    self.QuestionLabel.text = self.sharedFlashcardsModel.flashcard(atIndex: self.index)?.getAnswer()
                    self.question = false
                    self.QuestionLabel.backgroundColor = UIColor.purple
                    self.QuestionLabel.textColor = UIColor.white
                    self.QuestionLabel.layer.borderWidth = 10.0
                    self.QuestionLabel.layer.borderColor = UIColor.white.cgColor
                }else{
                    self.QuestionLabel.text = self.sharedFlashcardsModel.flashcard(atIndex: self.index)?.getQuestion()
                    self.question = true
                    self.QuestionLabel.backgroundColor = UIColor.white
                    self.QuestionLabel.textColor = UIColor.black
                    self.QuestionLabel.layer.borderWidth = 0
                }
            }
            else{
                if(self.question){
                    self.QuestionLabel.text = "Please add some flashcards"                 /////////////////no card
                    self.QuestionLabel.backgroundColor = UIColor.purple
                    self.QuestionLabel.textColor = UIColor.white
                    self.QuestionLabel.layer.borderWidth = 10.0
                    self.QuestionLabel.layer.borderColor = UIColor.white.cgColor
                    self.question = false
                }else{
                    self.QuestionLabel.text = "There are no more flashcards."             /////////////////no card
                    self.QuestionLabel.backgroundColor = UIColor.white
                    self.QuestionLabel.textColor = UIColor.black
                    self.QuestionLabel.layer.borderWidth = 0
                    self.question = true
                }
            }
            
            let animator = UIViewPropertyAnimator(duration: 3, curve: .linear, animations: {()in
                self.QuestionLabel.alpha = 1
            })
            animator.startAnimation()
            
        }
        fadeOutAnimator?.startAnimation()
        
    }
    
    
    @IBAction func RightSwipeGesture(_ sender: UISwipeGestureRecognizer) {
        self.QuestionLabel.backgroundColor = UIColor.white
        self.QuestionLabel.textColor = UIColor.black
        self.QuestionLabel.layer.borderWidth = 0
        
        fadeOutAnimator = UIViewPropertyAnimator(duration: 3, curve: UIViewAnimationCurve.linear, animations: {()in
            self.QuestionLabel.alpha = 0
        })
        fadeOutAnimator?.addCompletion { (position) in
            
            if self.sharedFlashcardsModel.numberOfFlashcards() > 0{
                self.QuestionLabel.text =   self.sharedFlashcardsModel.previousFlashcard()?.getQuestion()
            }else{
                self.QuestionLabel.text = "There are no more flashacards."              ////////////no card
            }

            let animator = UIViewPropertyAnimator(duration: 3, curve: .linear, animations: {()in
                self.QuestionLabel.alpha = 1
            })
            animator.startAnimation()
            
        }
        fadeOutAnimator?.startAnimation()
    }
    
    @IBAction func LeftSwipeGesture(_ sender: UISwipeGestureRecognizer) {
        self.QuestionLabel.backgroundColor = UIColor.white
        self.QuestionLabel.textColor = UIColor.black
        self.QuestionLabel.layer.borderWidth = 0
        
        fadeOutAnimator = UIViewPropertyAnimator(duration: 3, curve: UIViewAnimationCurve.linear, animations: {()in
            self.QuestionLabel.alpha = 0
        })
        fadeOutAnimator?.addCompletion { (position) in
            //self.QuestionLabel.text =   self.sharedFlashcardsModel.nextFlashcard()?.getQuestion()
            if self.sharedFlashcardsModel.numberOfFlashcards() > 0{
                self.QuestionLabel.text =   self.sharedFlashcardsModel.nextFlashcard()?.getQuestion()
            }else{
                self.QuestionLabel.text = "There are no more flashcards."                    ////////////no card
            }
            let animator = UIViewPropertyAnimator(duration: 3, curve: .linear, animations: {()in
                self.QuestionLabel.alpha = 1
            })
            animator.startAnimation()
            
        }
        fadeOutAnimator?.startAnimation()

    }
    
    
    
}
    



