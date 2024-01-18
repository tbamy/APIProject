//
//  PopularTableViewCell.swift
//  APIProject
//
//  Created by WEMA on 18/01/2024.
//

import UIKit

class PopularTableViewCell: UITableViewCell {
    
    @IBOutlet weak var container: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var sourceLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        container.layer.cornerRadius = 20
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func updateCell(with data: PopularObj){
        
        if let title = data.title{
            titleLabel.text = "\(title)"
        }else{
            titleLabel.text = "Invalid Title"
        }
        
        if let source = data.source{
            sourceLabel.text = "Source: \(source)"
        }else{
            sourceLabel.text = "Invalid Source"
        }
        
        if let type = data.type{
            typeLabel.text = "Type: \(type)"
        }else{
            typeLabel.text = "Invalid Type"
        }
        
        if let date = data.published_date{
            dateLabel.text = "Published: \(date)"
        }else{
            dateLabel.text = "Invalid Date"
        }
    }
}
