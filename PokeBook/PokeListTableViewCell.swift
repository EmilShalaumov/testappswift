//
//  PokeListTableViewCell.swift
//  PokeBook
//
//  Created by Эмиль Шалаумов on 02.08.2020.
//  Copyright © 2020 Emil Shalaumov. All rights reserved.
//

import UIKit

final class PokeListTableViewCell: UITableViewCell {

	let title: UILabel = {
		let titleLabel = UILabel()
		titleLabel.text = "Pokemon"
		titleLabel.translatesAutoresizingMaskIntoConstraints = false
		return titleLabel
	}()

	private var roundedView: UIView = {
		let roundedView = UIView()
		roundedView.backgroundColor = .gray
		roundedView.translatesAutoresizingMaskIntoConstraints = false
		roundedView.layer.cornerRadius = 8
		return roundedView
	}()

	private var spinner: UIActivityIndicatorView = {
		let spinner = UIActivityIndicatorView(style: .large)
		spinner.translatesAutoresizingMaskIntoConstraints = false
		spinner.color = .black
		return spinner
	}()

	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)

		backgroundColor = .white
		addSubview(roundedView)
		setupContraintsForRoundedView()

		roundedView.addSubview(title)
		setupConstraintsForTitle(with: roundedView)

		addSubview(spinner)
		setupConstraintsForSpinner()
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	func setIsLoading(_ isLoading: Bool) {
		roundedView.isHidden = isLoading
		selectionStyle = isLoading ? .none : .default
		if isLoading {
			spinner.startAnimating()
			return
		}
		spinner.stopAnimating()
	}

	// MARK: - Contraints

	private func setupConstraintsForTitle(with superView: UIView) {
		NSLayoutConstraint.activate([
			title.topAnchor.constraint(equalTo: superView.topAnchor, constant: 8),
			title.leftAnchor.constraint(equalTo: superView.leftAnchor, constant: 8),
			title.bottomAnchor.constraint(equalTo: superView.bottomAnchor, constant: -8)
		])
	}

	private func setupConstraintsForSpinner() {
		NSLayoutConstraint.activate([
			spinner.centerXAnchor.constraint(equalTo: centerXAnchor),
			spinner.centerYAnchor.constraint(equalTo: centerYAnchor)
		])
	}

	private func setupContraintsForRoundedView() {
		NSLayoutConstraint.activate([
			roundedView.topAnchor.constraint(equalTo: topAnchor, constant: 8),
			roundedView.leftAnchor.constraint(equalTo: leftAnchor, constant: 16),
			roundedView.rightAnchor.constraint(equalTo: rightAnchor, constant: -16),
			roundedView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8)
		])
	}

}
