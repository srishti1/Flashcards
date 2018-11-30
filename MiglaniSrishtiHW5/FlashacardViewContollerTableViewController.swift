//
//  FlashacardViewContollerTableViewController.swift
//  MiglaniSrishtiHW5
//
//  Created by Srishti on 04/11/18.
//  Copyright © 2018 Srishti Miglani. All rights reserved.
//

import UIKit

class FlashacardViewContollerTableViewController: UITableViewController {
    var sharedFlashcardsModel = FlashcardsModel.sharedInstance
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        self.navigationItem.leftBarButtonItem = self.editButtonItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return sharedFlashcardsModel.numberOfFlashcards()
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
     let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")!
     let flashcard = sharedFlashcardsModel.flashcard(atIndex: indexPath.row)
     cell.textLabel?.text = flashcard?.getQuestion()
     cell.detailTextLabel?.text = flashcard?.getAnswer()
     cell.textLabel?.numberOfLines = 0
     return cell
    }


    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */


    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            sharedFlashcardsModel.removeFlashcard(atIndex: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }


    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "AddFlashcard", let addViewController = segue.destination as? AddViewController{
            //addvc.msg = "type this...
            addViewController.message = "Enter information in the text view and text field"
            addViewController.completionHandler = {question, answer in
                if let question = question, let answer = answer{
                    self.sharedFlashcardsModel.insert(question: question, answer: answer, favorite: false)
                    self.tableView.reloadData() //because the data changed
                }
            }
            
        }
    }


}
