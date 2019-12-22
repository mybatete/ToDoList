//
//  ToDoDetailTableViewController.swift
//  ToDoList
//
//  Created by Marc Batete on 11/13/19.
//  Copyright © 2019 Marc Batete. All rights reserved.
//

import UIKit

class ToDoDetailTableViewController: UITableViewController {
    
    var todo: ToDo?
    //step 18
    var isPickerHidden = true
    let dateLabelIndexPath = IndexPath(row: 0, section: 1)
    let datePickerIndexPath = IndexPath(row: 1, section: 1)
    let notesTextViewIndexPath = IndexPath(row: 0, section: 2)
    
    let normalCellHeight: CGFloat = 44
    let largeCellHeight: CGFloat = 200
    //page 762
//step 9
    @IBOutlet var titleTextField: UITextField!
    @IBOutlet var isCompleteButton: UIButton!
    @IBOutlet var dueDateLabel: UILabel!
    @IBOutlet var dueDatePickerView: UIDatePicker!
    @IBOutlet var notesTextView: UITextView!
    @IBOutlet var saveButton: UIBarButtonItem!
    //12 create an action
    @IBAction func textEditingChanged(_ sender: UITextField) {
        updateSaveButtonState()
    }
    
    
    
    
    //step 13
    @IBAction func returnPressed(_ sender: UITextField) {
    titleTextField.resignFirstResponder()
    }
    
    // step 14
    @IBAction func isCompleteButtonTapped(_ sender: UIButton) {
        isCompleteButton.isSelected = !isCompleteButton.isSelected
    }
    
    
    @IBAction func datePickerChanged(_ sender: UIDatePicker) {
        updateDueDateLabel(date: dueDatePickerView.date)
    }
    
    //step 11
    func updateSaveButtonState() {
        let text = titleTextField.text ?? ""
        saveButton.isEnabled = !text.isEmpty
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
            if let todo = todo {
              navigationItem.title = "To-Do"
              titleTextField.text = todo.title
              isCompleteButton.isSelected = todo.isComplete
              dueDatePickerView.date = todo.dueDate
              notesTextView.text = todo.notes
            } else {
              dueDatePickerView.date = Date().addingTimeInterval(86400)//or 24*60*60
            }
        
        //step 16
        updateDueDateLabel(date: dueDatePickerView.date)
        //step 11 b
        updateSaveButtonState()
        
    }
    //step 17
    func updateDueDateLabel(date: Date) {
        dueDateLabel.text = ToDo.dueDateFormatter.string(from: date)
    }
    
    //step 19
    override func tableView(_ tableView: UITableView, heightForRowAt
    indexPath: IndexPath) -> CGFloat {
        switch indexPath {
        case datePickerIndexPath:
            return isPickerHidden ? 0 :
            dueDatePickerView.frame.height
        case notesTextViewIndexPath:
            return largeCellHeight
        default:
            return normalCellHeight
        }
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt
    indexPath: IndexPath) {
        if indexPath == dateLabelIndexPath {
            isPickerHidden = !isPickerHidden
            dueDateLabel.textColor = isPickerHidden ? .black :
            tableView.tintColor
            tableView.beginUpdates()
            tableView.endUpdates()
        }
    }
   override func prepare(for segue: UIStoryboardSegue, sender:
   Any?) {
    super.prepare(for: segue, sender: sender)
   
    guard segue.identifier == "saveUnwind" else { return }
   
    let title = titleTextField.text!
    let isComplete = isCompleteButton.isSelected
    let dueDate = dueDatePickerView.date
    let notes = notesTextView.text
    todo = ToDo(title: title, isComplete: isComplete, dueDate: dueDate, notes: notes)
   }

}
