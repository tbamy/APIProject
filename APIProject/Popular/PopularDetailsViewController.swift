//
//  PopularDetailsViewController.swift
//  APIProject
//
//  Created by TBAM on 19/01/2024.
//

import UIKit

class PopularDetailsViewController: UIViewController {

    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var sourceLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    var popularData: PopularObj?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let title = popularData?.title{
            titleLabel.text = "\(title)"
        }else{
            titleLabel.text = "Invalid Title"
        }
        
        if let source = popularData?.source{
            sourceLabel.text = "Source: \(source)"
        }else{
            sourceLabel.text = "Invalid Source"
        }
        
        if let type = popularData?.type{
            typeLabel.text = "Type: \(type)"
        }else{
            typeLabel.text = "Invalid Type"
        }
        
        if let date = popularData?.published_date{
            dateLabel.text = "Published: \(date)"
        }else{
            dateLabel.text = "Invalid Date"
        }
        
        
        if let description = popularData?.abstract{
            descriptionLabel.text = description
        }
        
        // Do any additional setup after loading the view.
    }


}
