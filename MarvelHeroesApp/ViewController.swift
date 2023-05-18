//
//  ViewController.swift
//  MarvelHeroesApp
//
//  Created by Oriol Comas Lluria on 18/5/23.
//

import UIKit

class ViewController: UIViewController {

    //References
    
    @IBOutlet weak var heroListTableView: UITableView!
    
    
    
    //Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        heroListTableView.dataSource = self
        heroListTableView.register(UITableViewCell.self, forCellReuseIdentifier: "my-cell")
        
        heroListTableView.delegate = self
        
    }


}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Cell selected")
    }
}

extension ViewController: UITableViewDataSource{
    
    //Number of rows
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
        
    }
    
    //What cell to show?
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "my-cell", for: indexPath)
        cell.textLabel?.text = "I am the heroe #\(indexPath.row)"
        
        return cell
    }
}
