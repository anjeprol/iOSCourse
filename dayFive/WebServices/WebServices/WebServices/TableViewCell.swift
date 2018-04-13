//
//  TableViewCell.swift
//  WebServices
//
//  Created by Antonio Prado on 4/13/18.
//  Copyright © 2018 Antonio Prado. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    convenience init(withMake: String, model: String, image: UIImage?) {
        self.init(style: .default, reuseIdentifier: nil)
        
        let container = UIImageView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 130))
        container.image = image
        addSubview(container)
        
        let makeLabel = UILabel(frame: CGRect(x: 0, y: 70, width: UIScreen.main.bounds.width, height: 30))
        makeLabel.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        makeLabel.text = withMake
        makeLabel.textAlignment = .right
        makeLabel.textColor = .yellow
        addSubview(makeLabel)
        
        let modelLabel = UILabel(frame: CGRect(x: 0, y: 100, width: UIScreen.main.bounds.width, height: 30))
        modelLabel.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        modelLabel.text = model
        modelLabel.textAlignment = .right
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
