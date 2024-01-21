//
//  ViewController.swift
//  AutoSizeCollectionView
//
//  Created by Arjun Mohan on 21/01/24.
//

import UIKit

class ViewController: UIViewController {
    // MARK: - PROPERTIES
    lazy var autoSizeCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.contentInset = .zero
        collectionView.register(AutoSizeCollectionViewCell.self, forCellWithReuseIdentifier: cellIdentifier)
        collectionView.backgroundColor = .red
        collectionView.dataSource = self
        collectionView.delegate = self
        return collectionView
    }()
    private let dataSource: [String] = ["abc"]
    var viewmodel: AutoSizeViewModel

    // MARK: - LIFE CYCLE
    init(viewmodel: AutoSizeViewModel) {
        self.viewmodel = viewmodel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        self.viewmodel = AutoSizeViewModel()
        super.init(coder: coder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    // MARK: - CONFIG
    private func setupUI() {
        view.addSubview(autoSizeCollectionView)
        NSLayoutConstraint.activate(
            [
                autoSizeCollectionView.topAnchor.constraint(
                    equalTo: view.safeAreaLayoutGuide.topAnchor,
                    constant: 10
                ),
                autoSizeCollectionView.leadingAnchor.constraint(
                    equalTo: view.safeAreaLayoutGuide.leadingAnchor,
                    constant: 15
                ),
                autoSizeCollectionView.trailingAnchor.constraint(
                    equalTo: view.safeAreaLayoutGuide.trailingAnchor,
                    constant: -15
                ),
                autoSizeCollectionView.bottomAnchor.constraint(
                    equalTo: view.bottomAnchor
                )
            ]
        )
    }
}

// MARK: - COLLECTIONVIEW DATA SOURCE
extension ViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: cellIdentifier,
            for: indexPath
        ) as? AutoSizeCollectionViewCell else { return UICollectionViewCell() }
        cell.setupCell(text: dataSource[indexPath.row])
        viewmodel.calculateCellFrame(index: indexPath.row, cell: cell)
        return cell
    }
}

// MARK: - COLLECTIONVIEW DELEGATE
extension ViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    }
}

// MARK: - COLLETIONVIEW DELEGATE FLOW LAYOUT
extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let labelSize = viewmodel.getLabelHeight(text: dataSource[indexPath.item], collectionView: collectionView)
        return CGSize(width: (collectionView.frame.width - 20) / 2, height: labelSize.height)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 15
    }
}
