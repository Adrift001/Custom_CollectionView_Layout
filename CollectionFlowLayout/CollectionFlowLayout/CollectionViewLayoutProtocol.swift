//
//  CollectionViewLayoutProtocol.swift
//  CollectionFlowLayout
//
//  Created by 荆学涛 on 2019/5/5.
//  Copyright © 2019 荆学涛. All rights reserved.
//

import UIKit

@objc protocol CollectionViewLayoutProtocol: class {
    
    // 每个item的高度
    func waterFallLayout(layout: CollectionViewLayout, itemWidth: CGFloat) -> CGFloat
    
    // 有多少列
    @objc optional func columnCountInWaterFallLayout(layout: CollectionViewLayout) -> Int
    
    // 每列之间的间距
    @objc optional func columnMarginInWaterFallLayout(layout: CollectionViewLayout) -> CGFloat
    
    //每行之间的间距
    @objc optional func rowMarginInWaterFallLayout(layout: CollectionViewLayout) -> CGFloat
    
    // 每个item的内边距
    @objc optional func edgeInsetsInWaterFallLayout(layout: CollectionViewLayout) -> UIEdgeInsets
    
}
