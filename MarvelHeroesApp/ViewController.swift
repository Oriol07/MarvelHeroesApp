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
    
    
    private var heroes = [MarvelHero]()
    private var filteredHeroes = [MarvelHero]()
    private var isSearching = false
    private var isPolling = false

    let limit = 20
    var lettersSearched = ""
    //Shared vars
    
    private var heroSelected = MarvelHero(id: 0,name: "a", description: "b", thumbnail: MarvelImage(path: "c", fileExtension: "d"))
    
    //Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        if(heroListTableView != nil)
        {
            heroListTableView.dataSource = self
            heroListTableView.register(UINib(nibName: "HeroeTableViewCell", bundle: nil), forCellReuseIdentifier: "HeroeTableViewCell")
            heroListTableView.register(UITableViewCell.self, forCellReuseIdentifier: "my-cell")
            
            //For interaction
            heroListTableView.delegate = self
            
            fetchHeroes()
        }
       /* if (heroDetailName != nil)
        {
            print("Hero selected2", heroSelected.name)
            heroDetailName.text = heroSelected.name
        } */
        
        
    }
    
    private func fetchHeroes()
    {
        
        MarvelAPI.fetchHeroes(startingWith: lettersSearched){[weak self] result in
                    switch result {
                    case .success(let fetchedHeroes):
                        self?.heroes = fetchedHeroes
                        DispatchQueue.main.async {
                            self?.heroListTableView.reloadData()
                        }
                    case.failure(let error):
                        print("Error fetching hero: \(error.localizedDescription)")
                    }
                    
                }
            
    
        
    }


}


//1. Table view
//Cell selected
extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        heroSelected = heroes[indexPath.row]
        print("Hero selected ", heroSelected.name)
        
        performSegue(withIdentifier: "heroe_detailed_segue", sender: heroSelected)
  
        
    }
}

extension ViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "heroe_detailed_segue",
           let destinationVC = segue.destination as? HeroDetailViewController,
                   let selectedHero = sender as? MarvelHero {
            destinationVC.heroSelected = selectedHero
            
        }
    }
}

//Data
extension ViewController: UITableViewDataSource{
    
    //Number of cells in our list
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isSearching {
            return filteredHeroes.count
        }
        else
        {
            return heroes.count
        }
    }
    
    //What cell to show?
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HeroeTableViewCell", for: indexPath)
        
        let hero: MarvelHero
        if isSearching {
            hero = filteredHeroes[indexPath.row]
        }
        else
        {
            hero = heroes[indexPath.row]
        }
        
        if let newCell = cell as? HeroeTableViewCell {
            newCell.setupCell(name: hero.name!, description: hero.description!)
            
            newCell.loadImage(withURL: hero.thumbnail.path, ext: hero.thumbnail.fileExtension)
            print ("URL: ", hero.thumbnail.path, hero.thumbnail.fileExtension )
            
        }
        
        return cell
    }
}

//2.Search
extension ViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredHeroes = heroes.filter {$0.name!.lowercased().contains(searchText.lowercased())}
        isSearching = !searchText.isEmpty
        heroListTableView.reloadData()
        
        if filteredHeroes.isEmpty {
            isPolling = true
            lettersSearched = searchText.lowercased()
            fetchHeroes()
            
        }
        else{
            isPolling = false
        }
        
    }
    
}


