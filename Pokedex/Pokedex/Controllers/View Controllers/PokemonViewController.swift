//
//  PokemonViewController.swift
//  Pokedex
//
//  Created by Devin Singh on 1/21/20.
//  Copyright © 2020 Devin Singh. All rights reserved.
//

import UIKit

class PokemonViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet weak var pokeSearchBar: UISearchBar!
    @IBOutlet weak var spriteImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var baseXPLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    
    // MARK: - Lifecycle functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pokeSearchBar.delegate = self
    }
    
    // MARK: - Private Methods
    
    private func fetchSpriteAndUpdateViews(forPokemon pokemon: Pokemon) {
        // Jumps back to bg queue so we need to go back to the main queue
        PokemonControler.fetchSprite(forPokemon: pokemon) { (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let sprite):
                    self.nameLabel.text = pokemon.name
                    self.baseXPLabel.text = String(pokemon.baseXP)
                    self.idLabel.text = String(pokemon.id)
                    self.spriteImageView.image = sprite
                    
                case .failure(let error):
                    self.presentErrorToUser(localizedError: error)
                }
            }
        }
    }
}


// MARK: - UISearchbar Delegate

extension PokemonViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchTerm = searchBar.text, !searchTerm.isEmpty else {return}
        
        // We need to be on the main thread to update the UI so we need to switch to the main view.
        PokemonControler.fetchPokemon(forSearchTerm: searchTerm) { (result) in
            
            DispatchQueue.main.async {
                switch result {
                case .success(let pokemon):
                    self.fetchSpriteAndUpdateViews(forPokemon: pokemon)
                case .failure(let error):
                    self.presentErrorToUser(localizedError: error)
                }
            }
        }
    }
}
