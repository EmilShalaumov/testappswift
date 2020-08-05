//
//  PokeListPresenter.swift
//  PokeBook
//
//  Created by Эмиль Шалаумов on 02.08.2020.
//  Copyright © 2020 Emil Shalaumov. All rights reserved.
//

import Foundation

protocol PokeListPresenterProtocol {
	func loadPokeList()
}

final class PokeListPresenter: PokeListPresenterProtocol {

	private var request: String? = "https://pokeapi.co/api/v2/pokemon?limit=30"
	private let api: PokemonApiProtocol

	private weak var view: PokeListViewControllerProtocol?

	init(view: PokeListViewControllerProtocol, api: PokemonApiProtocol) {
		self.view = view
		self.api = api
	}

	func loadPokeList() {
		guard let requestUrl = request else {
			return
		}

		api.getPokemonList(url: requestUrl) { next, pokemons in
			self.request = next
			if next == nil {
				self.view?.setDownloadCompleted()
			}
			if let pokemons = pokemons {
				self.view?.reloadPokemonList(with: pokemons.map { ($0.name.uppercased(), $0.url ?? "") })
			}
		}
	}
}
