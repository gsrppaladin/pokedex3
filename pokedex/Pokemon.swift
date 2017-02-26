//
//  Pokemon.swift
//  pokedex
//
//  Created by Sam Greenhill on 12/14/16.
//  Copyright © 2016 simplyAmazingMachines. All rights reserved.
//

import Foundation
import Alamofire

class Pokemon {
    
    private var _name: String!
    private var _pokedexId: Int!
    private var _description: String!
    private var _type:  String!
    private var _defense: String!
    private var _height: String!
    private var _weight: String!
    private var _attack: String!
    private var _nxtEvolutionTxt: String!
    private var _nxtEvoltionName: String!
    private var _nxtEvolutionId: String!
    private var _nxtEvolutionLevel: String!
    private var _pokemonURL: String!
    
    
    
    var nxtEvolutionLevel: String {
        if _nxtEvolutionLevel == nil {
            _nxtEvolutionLevel = ""
        }
        return _nxtEvolutionLevel
    }
    
    var nxtEvolutionId: String {
        if _nxtEvolutionId == nil {
            _nxtEvolutionId = ""
            
        }
        return _nxtEvolutionId
    }
    
    var nxtEvolutionName: String {
        if _nxtEvoltionName == nil {
            _nxtEvoltionName = ""
        }
        return _nxtEvoltionName
    }
    
    var description: String {
        if _description == nil {
            _description = ""
        }
        return _description
    }
    
    
    var type: String {
        if _type == nil {
            _type = ""
        }
        return _type
    }
    
    var defense: String {
        if _defense == nil {
            _defense = ""
        }
        return _defense
    }
    
    
    var height: String {
        if _height == nil {
            _height = ""
        }
        return _height
    }
    
    var weight: String {
        if _weight == nil {
            _weight = ""
        }
        return _weight
    }
    
    var attack: String {
        if _attack == nil {
            _attack = ""
        }
        return _attack
    }
    
    
    
    var nextEvolutionTxt: String {
        //this is so that if we ever get a blank string it won't crash.
        if _nxtEvolutionTxt == nil {
            
            _nxtEvolutionTxt = ""
            
            }
            return _nxtEvolutionTxt
        }
    
    
    
    
    
    
        
    var name: String {
        return _name
    }
    
    var pokedexId: Int {
        return _pokedexId
    }
    
    
    init(name: String, pokedexId: Int) {
        self._name = name
        self._pokedexId = pokedexId
        self._pokemonURL = "\(URL_Base)\(URL_POKEMON)\(self.pokedexId)/"
        
        
    }
    
    
    
    func downloadPokemonDetails(completed: @escaping DownloadComplete) {
        Alamofire.request(_pokemonURL).responseJSON { (response) in
            
            if let dict = response.result.value as? Dictionary<String, AnyObject> {
                
                if let weight = dict["weight"] as? String {
                    self._weight = weight
                }
                
                if let height = dict["height"] as? String {
                    self._height = height
                }
                
                if let attack = dict["attack"] as? Int {
                    self._attack = "\(attack)"
                }
                
                if let defense = dict["defense"] as? Int {
                    self._defense = "\(defense)"
                }
                
                print(self._weight)
                print(self._height)
                print(self._attack)
                print(self._defense)
                
                if let types = dict["types"] as? [Dictionary<String, String>] , types.count > 0 {
                    if let name = types[0]["name"] {
                        self._type = name.capitalized
                    }
                    if types.count > 1 {
                        
                        for x in 1..<types.count {
                            if let name = types[x]["name"] {
                                self._type! += "/\(name.capitalized)"
                            }
                        }
                    }
                    
                    print(self._type)
                    
                } else {
                    self._type = ""
                }
                
                
                if let descArr = dict["descriptions"] as? [Dictionary<String, String>] , descArr.count > 0 {
                    if let url = descArr[5]["resource_uri"] {
                        let descURL = "\(URL_Base)\(url)"
                        Alamofire.request(descURL).responseJSON(completionHandler: { (response) in
                            if let descDict = response.result.value as? Dictionary<String, AnyObject> {
                                if let description = descDict["description"] as? String {
                                    
                                    let newDescription = description.replacingOccurrences(of: "POKMON", with: "Pokemon")
                                   self._description = newDescription
                                    print(newDescription)
                                }
                            }
                            completed()
                        })
                    }
                } else {
                    self._description = ""
                }
                
                if let evolutions = dict["evolutions"] as? [Dictionary<String, AnyObject>] , evolutions.count > 0 {
                    if let nxtEvo = evolutions[0]["to"] as? String {
                        if nxtEvo.range(of: "mega") == nil {
                            self._nxtEvoltionName = nxtEvo
                            if let uri = evolutions[0]["resource_uri"] as? String {
                                let newString = uri.replacingOccurrences(of: "/api/v1/pokemon/", with: "")
                                let nxtEvoId = newString.replacingOccurrences(of: "/", with: "")
                                self._nxtEvolutionId = nxtEvoId
                                
                                if let lvlExist = evolutions[0]["level"] {
                                    if let lvl = lvlExist as? Int {
                                        self._nxtEvolutionLevel = "\(lvl)"
                                    }
                                } else {
                                    self._nxtEvolutionLevel = ""
                                }
                                
                            }
                        }
                    }
                    print(self.nxtEvolutionLevel)
                    print(self.nxtEvolutionName)
                    print(self.nxtEvolutionId)
                }
                
                
            }
                completed()
        }
        
        
    }
    
    
    
    
    
    
}

