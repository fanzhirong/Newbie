//
//  ViewController.swift
//  WaterFlowLayoutDemo
//
//  Created by Chakery on 16/2/22.
//  Copyright © 2016年 Chakery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(collectionView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    
    private lazy var collectionView: UICollectionView = {
        let layout = WaterFlowLayout()
        layout.delegate = self
        let rect = UIScreen.mainScreen().bounds
        let collectionView = UICollectionView(frame: rect, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.backgroundColor = UIColor.whiteColor()
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.registerClass(UICollectionViewCell.self, forCellWithReuseIdentifier: String(ViewController))
        return collectionView
    }()
}

extension ViewController: WaterFlowLayoutDataSource {
    func waterFlowLayout(flowLayout: WaterFlowLayout, heightForItemAtIndexPath indexPath: NSIndexPath, itemWidth: CGFloat) -> CGFloat {
        return CGFloat((random() % 10) * 10 + 100)
    }
}

extension ViewController: UICollectionViewDataSource {

    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 100
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let item = collectionView.dequeueReusableCellWithReuseIdentifier(String(ViewController), forIndexPath: indexPath)
        item.backgroundColor = UIColor.orangeColor()
        
        return item
    }
}

