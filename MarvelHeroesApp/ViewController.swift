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
    
    @IBOutlet weak var heroSearchBar: UISearchBar!
    
    
    
    private var heroesNames = ["Spiderman", "Hulk", "Antman", "Ironman", "Black Widow", "Captain Gringo"]
    
    //Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        heroListTableView.dataSource = self
        heroListTableView.register(UINib(nibName: "HeroeTableViewCell", bundle: nil), forCellReuseIdentifier: "HeroeTableViewCell")
        heroListTableView.register(UITableViewCell.self, forCellReuseIdentifier: "my-cell")
        
        //For interaction
        heroListTableView.delegate = self
        
    }


}

//Cell selected
extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Hero selected")
    }
}

extension ViewController: UITableViewDataSource{
    
    //Number of cells in our list
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return heroesNames.count
        
    }
    
    //What cell to show?
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HeroeTableViewCell", for: indexPath)
        
        if let newCell = cell as? HeroeTableViewCell {
            newCell.setupCell(name: heroesNames[indexPath.row], description: "I am the heroe #\(indexPath.row) expert in kung fu and spiders, lorem ipsum vem vet inte du, vem vet inte jag, vi vet ingenting nu, vi vet inget idag, du är en saga för god för at vara san! det e en saga i sig att vi funnits varann. vi kunde liga gärna aldrig nagonsin möts eller var vört mötte reden bestämt innan vi föts")
        }
        
        return cell
    }
}
