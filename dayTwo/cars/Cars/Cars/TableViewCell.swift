//
//  TableViewCell.swift
//  Cars
//
//  Created by Antonio Prado on 4/10/18.
//  Copyright © 2018 Antonio Prado. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    convenience init?(width model: String, with make: String, with image: UIImage) {
        self.init(style: .default, reuseIdentifier: nil)
        
        // todo OK
        let container = UIImageView(frame: CGRect(x:5, y:5, width: frame.width/2-10, height:130))
        container.image = image
        addSubview(container)
        
        let makeLabel = UILabel(frame: CGRect(x: container.frame.maxX+10, y:5, width: frame.width/2-20, height:30))
        makeLabel.text = "Make: \(make)"
        makeLabel.font = UIFont(name: "", size:18)
        makeLabel.adjustsFontSizeToFitWidth = true
        makeLabel.textColor = .gray
        addSubview(makeLabel)
        
        let modelLabel = UILabel(frame: CGRect(x: container.frame.maxX+10, y: makeLabel.frame.maxY+10, width: frame.width/2-20, height:30))
        modelLabel.text = "Model: \(model)"
        modelLabel.font = UIFont(name: "", size:15)
        modelLabel.adjustsFontSizeToFitWidth = true
        modelLabel.textColor = .lightGray
        addSubview(modelLabel)
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
