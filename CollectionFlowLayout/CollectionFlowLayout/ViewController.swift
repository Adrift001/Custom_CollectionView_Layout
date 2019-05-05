//
//  ViewController.swift
//  CollectionFlowLayout
//
//  Created by 荆学涛 on 2019/5/5.
//  Copyright © 2019 荆学涛. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.addSubview(collectionView)
        collectionView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        collectionView.backgroundColor = UIColor.brown
    }
    
    lazy var collectionView: UICollectionView = {
        let layout = CollectionViewLayout()
        layout.delegate = self
        let c = UICollectionView(frame: .zero, collectionViewLayout: layout)
        c.dataSource = self
        c.delegate = self
        c.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        return c
    }()
}

extension UIViewController: CollectionViewLayoutProtocol {
    func waterFallLayout(layout: CollectionViewLayout, itemWidth: CGFloat) -> CGFloat {
        return CGFloat.random(in: 100...200)
    }
    
    func columnMarginInWaterFallLayout(layout: CollectionViewLayout) -> CGFloat {
        return 0
    }
    
    func rowMarginInWaterFallLayout(layout: CollectionViewLayout) -> CGFloat {
        return 0
    }
    
    func edgeInsetsInWaterFallLayout(layout: CollectionViewLayout) -> UIEdgeInsets {
        return UIEdgeInsets.zero
    }
    
    func columnCountInWaterFallLayout(layout: CollectionViewLayout) -> Int {
        return 2
    }

}

extension UIViewController: UICollectionViewDataSource {
    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 100
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        cell.backgroundColor = UIColor.random
        return cell
    }
}

extension UIColor {
    static var random: UIColor {
        let r = CGFloat.random(in: 0..<255)
        let g = CGFloat.random(in: 0..<255)
        let b = CGFloat.random(in: 0..<255)
        return UIColor(red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: 1.0)
        
    }
}

extension UIViewController: UICollectionViewDelegate {
    
}
