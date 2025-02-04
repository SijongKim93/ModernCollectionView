//
//  NomalCaroselCollectionViewCell.swift
//  RxSwiftPrctice
//
//  Created by 김시종 on 7/26/24.
//

import UIKit


class NomalCaroselCollectionViewCell: UICollectionViewCell {
    static let id = "NomalCaroselCell"
    
    private let mainImage = UIImageView()
    private let titleLabel = UILabel()
    private let subTitleLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
    }
    
    private func setUI() {
        addSubview(mainImage)
        addSubview(titleLabel)
        addSubview(subTitleLabel)
        
        mainImage.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(80)
        }
        
        titleLabel.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.top.equalTo(mainImage.snp.bottom).offset(8)
        }
        
        subTitleLabel.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.top.equalTo(titleLabel.snp.bottom).offset(8)
        }
    }
    
    func config(imageUrl: String, title: String, subTitle: String?) {
        
        mainImage.kf.setImage(with: URL(string: imageUrl))
        titleLabel.text = title
        subTitleLabel.text = subTitle
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
