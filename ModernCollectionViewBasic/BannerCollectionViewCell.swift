//
//  BannerCollectionViewCell.swift
//  RxSwiftPrctice
//
//  Created by 김시종 on 7/25/24.
//

import UIKit
import SnapKit
import Kingfisher


class BannerCollectionViewCell: UICollectionViewCell {
    static let id = "BannerCollectionViewCell"
    
    let titleLabel = UILabel()
    let backgroundImage = UIImageView()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .blue
        setUI()
        
    }
    
    private func setUI() {
        self.addSubview(titleLabel)
        self.addSubview(backgroundImage)
        
        titleLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        
        backgroundImage.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    public func config(title: String, imageUrl: String) {
        titleLabel.text = title
        
        let url = URL(string: imageUrl)
        backgroundImage.kf.setImage(with: url)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
