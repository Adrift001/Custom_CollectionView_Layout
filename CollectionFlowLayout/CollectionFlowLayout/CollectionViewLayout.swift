//
//  CollectionViewLayout.swift
//  CollectionFlowLayout
//
//  Created by 荆学涛 on 2019/5/5.
//  Copyright © 2019 荆学涛. All rights reserved.
//

import UIKit

class CollectionViewLayout: UICollectionViewLayout {
    // 代理
    weak var delegate: CollectionViewLayoutProtocol?
    
    // 默认列数
    var defaultColumnCount = 3
    
    // 每一列间距
    var defaultColumnMargin: CGFloat = 10
    
    // 每一行间距
    var defaultRowMargin: CGFloat = 10
    
    // 内边距
    var defaultEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    
    // 存放布局属性
    var attrsArr: [UICollectionViewLayoutAttributes] = []
    
    // 存放所有列的当前高度
    var columnHeights: [CGFloat] = []
    
    // 内容高度
    var contentHeight: CGFloat = 0
    
    func columnCount() -> Int {
        return delegate?.columnCountInWaterFallLayout?(layout: self) ?? defaultColumnCount
    }
    
    func columnMargin() -> CGFloat {
        return delegate?.columnMarginInWaterFallLayout?(layout: self) ?? defaultColumnMargin
    }
    
    func rowMargin() -> CGFloat {
        return delegate?.rowMarginInWaterFallLayout?(layout: self) ?? defaultRowMargin
    }
    
    func edgeInsets() -> UIEdgeInsets {
        return delegate?.edgeInsetsInWaterFallLayout?(layout: self) ?? defaultEdgeInsets
    }
    
    override func prepare() {
        super.prepare()
        
        contentHeight = 0
        
        columnHeights.removeAll() // 移除所有列的高度
        
        attrsArr.removeAll() // 清除所有布局属性
        
        // 设置每一列默认高度
        for _ in 0..<defaultColumnCount {
            columnHeights.append(edgeInsets().top)
        }
        
        // 开始为每一个cell创建布局属性
        let count = collectionView?.numberOfItems(inSection: 0) ?? 0
        
        for index in 0..<count {
            // 创建位置
            let indexPath = IndexPath(row: index, section: 0)
            
            // 获取indexPath位置上的cell对象的布局属性
            if let attrs = layoutAttributesForItem(at: indexPath) {
                attrsArr.append(attrs)
            }
        }
    }
    
    // 内容高度
    override var collectionViewContentSize: CGSize {
        return CGSize(width: 0, height: contentHeight + edgeInsets().bottom)
    }
    
    // 所有单元格位置属性
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        return attrsArr
    }
    
    // 这个方法返回每个单元格的位置和大小
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        let attrs = UICollectionViewLayoutAttributes(forCellWith: indexPath)
        
        let collectionViewWidth = collectionView?.frame.size.width ?? 0
        
        let cellWidth = (collectionViewWidth - edgeInsets().left - edgeInsets().right - CGFloat((columnCount() - 1)) * columnMargin()) / CGFloat(columnCount())
        let cellHeight = delegate?.waterFallLayout(layout: self, itemWidth: cellWidth) ?? 0
        
        // 找出三列中最短的一列
        var destColumn = 0
        var minColumnHeight = columnHeights[0]
        for index in 0..<columnCount() {
            let columnHeight = columnHeights[index]
            if minColumnHeight > columnHeight {
                minColumnHeight = columnHeight
                destColumn = index
            }
        }
        
        let cellX = edgeInsets().left + CGFloat(destColumn) * (cellWidth + columnMargin())
        var cellY = minColumnHeight
        if cellY != edgeInsets().top {
            cellY += rowMargin()
        }
        
        // 更新最短那一列的高度
        attrs.frame = CGRect(x: cellX, y: cellY, width: cellWidth, height: cellHeight)
        columnHeights[destColumn] = attrs.frame.maxY
        
        // 记录内容的高度 - 即最长那一列的高度
        let maxColumnHeight = columnHeights[destColumn]
        if contentHeight < maxColumnHeight {
            contentHeight = maxColumnHeight
        }
        return attrs
    }
    
    // 页眉、页脚
    override func layoutAttributesForSupplementaryView(ofKind elementKind: String, at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return nil
    }
    
    // 设置section背景
//    override func layoutAttributesForInteractivelyMovingItem(at indexPath: IndexPath, withTargetPosition position: CGPoint) -> UICollectionViewLayoutAttributes {
//    }
}
