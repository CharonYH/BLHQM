//
//  HeaderItemsCollectionViewCell.swift
//  BLHQM
//
//  Created by XiaoBai on 2022/5/17.
//

import UIKit

class RecHeaderItemsViewCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.edges.equalTo(0)
        }
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // MARK: 数据相关
    var items: [HomeItemModel] = [] {
        didSet {
            collectionView.reloadData()
        }
    }
    // MARK: - properties
    private lazy var collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumLineSpacing = 0
        flowLayout.minimumInteritemSpacing = 25

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.backgroundColor = .white
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        // banner
        collectionView.register(RecHeaderItemViewCell.self, forCellWithReuseIdentifier: "\(RecHeaderItemViewCell.self)")
        return collectionView
    }()
}

extension RecHeaderItemsViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let defaultCell = UICollectionViewCell()
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(RecHeaderItemViewCell.self)", for: indexPath) as? RecHeaderItemViewCell else {
            return defaultCell
        }
        let model =  items[indexPath.row]
        cell.imgView.yh_setImage(with: model.viewP.iconUrl)
        cell.titleLbl.text = model.title
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
}

extension RecHeaderItemsViewCell: UICollectionViewDelegate {
    
}

extension RecHeaderItemsViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemCount = items.count
        let itemWidth = (Int(KScreenWidth) - 16 * 2 - 25 * (itemCount)) / itemCount
        return .init(width: itemWidth, height: itemWidth + 25)
    }
}
