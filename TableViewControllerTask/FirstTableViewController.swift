//
//  FirstTableViewController.swift
//  TableViewControllerTask
//  The Project is about to select a food order to place. (Tableview Controller, Picker View, Data Passing by Protocol Delegate)
//  Created by Mac on 16/09/21.
//

import UIKit

class FirstTableViewController: UITableViewController, SecondViewControllerProtocol {
    func passDataToVC1(text: String?) {
        orderLbl.text = text
    }
    
    @IBOutlet weak var orderLbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Menu Bar"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector (tapToAdd))
        navigationItem.rightBarButtonItem?.tintColor = .black
    }
    
    
    @objc func tapToAdd() {
        
        if let vc2 = self.storyboard?.instantiateViewController(identifier: "SecondViewController") as? SecondViewController {
            vc2.delegateVC2 = self
            vc2.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: nil)
            vc2.navigationItem.rightBarButtonItem?.tintColor = .black
            self.navigationController?.pushViewController(vc2, animated: true)}
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
}
