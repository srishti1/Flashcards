//
//  Flashcard.swift
//  MiglaniSrishtiHW4
//
//  Created by Srishti on 16/10/18.
//  Copyright © 2018 Srishti Miglani. All rights reserved.
//

import Foundation

struct Flashcard {
    private var question:String
    private var answer:String
    public var isFavorite:Bool = false
    init(question: String, answer: String){
        self.question = question
        self.answer = answer
        
    }
    init(question: String, answer: String, isFavorite: Bool){
        self.question = question
        self.answer = answer
        self.isFavorite = isFavorite
    }
    func getQuestion()->String{
        return self.question
    }
    func getAnswer()->String {
        return self.answer
    }
    
}

