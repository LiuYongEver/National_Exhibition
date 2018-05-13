//
//  FansTableViewCell.swift
//  National_Exbihition
//
//  Created by 刘勇 on 2018/5/8.
//  Copyright © 2018年 shikeTeam. All rights reserved.
//

import UIKit

class FansTableViewCell: UITableViewCell {


    lazy var nameLabel:UILabel = {
        let label = UILabel.init(frame: Rect(15+60,135/2 - 16,300, 32) )
        label.font = UIFont.systemFont(ofSize: getHeight(32))
        return  label;
        
    }()
    
    lazy var headImage:UIImageView =  {
        let label = UIImageView.init(frame: Rect(15,135/2 - 25, 50, 50))
        label.layer.cornerRadius = 25
        return  label;
        
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.addSubview(nameLabel)
        self.addSubview(headImage)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func awakeFromNib() {
        
    
        
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
