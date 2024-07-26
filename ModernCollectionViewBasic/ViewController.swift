//
//  ViewController.swift
//  RxSwiftPrctice
//
//  Created by 김시종 on 7/25/24.
//

import UIKit

class ViewController: UIViewController {
    
    let imageUrl = "https://static.onecms.io/wp-content/uploads/sites/43/2022/05/26/8805-CrispyFriedChicken-mfs-3x2-072.jpg"
    
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: .init())
    private var dataSource: UICollectionViewDiffableDataSource<Section, Item>?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
        
        collectionView.register(BannerCollectionViewCell.self, forCellWithReuseIdentifier: BannerCollectionViewCell.id)
        collectionView.register(NomalCaroselCollectionViewCell.self, forCellWithReuseIdentifier: NomalCaroselCollectionViewCell.id)
        collectionView.register(ListCarouselCollectionViewCell.self, forCellWithReuseIdentifier: ListCarouselCollectionViewCell.id)
        collectionView.setCollectionViewLayout(createLayout(), animated: true)
        
        setDataSource()
        setSnapShot()
    }
    
    private func setUI() {
        self.view.addSubview(collectionView)
        collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    private func setDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, Item>(collectionView: collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            switch itemIdentifier {
            case .banner(let item):
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BannerCollectionViewCell.id, for: indexPath) as? BannerCollectionViewCell else {
                    return UICollectionViewCell()
                }
                cell.config(title: item.title, imageUrl: item.imageUrl)
                return cell
                
            case .normalCarousel(let item):
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NomalCaroselCollectionViewCell.id, for: indexPath) as? NomalCaroselCollectionViewCell else {
                    return UICollectionViewCell()
                }
                cell.config(imageUrl: item.imageUrl, title: item.title, subTitle: item.subTitle)
                return cell
                
            case .listCarousel(let item):
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ListCarouselCollectionViewCell.id, for: indexPath) as? ListCarouselCollectionViewCell else {
                    return UICollectionViewCell()
                }
                cell.config(imageUrl: item.imageUrl, title: item.title, subTitle: item.subTitle)
                return cell
            default:
                return UICollectionViewCell()
            }
        })
    }
    
    private func setSnapShot() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Item>()
                
        snapshot.appendSections([Section(id: "Banner")])
        let bannerItems = [
            Item.banner(HomeItem(title: "교촌 치킨", imageUrl: imageUrl)),
            Item.banner(HomeItem(title: "굽네 치킨", imageUrl: imageUrl)),
            Item.banner(HomeItem(title: "프라닭 치킨", imageUrl: imageUrl))
        ]
       
        snapshot.appendItems(bannerItems, toSection: Section(id: "Banner"))
        
        let normalSection = Section(id: "NormalCarosel")
        snapshot.appendSections([normalSection])
        let normalItems = [
            Item.normalCarousel(HomeItem(title: "교촌 치킨", subTitle: "황금올리브", imageUrl: imageUrl)),
            Item.normalCarousel(HomeItem(title: "굽네 치킨", subTitle: "통닭다리", imageUrl: imageUrl)),
            Item.normalCarousel(HomeItem(title: "프라닭 치킨", subTitle: "맛있겠다1", imageUrl: imageUrl)),
            Item.normalCarousel(HomeItem(title: "1 치킨", subTitle: "맛있겠다2", imageUrl: imageUrl)),
            Item.normalCarousel(HomeItem(title: "프라2닭 치킨", subTitle: "맛있겠다3", imageUrl: imageUrl)),
            Item.normalCarousel(HomeItem(title: "프라닭3 치킨", subTitle: "맛있겠다4", imageUrl: imageUrl))
        ]
        snapshot.appendItems(normalItems, toSection: normalSection)
        
        let listSection = Section(id: "ListCarosel")
        snapshot.appendSections([listSection])
        let listItems = [
            Item.listCarousel(HomeItem(title: "치킨1", subTitle: "맛있다1", imageUrl: imageUrl)),
            Item.listCarousel(HomeItem(title: "치킨2", subTitle: "맛있다2", imageUrl: imageUrl)),
            Item.listCarousel(HomeItem(title: "치킨3", subTitle: "맛있다3", imageUrl: imageUrl)),
            Item.listCarousel(HomeItem(title: "치킨4", subTitle: "맛있다4", imageUrl: imageUrl)),
            Item.listCarousel(HomeItem(title: "치킨5", subTitle: "맛있다5", imageUrl: imageUrl)),
            Item.listCarousel(HomeItem(title: "치킨6", subTitle: "맛있다6", imageUrl: imageUrl)),
            Item.listCarousel(HomeItem(title: "치킨7", subTitle: "맛있다7", imageUrl: imageUrl))
        ]
        snapshot.appendItems(listItems, toSection: listSection)
        
        dataSource?.apply(snapshot)
    }
    
    private func createLayout() -> UICollectionViewCompositionalLayout {
        
        // 섹션 간 거리
        let config = UICollectionViewCompositionalLayoutConfiguration()
        config.interSectionSpacing = 30
        
        return UICollectionViewCompositionalLayout(sectionProvider: { [weak self] sectionIndex, _ in
            switch sectionIndex {
            case 0:
                return self?.createBannerSection()
            case 1:
                return self?.createNormalCarouselSection()
            case 2:
                return self?.createListCarouseSection()
            default:
                return self?.createBannerSection()
            }
            return self?.createBannerSection()
        }, configuration: config)
    }
    
    private func createBannerSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(200))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPaging
        return section
    }
    
    private func createNormalCarouselSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 15)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.7), heightDimension: .absolute(120))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20)
        section.orthogonalScrollingBehavior = .continuous
        return section
    }
    
    private func createListCarouseSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 15, leading: 0, bottom: 0, trailing: 0)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(250))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitem: item, count: 3)
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20)
        section.orthogonalScrollingBehavior = .continuous
        return section
    }
}


