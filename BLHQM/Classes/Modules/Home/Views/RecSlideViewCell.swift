//
//  RecSlideViewCell.swift
//  BLHQM
//
//  Created by XiaoBai on 2022/5/29.
//

import UIKit
private let space = 20*RATIO_WIDHT750
class RecSlideViewCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        initUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var slideItems: [HomeItemChildDatas] = .init() {
        didSet {
            collectionView.reloadData()
        }
    }
    //MARK: UI相关
    private func initUI() {
        contentView.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.edges.equalTo(0)
        }
    }
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let itemWidth = (KScreenWidth - space * 2 - 30.layoutFit) / 3 - 5.layoutFit
        layout.itemSize = CGSize(width: itemWidth, height: itemWidth * 5 / 4 - 0.5)
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 0, left: space, bottom: 0, right: space)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(RecSlideChildViewCell.self, forCellWithReuseIdentifier: "\(RecSlideChildViewCell.self)")
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()
}
extension RecSlideViewCell: UICollectionViewDelegate {
    
}
extension RecSlideViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let defaultCell = UICollectionViewCell()
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(RecSlideChildViewCell.self)", for: indexPath) as? RecSlideChildViewCell else {
            return defaultCell
        }
        cell.slideItem = slideItems[indexPath.row]
        return cell
    }
}
