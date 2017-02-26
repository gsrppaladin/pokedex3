//
//  PokemonDetailVC.swift
//  pokedex
//
//  Created by Sam Greenhill on 12/18/16.
//  Copyright © 2016 simplyAmazingMachines. All rights reserved.
//

import UIKit

class PokemonDetailVC: UIViewController {

    
    var pokemon: Pokemon!
    
    @IBOutlet weak var nameLbl: UILabel!

    @IBOutlet weak var mainImg: UIImageView!
    
    @IBOutlet weak var descriptionLbl: UILabel!
    
    
    @IBOutlet weak var typeLbl: UILabel!
    
    
    @IBOutlet weak var defenseLbl: UILabel!
    
    
    @IBOutlet weak var heightLbl: UILabel!
   
    @IBOutlet weak var pokedexLbl: UILabel!
    
    @IBOutlet weak var weightLbl: UILabel!
    
    @IBOutlet weak var attackLbl: UILabel!
    
    
    @IBOutlet weak var currentEvoImg: UIImageView!
    
    @IBOutlet weak var nextEvoImg: UIImageView!
    
    @IBOutlet weak var evoLbl: UILabel!
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

       nameLbl.text = pokemon.name.capitalized
    
        let img = UIImage(named: "\(pokemon.pokedexId)")
        
        mainImg.image = img
        currentEvoImg.image = img
        
        pokedexLbl.text = "\(pokemon.pokedexId)"
    
       pokemon.downloadPokemonDetails {
        
        print("Did arrive here")
        //whatever we write will only be called after the network call is complete.
        
        self.updateUI()
        }
        
    }

    func updateUI() {
        
        attackLbl.text = pokemon.attack
        defenseLbl.text = pokemon.defense
        heightLbl.text = pokemon.height
        weightLbl.text = pokemon.weight
        typeLbl.text = pokemon.type
        descriptionLbl.text = pokemon.description
        
        if pokemon.nxtEvolutionId == "" {
            evoLbl.text = "No Evolutions"
            nextEvoImg.isHidden = true
        } else {
            nextEvoImg.isHidden = false
            nextEvoImg.image = UIImage(named: pokemon.nxtEvolutionId)
            let str = "Next Evolution: \(pokemon.nxtEvolutionName) - LVL \(pokemon.nxtEvolutionLevel)"
            evoLbl.text = str
        }
        
        
        
        
    }
    
    
    
    
    @IBAction func backBtnPressed(_ sender: Any) {
         dismiss(animated: true, completion: nil)
    }

   
   
    

}
