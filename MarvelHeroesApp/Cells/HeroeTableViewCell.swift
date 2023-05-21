//
//  HeroeTableViewCell.swift
//  MarvelHeroesApp
//
//  Created by Oriol Comas Lluria on 19/5/23.
//

import UIKit

class HeroeTableViewCell: UITableViewCell {

    
    //referencces
    
    @IBOutlet weak var heroImageView: UIImageView!
    @IBOutlet weak var heroNameLabel: UILabel!
    @IBOutlet weak var heroDescriptionLabel: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        
        heroImageView.clipsToBounds = true
        
        //circular image
        heroImageView.layer.cornerRadius = heroImageView.frame.width/2
  
        
    }


    func setupCell(name: String, description: String){
        heroNameLabel.text = name
        heroDescriptionLabel.text = description
        
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
                self.heroImageView.image = image
            }
        }.resume()
    } 
    
}
