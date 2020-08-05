//
//  PokeDetailsPresenter.swift
//  PokeBook
//
//  Created by Эмиль Шалаумов on 02.08.2020.
//  Copyright © 2020 Emil Shalaumov. All rights reserved.
//

import Foundation

protocol PokeDetailsPresenterProtocol {
	func loadPokeDetails()
}

final class PokeDetailsPresenter: PokeDetailsPresenterProtocol {

	private weak var view: PokeDetailsViewControllerProtocol?
	private let url: String
	private let api: PokemonApiProtocol

	init(view: PokeDetailsViewControllerProtocol, url: String, api: PokemonApiProtocol) {
		self.view = view
		self.url = url
		self.api = api
	}

	func loadPokeDetails() {
		
	}


	
}
