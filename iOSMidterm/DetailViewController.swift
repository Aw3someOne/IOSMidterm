//
//  DetailViewController.swift
//  iOSMidterm
//
//  Created by Stephen Cheng on 2017-10-23.
//  Copyright © 2017 Stephen Cheng. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var detailDescriptionLabel: UILabel!


    func configureView() {
        // Update the user interface for the detail item.
        if let detail = detailItem {
            if let label = detailDescriptionLabel {
                label.text = detail.description
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        configureView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    var detailItem: Category? {
        didSet {
            // Update the view.
            configureView()
        }
    }

    var childViewController: NoteTableViewController?
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "NoteTableSegue" {
            if let childVC = segue.destination as? NoteTableViewController {
                childVC.detailItem = detailItem
                childViewController = childVC
            }
        }
    }
    @IBAction func createNoteButtonPressed(_ sender: Any) {
        if let category = detailItem {
            category.notes.insert(Note(title: "New Note", body: "Descriptive text here"), at: 0)
        }
        let indexPath = IndexPath(row: 0, section: 0)
        childViewController?.tableView.insertRows(at: [indexPath], with: .automatic)
    }
    
}

