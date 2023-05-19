//
//  HeroeTableViewCell.swift
//  MarvelHeroesApp
//
//  Created by Oriol Comas Lluria on 19/5/23.
//

import UIKit

class HeroeTableViewCell: UITableViewCell {

    
    //referencces
    
    @IBOutlet weak var heroImageView: UIView!
    @IBOutlet weak var heroNameLabel: UILabel!
    @IBOutlet weak var heroDescriptionLabel: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        heroImageView.clipsToBounds = true
        heroImageView.layer.cornerRadius = heroImageView.frame.width/2
        
        
    }


    func setupCell(name: String, description: String){
        heroNameLabel.text = name
        heroDescriptionLabel.text = description
        
    }
    
}
