//
//  HeroDetailViewController.swift
//  MarvelHeroesApp
//
//  Created by Oriol Comas Lluria on 21/5/23.
//

import UIKit

class HeroDetailViewController: UIViewController
{
    //Hero info
    @IBOutlet weak var heroDetailImageView: UIImageView!
    
    @IBOutlet weak var heroDetailName: UILabel!
    
    @IBOutlet weak var heroDetailDescriptionText: UITextView!
    
    //Controlpage
    
    @IBOutlet weak var pageControl: UIPageControl!
    
    
    public var heroName: String?;
    
    public var heroSelected:  MarvelHero?
    //MarvelHero(id: 0,name: "a", description: "b", thumbnail: MarvelImage(path: "c", fileExtension: "d"))
    
    //buttons
    
    @IBOutlet weak var comicsButton: UIButton!
    
    @IBOutlet weak var SeriesButton: UIButton!
    
    @IBOutlet weak var LoreButton: UIButton!
    
    
    //func
    
    override func viewDidLoad() {
        super.viewDidLoad()
 
            heroDetailName.text = heroSelected?.name
            heroDetailDescriptionText.text = heroSelected?.description
            loadImage(withURL: (heroSelected?.thumbnail.path)!, ext: (heroSelected?.thumbnail.fileExtension)!)
        
        
        
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
    
    
    
    //Buttons actions
    
    @IBAction func ComicsButtonAction(_ sender: Any) {
        pageControl.currentPage = 0
        comicsButton.backgroundColor = UIColor.systemRed
        SeriesButton.backgroundColor = UIColor.systemGray
        LoreButton.backgroundColor = UIColor.systemGray
    }
    
    @IBAction func SeriesButtonAction(_ sender: Any) {
        pageControl.currentPage = 1
        SeriesButton.backgroundColor = UIColor.systemRed
        LoreButton.backgroundColor = UIColor.systemGray
        comicsButton.backgroundColor = UIColor.systemGray
    }
    
    @IBAction func LoreButtonAction(_ sender: Any) {
        pageControl.currentPage = 2
        LoreButton.backgroundColor = UIColor.systemRed
        SeriesButton.backgroundColor = UIColor.systemGray
        comicsButton.backgroundColor = UIColor.systemGray
    }
    
}
