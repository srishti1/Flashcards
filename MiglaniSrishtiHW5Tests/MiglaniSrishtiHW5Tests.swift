//
//  MiglaniSrishtiHW5Tests.swift
//  MiglaniSrishtiHW5Tests
//
//  Created by Srishti on 14/10/18.
//  Copyright © 2018 Srishti Miglani. All rights reserved.
//

import XCTest
@testable import MiglaniSrishtiHW5

class MiglaniSrishtiHW5Tests: XCTestCase {
    
    var sharedFlashcardsModel: FlashcardsModel!
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        sharedFlashcardsModel = FlashcardsModel()
    }
    
    func testInitializer(){
        XCTAssertEqual(sharedFlashcardsModel.numberOfFlashcards(),5)
        XCTAssertEqual(sharedFlashcardsModel.getCurrentIndex(), 0)
   
    }
    func testNumberOfFlashcards(){
        sharedFlashcardsModel.insert(question: ".", answer: ".", favorite: false)
        XCTAssertEqual(sharedFlashcardsModel.numberOfFlashcards(), 6)
   }
    func testRandomFlashcard(){
        _ = sharedFlashcardsModel.randomFlashcard()
        let index1 = sharedFlashcardsModel.getCurrentIndex()
        _ = sharedFlashcardsModel.randomFlashcard()
        let index2 = sharedFlashcardsModel.getCurrentIndex()
        XCTAssertTrue(index1 != index2)
        
    }
    func testFlashcardAtIndex(){
        _ = sharedFlashcardsModel.flashcard(atIndex: 2)
        XCTAssertEqual(sharedFlashcardsModel.getCurrentIndex(), 2)
        
    }
    func testNextFlashcard(){
        _ = sharedFlashcardsModel.nextFlashcard()
        XCTAssertEqual(sharedFlashcardsModel.getCurrentIndex(), 1)
        
    }
    func testPrevFlashcard(){
        _ = sharedFlashcardsModel.flashcard(atIndex: 3)
        _ = sharedFlashcardsModel.previousFlashcard()
        XCTAssertEqual(sharedFlashcardsModel.getCurrentIndex(), 2)
        
    }
    func testInsert(){
        XCTAssertEqual(sharedFlashcardsModel.numberOfFlashcards(), 5)
        sharedFlashcardsModel.insert(question: ".", answer: ".", favorite: false)
        XCTAssertEqual(sharedFlashcardsModel.numberOfFlashcards(), 6)
  
    }
    func testInsertAtIndex(){
        XCTAssertEqual(sharedFlashcardsModel.numberOfFlashcards(), 5)
        sharedFlashcardsModel.insert(question: ".", answer: ".", favorite: false, atIndex: 2)
        XCTAssertEqual(sharedFlashcardsModel.numberOfFlashcards(), 6)
 
    }
    func testRemove(){
        XCTAssertEqual(sharedFlashcardsModel.numberOfFlashcards(), 5)
        sharedFlashcardsModel.removeFlashcard()
        XCTAssertEqual(sharedFlashcardsModel.numberOfFlashcards(), 4)
        
    }
    func testRemoveAtIndex(){
        XCTAssertEqual(sharedFlashcardsModel.numberOfFlashcards(), 5)
        sharedFlashcardsModel.removeFlashcard(atIndex: 2)
        XCTAssertEqual(sharedFlashcardsModel.numberOfFlashcards(), 4)
        
    }
    func testToggleFavorite(){
        var flashcard1 = sharedFlashcardsModel.flashcard(atIndex: 0)
        XCTAssertEqual(flashcard1?.isFavorite, false)
        sharedFlashcardsModel.toggleFavorite()
        flashcard1 = sharedFlashcardsModel.flashcard(atIndex: 0)
        XCTAssertEqual(flashcard1?.isFavorite, true)

    }
    func testFavouriteFlashcards(){
        var number = sharedFlashcardsModel.favoriteFlashcards().count
        XCTAssertEqual(number, 0)
        sharedFlashcardsModel.insert(question: ".", answer: ".", favorite: true)
        number = sharedFlashcardsModel.favoriteFlashcards().count
        XCTAssertEqual(number, 1)

    }
    
    func testGetCurrentIndex(){
        _ = sharedFlashcardsModel.flashcard(atIndex: 4)
        XCTAssertEqual(sharedFlashcardsModel.getCurrentIndex(), 4)
        
    }
    
    func testSingleton(){
        let model1 = FlashcardsModel.sharedInstance
        let model2 = FlashcardsModel.sharedInstance
        XCTAssertTrue(model1 === model2)
        model1.insert(question: ".", answer: ".", favorite: false)
        XCTAssertEqual(model2.numberOfFlashcards(), 6)
    }
    
 
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
   
    
    
}
