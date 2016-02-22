//
//  WaterFlowLayout.swift
//  WaterFlowLayoutDemo
//
//  Created by Chakery on 16/2/22.
//  Copyright © 2016年 Chakery. All rights reserved.
//

import UIKit

protocol WaterFlowLayoutDataSource: class {
    /**
     返回item的高度
     
     - parameter flowLayout: WaterFlowLayout
     - parameter indexPath:  item indexpath
     - parameter itemWidth:  item width
     
     - returns: item高度
     */
    func waterFlowLayout(flowLayout: WaterFlowLayout, heightForItemAtIndexPath indexPath: NSIndexPath, itemWidth: CGFloat) -> CGFloat
    
    /**
     返回列数, 默认为3
     
     - parameter flowLayout: WaterFlowLayout
     
     - returns: 列数
     */
    func waterNumberOfColumn(flowLayout: WaterFlowLayout) -> CGFloat
    
    /**
     返回边距, 默认为10
     
     - parameter flowLayout: WaterFlowLayout
     
     - returns: 边距
     */
    func waterItemMargin(flowLayout: WaterFlowLayout) -> CGFloat
}

class WaterFlowLayout: UICollectionViewLayout {
    // 所有item的属性
    private var attributes: [UICollectionViewLayoutAttributes] = []
    // 每列的高度
    private var heights: [CGFloat] = []
    // 列数
    private var columnCount: CGFloat!
    // 间距
    private var itemMargin: CGFloat!
    // delegate
    weak var delegate: WaterFlowLayoutDataSource?
    
    
    ///	collectionView item 将要布局
    override func prepareLayout() {
        // 这里默认只有1个Section, 获取item总数
        let itemCount = collectionView!.numberOfItemsInSection(0)
        columnCount = delegate!.waterNumberOfColumn(self)
        itemMargin = delegate!.waterItemMargin(self)
        
        attributes.removeAll()
        heights.removeAll()
        
        for _ in 0..<Int(columnCount) {
            heights.append(CGFloat(0))
        }
        
        for i in 0..<itemCount {
            let indexPath = NSIndexPath(forItem: i, inSection: 0)
            let attribute = layoutAttributesForItemAtIndexPath(indexPath)!
            attributes.append(attribute)
        }
    }
    
    
    ///	每一个item的属性
    ///	- parameter rect:	需要重新布局的范围
    ///	- returns: 范围内所有的item的属性
    override func layoutAttributesForElementsInRect(rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        return attributes
    }
    
    ///	重新设置item的属性
    ///	- parameter indexPath:	item对应的位置
    ///	- returns: 返回属性
    override func layoutAttributesForItemAtIndexPath(indexPath: NSIndexPath) -> UICollectionViewLayoutAttributes? {
        
        let attribute = UICollectionViewLayoutAttributes.init(forCellWithIndexPath: indexPath)
        let min = extremeForArray(heights, extreme: false)
        let collectionViewWidth = collectionView!.frame.width
        
        let width = (collectionViewWidth - (columnCount + 1) * itemMargin) / columnCount
        let height = delegate!.waterFlowLayout(self, heightForItemAtIndexPath: indexPath, itemWidth: width)
        let x = CGFloat(min.index + 1) * itemMargin + CGFloat(min.index) * width
        let y = min.value + itemMargin
        
        heights[min.index] = y + height
        attribute.frame = CGRect(x: x, y: y, width: width, height: height)
        
        return attribute
    }
    
    ///	返回collectionView内容大小
    override func collectionViewContentSize() -> CGSize {
        let maxHeight = extremeForArray(heights, extreme: true).value
        return CGSize(width: 0, height: maxHeight + itemMargin)
    }
}


// MARK: - WaterFlowLayout DataSource 扩展
extension WaterFlowLayoutDataSource {
    func waterNumberOfColumn(flowLayout: WaterFlowLayout) -> CGFloat {
        return 3
    }
    
    func waterItemMargin(flowLayout: WaterFlowLayout) -> CGFloat {
        return 10
    }
}


extension WaterFlowLayout {
    ///	返回数组中的最大值/或者最小值
    ///	- parameter data:		数组
    ///	- parameter extreme:	true表示最大值, false表示最小值
    ///	- returns: 返回 结果/下标
    func extremeForArray(data: [CGFloat], extreme: Bool) -> (value: CGFloat, index: Int) {
        guard data.count > 0 else { fatalError("数组不能为空") }
        
        var value = data.first!
        var index = 0
        
        for i in 0..<data.count {
            if extreme {
                if data[i] > value {
                    value = data[i]
                    index = i
                }
            } else {
                if data[i] < value {
                    value = data[i]
                    index = i
                }
            }
        }
        
        return (value, index)
    }
}
