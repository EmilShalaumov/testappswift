//
//  PokeListViewController.swift
//  PokeBook
//
//  Created by Эмиль Шалаумов on 02.08.2020.
//  Copyright © 2020 Emil Shalaumov. All rights reserved.
//

import UIKit

protocol PokeListViewControllerProtocol: class {
	func reloadPokemonList(with pokemons: [(String, String)])
	func setDownloadCompleted()
}

final class PokeListViewController: UITableViewController {

	var presenter: PokeListPresenterProtocol?
	
	private var pokemonModels: [(name: String, url: String)] = []
	private var downloadCompleted = false

	override func viewDidLoad() {
		super.viewDidLoad()

		title = "All Pokemons"
		tableView.register(PokeListTableViewCell.self, forCellReuseIdentifier: "PokemonCell")
		tableView.separatorStyle = .none
		view.backgroundColor = .white

		SceneAssembly.makePokeList(viewController: self)
	}

	// MARK: - Table view data source

	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		// #warning Incomplete implementation, return the number of rows
		return pokemonModels.count + (downloadCompleted ? 0 : 1)
	}

	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard let cell = tableView.dequeueReusableCell(withIdentifier: "PokemonCell", for: indexPath)
			as? PokeListTableViewCell else {
				return UITableViewCell()
		}

		let isLoadingCell = indexPath.row >= pokemonModels.count
		cell.setIsLoading(isLoadingCell)

		if !isLoadingCell {
			cell.title.text = pokemonModels[indexPath.row].name
		}
		return cell
	}

	override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
		if indexPath.row >= pokemonModels.count {
			presenter?.loadPokeList()
		}
	}

	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		let pokemon = pokemonModels[indexPath.row]
		let detailsViewController = PokeDetailsViewController(urlString: pokemon.url, title: pokemon.name)
		navigationController?.pushViewController(detailsViewController, animated: true)
	}
}

extension PokeListViewController: PokeListViewControllerProtocol {

	func reloadPokemonList(with pokemons: [(String, String)]) {
		self.pokemonModels += pokemons
		DispatchQueue.main.async {
			self.tableView.reloadData()
		}
	}

	func setDownloadCompleted() {
		downloadCompleted = true
	}
}
