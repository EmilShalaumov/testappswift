//
//  PokemonAPI.swift
//  PokeBook
//
//  Created by Эмиль Шалаумов on 02.08.2020.
//  Copyright © 2020 Emil Shalaumov. All rights reserved.
//

import Foundation

struct Pokemon: Decodable {
	let url: String?
	let name: String

	let id: String?
	let baseExperience: Int?
	let height: Int?
	let isDefault: Bool?
	let order: Int?
	let weight: Int?
}

protocol PokemonApiProtocol {
	func getPokemonList(url: String, completion: @escaping(String?, [Pokemon]?) -> Void)
}

final class PokemonApi: PokemonApiProtocol {

	private let session = URLSession.shared
	private typealias json = JSONSerialization

	private let decoder: JSONDecoder = {
		let decoder = JSONDecoder()
		decoder.keyDecodingStrategy = .convertFromSnakeCase
		return decoder
	}()

	func getPokemonList(url urlString: String, completion: @escaping (String?, [Pokemon]?) -> Void) {
		guard let url = URL(string: urlString) else {
			completion(nil, nil)
			return
		}

		var request = URLRequest(url: url)
		request.httpMethod = "GET"

		session.dataTask(with: request) { data, response, error in
			if let error = error {
				print("Pokemon list failed with \(error.localizedDescription)")
				completion(nil, nil)
				return
			}

			guard let response = response as? HTTPURLResponse else {
				print("Pokemon list response invalid")
				completion(nil, nil)
				return
			}

			guard let data = data, let jsonDict = try? json.jsonObject(with: data, options: .init())
				as? Dictionary<String, Any> else {
					return
			}

			if response.statusCode == 200 {
				var next: String?
				if let dictionary = jsonDict["next"],
					let nextString = dictionary as? String {
					next = nextString
				}

				var pokemons: [Pokemon]?
				if let dictionary = jsonDict["results"],
					let pokemonsArray = try? self.decoder.decode([Pokemon].self, from: json.data(withJSONObject: dictionary)) {
					pokemons = pokemonsArray
				}

				completion(next, pokemons)
				return
			}

			print("Pokemon list data is invalid")
			completion(nil, nil)

		}.resume()
	}

}
