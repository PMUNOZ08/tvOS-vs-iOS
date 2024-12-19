//
//  CollectionsController.swift
//  NSCoder_tvOS_UIKit
//
//  Created by Pedro on 2/11/24.
//

import UIKit
import Combine
import UnsplashApi
import NSCoder_tvOS_Domain

class CollectionsController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    typealias DataSource = UICollectionViewDiffableDataSource<CollectionSections, NSCPhoto>
    typealias CellRegistration = UICollectionView.CellRegistration<CollectionViewCell, NSCPhoto>
    typealias Snapshot = NSDiffableDataSourceSnapshot<CollectionSections, NSCPhoto>
    typealias SupplementaryRegistration = UICollectionView.SupplementaryRegistration
    <TitleSupplementaryView>
    
    private let viewModel: CollectionsViewModel
    private var cancellables: Set<AnyCancellable> = []
    private var dataSource: DataSource?
    
    let headerElementKind = "header-element-kind"
    
    init(viewModel: CollectionsViewModel = CollectionsViewModel()) {
        self.viewModel = viewModel
        super.init(nibName: String(describing: CollectionsController.self), bundle: nil)
    }
    
    override var preferredFocusEnvironments: [any UIFocusEnvironment] {
        [collectionView]
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.restoresFocusAfterTransition = false
        configureCollectionView()
        setBinding()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadData()
    }
    
    func loadData() {
        Task {
            await viewModel.loadData()
        }
    }
    
    private func setBinding() {
        viewModel.$status.receive(on: RunLoop.main)
            .sink { [weak self] status in
                self?.statusChanged(status)
            }
            .store(in: &cancellables)
    }
    
    private func statusChanged(_ status: CollectionStatus) {
        switch status {
        case .updatedTechPhotos:
            var snapshot = Snapshot()
            snapshot.appendSections([.tech])
            snapshot.appendItems(viewModel.photos.tech)
            
            snapshot.appendSections([.mac])
            snapshot.appendItems(viewModel.photos.mac)
            
            snapshot.appendSections([.iphone])
            snapshot.appendItems(viewModel.photos.iphone)
            
            snapshot.appendSections([.appleTV])
            snapshot.appendItems(viewModel.photos.appleTV)
            
            snapshot.appendSections([.macintosh])
            snapshot.appendItems(viewModel.photos.macintosh)
            
            dataSource?.apply(snapshot, animatingDifferences: false)
            
        case .none, .failure, .loading:
            break
        }
    }
    
    private func configureCollectionView() {
        collectionView.delegate = self
        collectionView.collectionViewLayout = creeateLayout()
        // if there's no previous saved indexPath indexPathForPreferredFocusedView
        // is called if implemented
        collectionView.remembersLastFocusedIndexPath = true
        
        let nib = UINib(nibName: String(describing: CollectionViewCell.self), bundle: nil)
        let cellRegistration = CellRegistration(cellNib: nib) { cell, indexPath, photo in
            cell.configure(with: photo)
        }
     
        dataSource = DataSource(collectionView: collectionView) { collectionView, indexPath, photo in
            return collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: photo)
        }
        
        let supplementaryRegistration = SupplementaryRegistration(elementKind: headerElementKind) {
            (supplementaryView, string, indexPath) in
            supplementaryView.label.text = self.viewModel.titleFor(section: indexPath.section)
        }
        
        dataSource?.supplementaryViewProvider = { (view, kind, index) in
            return self.collectionView.dequeueConfiguredReusableSupplementary(
                using: supplementaryRegistration, for: index)
        }
    }
}

extension CollectionsController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let photo = viewModel.photo(at: indexPath) else {
            return
        }
        let detailVC = PhotoDetailController(photo: photo)
        present(detailVC, animated: true)
    }
    
    // Allow to apply logic to a cell to get focus
    // if using TVCardView is neede to disable user interaction
    func collectionView(_ collectionView: UICollectionView, canFocusItemAt indexPath: IndexPath) -> Bool {
       // return indexPath.row.isMultiple(of: 2)
        return true
    }
    
    func indexPathForPreferredFocusedView(in collectionView: UICollectionView) -> IndexPath? {
        return IndexPath(item: 2, section: 1)
    }
}

extension CollectionsController {
    private func creeateLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { sectionIndex, layoutEnvironment in
            let item = NSCollectionLayoutItem.init(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.95)))
            
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .absolute(450.0), heightDimension: .absolute(300)), subitems: [item])
            group.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0)
            
            let section = NSCollectionLayoutSection(group: group)
            section.orthogonalScrollingBehavior = .continuous
            
            let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(
                layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                  heightDimension: .estimated(44)),
                elementKind: self.headerElementKind,
                alignment: .top)
            section.boundarySupplementaryItems = [sectionHeader]
            
            return section
        }
        return layout
    }
}
