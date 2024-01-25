//
//  BooksDetailViewController.swift
//  APIProject
//
//  Created by TBAM on 19/01/2024.
//

import UIKit

class BooksDetailViewController: UIViewController {
    
    var bookData: BooksObj?
    
    @IBOutlet weak var container: UIView!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var imgLabel: UIImageView!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var btn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let imgString = bookData?.book_image{
            let imageURL = URL(string: imgString)
            imgLabel.kf.indicatorType = .activity
            imgLabel.kf.setImage(with: imageURL)
        }
        if let content = bookData?.book_description{
            contentLabel.text = content
        }
        
        if let author = bookData?.author{
            authorLabel.text = "By: \(author)"
        }
        
        if let price = bookData?.price{
            priceLabel.text = "Price: \(price)"
        }
        
        if let title = bookData?.title{
            titleLabel.text = title
        }else{
            titleLabel.text = "Invalid Title"
        }
//        
        if bookData?.amazon_product_url != nil {
            btn.setTitle("Buy on Amazon", for: .normal)
            btn.backgroundColor = .purple
            btn.tintColor = .white
            btn.layer.cornerRadius = 10
//            buyBook.addTarget(self, action: #selector(buyBookAmazon(urlValue:)), for: .touchUpInside)
        }else{
            btn.setTitle("Buy", for: .normal)
        }

        // Do any additional setup after loading the view.
    }



}
