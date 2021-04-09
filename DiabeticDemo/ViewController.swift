//
//  ViewController.swift
//  DiabeticDemo
//
//  Created by Apple on 02/04/21.
//

import UIKit

class ViewController: UIViewController {
    
    private lazy var tipsHeaderView: TabularHeaderview = {
        let view = TabularHeaderview()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.setContentHuggingPriority(.required, for: .vertical)
        return view
    }()
    
    private lazy var separatorView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .separator
        view.setContentHuggingPriority(.defaultHigh, for: .vertical)
        return view
    }()
    
    private lazy var tipsListView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 20
        layout.minimumInteritemSpacing = 10
        layout.sectionInset = UIEdgeInsets(top: 20, left: 5, bottom: 20, right: 5)
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
        collectionView.register(TipsCell.self, forCellWithReuseIdentifier: "TipsCell")
        return collectionView
    }()
    
    private lazy var containerStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 5
        return stackView
    }()
    
    private var tips :[TipsCellModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tips.append(TipsCellModel(title: "Give a family favorite a healthy makeover by making meatballs with turkey and veggies.", subtitle: "Add ground turkey, cheese, zuccini and bread\n\nPut it on top of whole wheat pasta, Yum! sdsd sdhdsh dsnsdn dsnsdnsd dsnsd\nsdhdshsdhdshsdhsdhds dsnds dsdsds dsndsndsn\nsdhdshds dssd dsdsdjsdjdsj nsdsdsd.", isliked: false, isDisliked: false, isSaved: false))
        tips.append(TipsCellModel(title: "Give a family favorite a healthy makeover by making meatballs with turkey and veggies.", subtitle: "Add ground turkey, cheese, zuccini and bread\n\nPut it on top of whole wheat pasta, Yum! sdsd sdhdsh dsnsdn dsnsdnsd dsnsd\nsdhdshsdhdshsdhsdhds dsnds dsdsds dsndsndsn\nsdhdshds dssd dsdsdjsdjdsj nsdsdsd.", isliked: false, isDisliked: false, isSaved: false))
        tips.append(TipsCellModel(title: "Give a family favorite a healthy makeover by making meatballs with turkey and veggies.", subtitle: "Add ground turkey, cheese, zuccini and bread\n\nPut it on top of whole wheat pasta, Yum! sdsd sdhdsh dsnsdn dsnsdnsd dsnsd\nsdhdshsdhdshsdhsdhds dsnds dsdsds dsndsndsn\nsdhdshds dssd dsdsdjsdjdsj nsdsdsd.", isliked: false, isDisliked: false, isSaved: false))
        setupView()
    }

    private func setupView() {
        view.addSubview(containerStackView)
        containerStackView.addArrangedSubview(tipsHeaderView)
        containerStackView.addArrangedSubview(separatorView)
        containerStackView.addArrangedSubview(tipsListView)
        containerStackView.setCustomSpacing(20, after: tipsHeaderView)
        NSLayoutConstraint.activate([
            containerStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            containerStackView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            containerStackView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            containerStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            separatorView.heightAnchor.constraint(equalToConstant: 1)
        ])
        tipsListView.dataSource = self
        tipsListView.delegate = self
    }
}

extension ViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tips.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TipsCell", for: indexPath) as! TipsCell
        cell.updateDetails(model: tips[indexPath.item])
        cell.delegate = self
        return cell
    }
}

extension ViewController: TipsCellDelegate {
    func didLikeClick(cell: TipsCell) {
        guard let indexPath = tipsListView.indexPath(for: cell) else { return }
        tips[indexPath.item].isliked = !tips[indexPath.item].isliked
        tipsListView.reloadItems(at: [indexPath])
    }
    
    func didDislikeClick(cell: TipsCell) {
        guard let indexPath = tipsListView.indexPath(for: cell) else { return }
        tips[indexPath.item].isDisliked = !tips[indexPath.item].isDisliked
        tipsListView.reloadItems(at: [indexPath])
    }
    
    func didSaveClick(cell: TipsCell) {
        guard let indexPath = tipsListView.indexPath(for: cell) else { return }
        tips[indexPath.item].isSaved = !tips[indexPath.item].isSaved
        tipsListView.reloadItems(at: [indexPath])
    }
    
}
