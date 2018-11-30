//
//  FlashcardsModel.swift
//  MiglaniSrishtiHW4
//
//  Created by Srishti on 16/10/18.
//  Copyright © 2018 Srishti Miglani. All rights reserved.
//

import Foundation
class FlashcardsModel: FlashcardsDataModel {
    // Swift Singleton pattern
    static let sharedInstance = FlashcardsModel()
    
    private var flashcards:[Flashcard]
    private var currentIndex:Int?
    private var favFlashcards:[Flashcard]
    
    private let kQuestionKey = "question"
    private let kAnswerKey = "answer"

    private var filePath: String
    //private var flashcards: [Flashcard]

    private var flashcardsDictionaries: [[String: String]]{
        var array = [[String: String]]()
        for flashcard in flashcards{
            let flashcardsDictionary = [
                kQuestionKey: flashcard.getQuestion(),
                kAnswerKey: flashcard.getAnswer()
            ]
            array.append(flashcardsDictionary)
        }

        return array
    }

    init() {
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let documentDirectory = paths.first!
        favFlashcards = []
        filePath = "\(documentDirectory)/flashcards.plist"
        if let flashcardsDictionaries = NSArray(contentsOfFile: filePath) as? [[String: String]]{
            flashcards = [Flashcard]()

            for flashcardDictionary in flashcardsDictionaries{
                let flashcard = Flashcard(question:flashcardDictionary[kQuestionKey]!, answer: flashcardDictionary[kAnswerKey]!)
                flashcards.append(flashcard)
            }
            // Else pre-populate our quotes array
        } else {
    
            flashcards = [
            Flashcard(question: "Which Pixar movie takes place in an 11 years old girl's mind?", answer: "Inside Out"),
            Flashcard(question: "Name the movie in which an old man loses his beloved wife and flies his house to their dream spot.", answer: "Up"),
            Flashcard(question: "In which movie, does a father fish loses his son and searches the ocean for him?", answer: "Finding Nemo"),
            Flashcard(question: "Name the movie in which a rat who wants to cook devises a plan with a human to get him in to the best restaurant in that country.", answer: "Ratatouille"),
            Flashcard(question: "Name the movie in which a young princess doesn't want to be queen and turns her mother into a bear.", answer: "Brave")]
            currentIndex = 0
        }
        
        
    }
    // Returns number of flashcards in model
    func numberOfFlashcards() -> Int {
        return flashcards.count
    }
    
    //returns a random flashcard
    func randomFlashcard() -> Flashcard? {
        if numberOfFlashcards() <= 0{
            currentIndex = nil
            return nil
        }
        var randomumber = Int(arc4random_uniform(UInt32(flashcards.count)))
        while randomumber == currentIndex && flashcards.count>1 {
            randomumber = Int(arc4random_uniform(UInt32(flashcards.count)))
        }
        currentIndex = randomumber
        return flashcards[randomumber]
        
    }
    
    func flashcard(atIndex: Int) -> Flashcard? {
        //currentIndex = atIndex
        //return flashcards[atIndex]
        if (atIndex >= 0 && atIndex < numberOfFlashcards()){
            return flashcards[atIndex]
        }
            return nil
    }
    
    func nextFlashcard() -> Flashcard? {
        if(flashcards.count == 0)
        {
            currentIndex = nil
            return nil
        }
        if let y = currentIndex{
            if(y < flashcards.count - 1){
                currentIndex = y + 1
                return flashcards[currentIndex!]
            }
            else{
                currentIndex = 0
                return flashcards[0]
            }

        }
        return nil
    }
    
    func previousFlashcard() -> Flashcard? {
        if(flashcards.count == 0)
        {
            currentIndex = nil
            return nil
        }
        if let y = currentIndex{
            if y > 0 {
                currentIndex = y - 1
                return flashcards[currentIndex!]
            }else{
                currentIndex = flashcards.count-1
                return flashcards[flashcards.count-1]
            }
            
        }
        return nil
    }
    
    func insert(question: String, answer: String, favorite: Bool) {
        flashcards.append(Flashcard(question: question, answer: answer, isFavorite: favorite))
        if numberOfFlashcards() == 1 { //only card 0
            currentIndex = 0 //first card
        }
        
        save()
    }
    
    func insert(question: String, answer: String, favorite: Bool, atIndex: Int) {
        //if atIndex < flashcards.count &&
        if atIndex >= 0{
            flashcards.insert(Flashcard(question: question, answer: answer), at: atIndex)
            if numberOfFlashcards() == 1{ //only card 0
                currentIndex = 0 //first card, this value was nil before
            }
        }
        save()
    }
    
    func removeFlashcard() {
        if numberOfFlashcards() > 0{
            flashcards.removeLast()
        }
        if numberOfFlashcards() > 1{
            currentIndex = numberOfFlashcards() - 1  // set it to one before
        }else if numberOfFlashcards() == 1{
            currentIndex = 0  //only one card
        }else{
            currentIndex = nil //nothing left
        }
        save()
    }
    
    func removeFlashcard(atIndex: Int) {
        if atIndex < flashcards.count  && atIndex >= 0{
            flashcards.remove(at: atIndex)
            if numberOfFlashcards() > 1 && atIndex >= 1{
                currentIndex = atIndex - 1 // set it to one before
            }else if numberOfFlashcards() > 1 && atIndex == 0{
                currentIndex = numberOfFlashcards() - 1 //if there are more than one cards and atIndex is 0, set currIndex to last one
            }
            else if numberOfFlashcards() == 1 {
                currentIndex = 0  //only one card
            }else{
                currentIndex = nil //nothing left
            }
        }
        save()
    }
    
    func toggleFavorite() {
        
        if let y = currentIndex{
            if flashcards[y].isFavorite == false{
                flashcards[y].isFavorite = true
            }
            else{
                flashcards[y].isFavorite = false
            }
            
        }

    }
    
    func favoriteFlashcards() -> [Flashcard] {
        return flashcards.filter({ $0.isFavorite })
    }
    func getCurrentIndex()->Int{
        if let y = currentIndex{
            return y
        }
        return -1

    }
    private func save(){
        (flashcardsDictionaries as NSArray).write(toFile: filePath, atomically: true)
    }

}

