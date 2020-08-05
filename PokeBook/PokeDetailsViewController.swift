//
//  PokeDetailsViewController.swift
//  PokeBook
//
//  Created by Эмиль Шалаумов on 02.08.2020.
//  Copyright © 2020 Emil Shalaumov. All rights reserved.
//

import UIKit

protocol PokeDetailsViewControllerProtocol: class {

}

class PokeDetailsViewController: UITableViewController {

	var presenter: PokeDetailsPresenterProtocol?

	init(urlString: String, title: String) {
		super.init(nibName: nil, bundle: nil)
		SceneAssembly.makePokeDetails(viewController: self, url: urlString)
		//presenter

		self.title = title
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	override func viewDidLoad() {
		super.viewDidLoad()

		view.backgroundColor = .white
		tableView.register(PicturesListTableViewCell.self, forCellReuseIdentifier: "PicsCell")
	}

	// MARK: - Table view data source

	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return 1
	}

	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		if indexPath.row < 1, let cell = tableView.dequeueReusableCell(withIdentifier: "PicsCell", for: indexPath) as? PicturesListTableViewCell {
			return cell
		}
		return UITableViewCell()
	}
}

extension PokeDetailsViewController: PokeDetailsViewControllerProtocol {
	
}
