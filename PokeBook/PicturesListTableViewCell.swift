//
//  PicturesListTableViewCell.swift
//  PokeBook
//
//  Created by Эмиль Шалаумов on 02.08.2020.
//  Copyright © 2020 Emil Shalaumov. All rights reserved.
//

import UIKit

class PicturesListTableViewCell: UITableViewCell {

	private let collectionView: UICollectionView = {
		let layout = UICollectionViewFlowLayout()
		layout.scrollDirection = .horizontal
		layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
		layout.itemSize = CGSize(width: 180, height: 180)
		let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
		collectionView.backgroundColor = .blue
		collectionView.translatesAutoresizingMaskIntoConstraints = false
		return collectionView
	}()

	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		backgroundColor = .green

		addSubview(collectionView)
		setupConstraintsForCollectionView()

		collectionView.delegate = self
		collectionView.dataSource = self
		collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "PhotoItemCell")
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

	// MARK: - Constraints

	private func setupConstraintsForCollectionView() {
		NSLayoutConstraint.activate([
			collectionView.topAnchor.constraint(equalTo: topAnchor),
			collectionView.leftAnchor.constraint(equalTo: leftAnchor),
			collectionView.rightAnchor.constraint(equalTo: rightAnchor),
			collectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
			collectionView.heightAnchor.constraint(equalToConstant: 200)
		])
	}
}

extension PicturesListTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {

	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return 10
	}

	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoItemCell", for: indexPath)
		cell.backgroundColor = .black
		return cell
	}
}
