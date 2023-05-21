//
//  HeroDetailViewController.swift
//  MarvelHeroesApp
//
//  Created by Oriol Comas Lluria on 21/5/23.
//

import UIKit

class HeroDetailViewController: UIViewController
{
    @IBOutlet weak var heroDetailImageView: UIImageView!
    
    @IBOutlet weak var heroDetailName: UILabel!
    
    @IBOutlet weak var heroDetailDescriptionText: UITextView!
    
    
    public var heroName: String?;
    
    public var heroSelected = MarvelHero(id: 0,name: "a", description: "b", thumbnail: MarvelImage(path: "c", fileExtension: "d"))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        heroDetailName.text = heroSelected.name
        heroDetailDescriptionText.text = heroSelected.description
        print(heroSelected.description)
        loadImage(withURL: heroSelected.thumbnail.path, ext: heroSelected.thumbnail.fileExtension)
      
        
        
    }
    func loadImage(withURL url: String, ext: String)
    {
        let secUrl = url.replacingOccurrences(of: "http://", with: "https://")
        
        guard let imageURL = URL(string: secUrl + "/standard_large." + ext) else {
            return
        }
        URLSession.shared.dataTask(with: imageURL){
            data, _, error in
            guard let data = data, error == nil else {
                return
            }
            DispatchQueue.main.async {
                let image = UIImage(data:data)
                self.heroDetailImageView.image = image
            }
        }.resume()
    }
}
