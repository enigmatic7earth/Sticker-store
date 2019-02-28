//
//  PackTableViewCell.swift
//  Sticker-store
//
//  Created by NETBIZ on 27/02/19.
//  Copyright © 2019 Netbiz.in. All rights reserved.
//

import UIKit

class PackTableViewCell: UITableViewCell,
    UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    private let cellLength: CGFloat = 60
    private let interimSpacing: CGFloat = 10
    
    // MARK: Outlets
    @IBOutlet private weak var stickerPackTitleLabel: UILabel!
    @IBOutlet private weak var stickerPackCreatorLabel: UILabel!
    @IBOutlet private weak var stickerPackCollectionView: UICollectionView!
    
    var stickerPack: StickerPack? {
        didSet {
            stickerPackTitle = stickerPack?.name
            stickerPackSecondaryInfo = stickerPack?.publisher
            stickerPackCollectionView.reloadData()
        }
    }
    
    var stickerPackTitle: String? {
        get {
            return stickerPackTitleLabel.text
        }
        set {
            stickerPackTitleLabel.text = newValue
        }
    }
    
    var stickerPackSecondaryInfo: String? {
        get {
            return stickerPackCreatorLabel.text!
        }
        set {
            stickerPackCreatorLabel.text = newValue
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        stickerPackCollectionView.dataSource = self
        stickerPackCollectionView.delegate = self
        stickerPackCollectionView.register(StickerCell.self, forCellWithReuseIdentifier: "StickerCell")
    }
    
    // MARK: Collectionview
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return interimSpacing;
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: cellLength, height: cellLength)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let stickerPack = stickerPack else {
            return 0
        }
        
        return stickerPack.stickers.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "StickerCell", for: indexPath) as! StickerCell
        if let sticker = stickerPack?.stickers[indexPath.row] {
            cell.sticker = sticker
        }
        return cell
    }

//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//
//        // Configure the view for the selected state
//    }
    
}
