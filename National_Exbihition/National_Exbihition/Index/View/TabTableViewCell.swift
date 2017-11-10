//
//  TabTableViewCell.swift
//  National_Exbihition
//
//  Created by ly on 2017/11/10.
//  Copyright © 2017年 shikeTeam. All rights reserved.
//

import UIKit

class TabTableViewCell: UITableViewCell {
    
    
    let flagImage = UIImageView()
    let nameTitle = UILabel()
    let contentLabel = UILabel()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setUI(){
        flagImage.frame = Rect(29, 13, 161, 108)
        self.addSubview(flagImage)
        nameTitle.frame = Rect(204, 13, 0, 0)
        nameTitle.font = UIFont.systemFont(ofSize: getHeight(36))
        nameTitle.textColor = title1Color
        
        contentLabel.frame = Rect(204, 64, 510, 69)
        contentLabel.font = UIFont.systemFont(ofSize: getHeight(26))
        contentLabel.numberOfLines = 0
        contentLabel.textColor = title2color
        
        self.addSubview(nameTitle)
        self.addSubview(contentLabel)
        
        
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
