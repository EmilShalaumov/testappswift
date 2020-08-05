//
//  SceneAssembly.swift
//  PokeBook
//
//  Created by Эмиль Шалаумов on 02.08.2020.
//  Copyright © 2020 Emil Shalaumov. All rights reserved.
//

import Foundation

class SceneAssembly {

	static func makePokeList(viewController: PokeListViewController) {
		let presenter = PokeListPresenter(view: viewController, api: PokemonApi())
		viewController.presenter = presenter
	}

	static func makePokeDetails(viewController: PokeDetailsViewController, url: String) {
		let presenter = PokeDetailsPresenter(view: viewController, url: url, api: PokemonApi())
		viewController.presenter = presenter
	}
}
