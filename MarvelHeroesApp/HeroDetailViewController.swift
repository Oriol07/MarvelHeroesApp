//
//  HeroDetailViewController.swift
//  MarvelHeroesApp
//
//  Created by Oriol Comas Lluria on 21/5/23.
//

import UIKit

class HeroDetailViewController: UIViewController
{
   
    public var heroSelected = MarvelHero(id: 0,name: "a", description: "b", thumbnail: MarvelImage(path: "c", fileExtension: "d"))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}
