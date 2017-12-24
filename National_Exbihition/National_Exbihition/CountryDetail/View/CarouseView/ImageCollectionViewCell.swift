//
//  ImageCollectionViewCell.swift
//  National_Exbihition
//
//  Created by ly on 2017/12/24.
//  Copyright © 2017年 shikeTeam. All rights reserved.
//

import UIKit
import SDWebImage

class ImageCollectionViewCell: UICollectionViewCell {
    var imageView = UIImageView()
    
    var titleLabel = UILabel()
    
    
    var carouselModel : CarouselModel? {
        didSet {
            titleLabel.text = carouselModel?.title
            imageView.sd_setImage(with: URL(string: (carouselModel?.pic_url ?? "")!), placeholderImage: UIImage(named: "baccc"))
        }
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setupUI() {
        imageView.frame = self.bounds
        titleLabel.frame = CGRect(x: 0, y: self.bounds.size.height - 30, width: self.bounds.size.width, height: 30)
        titleLabel.backgroundColor = UIColor(white: 0.4, alpha: 0.3)
        titleLabel.textColor = .white
        self.addSubview(imageView)
        self.addSubview(titleLabel)
    }
    
    
}
