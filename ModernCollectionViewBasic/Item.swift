//
//  Item.swift
//  RxSwiftPrctice
//
//  Created by 김시종 on 7/25/24.
//

import Foundation


struct Section: Hashable {
    let id: String
}


enum Item: Hashable {
    case banner(HomeItem)
    case normalCarousel(HomeItem)
    case listCarousel(HomeItem)
}

struct HomeItem: Hashable {
    let title: String
    let subTitle: String? 
    let imageUrl: String
    
    init(title: String, subTitle: String? = "", imageUrl: String) {
        self.title = title
        self.subTitle = subTitle
        self.imageUrl = imageUrl
    }
}
