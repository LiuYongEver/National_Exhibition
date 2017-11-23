//
//  SearchHistoryTableViewCell.swift
//  National_Exbihition
//
//  Created by ly on 2017/11/22.
//  Copyright © 2017年 shikeTeam. All rights reserved.
//

import UIKit

class SearchHistoryTableViewCell: UITableViewCell {

    var labels = [UIButton]()
    var count:Int!
  init(style: UITableViewCellStyle, reuseIdentifier: String?,count:Int) {
        self.count = count
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
        for i in 0...count{
            let label = UIButton(frame:Rect(Double(20+173*i), 30, 153, 51))
            label.setTitle("中国", for: .normal)
            label.titleLabel?.font = UIFont.systemFont(ofSize: getHeight(32))
            label.setTitleColor(naviColor, for: .normal)
            label.layer.cornerRadius = 6
            label.layer.borderColor = naviColor.cgColor
            label.layer.borderWidth = 1
            self.labels.append(label)
            self.addSubview(labels[i])
        }
        
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
