//
//  BooksTableViewCell.swift
//  APIProject
//
//  Created by WEMA on 18/01/2024.
//

import UIKit

class BooksTableViewCell: UITableViewCell {
    
    @IBOutlet weak var container: UIView!
    @IBOutlet weak var bookImage: UIImageView!
    @IBOutlet weak var bookTitle: UILabel!
    @IBOutlet weak var bookAuthor: UILabel!
    @IBOutlet weak var bookPrice: UILabel!
    @IBOutlet weak var buyBook: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        buyBook.backgroundColor = .purple
        buyBook.layer.cornerRadius = 10
        buyBook.tintColor = .white
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    func updateCell(with data: BooksObj){
        
        if let imgString = data.book_image{
            let imageURL = URL(string: imgString)
            bookImage.kf.indicatorType = .activity
            bookImage.kf.setImage(with: imageURL)
        }
        
        if let title = data.title{
            bookTitle.text = title
        }else{
            bookTitle.text = "Invalid Title"
        }
        
        if let author = data.author {
            bookAuthor.text = author
        }else{
            bookAuthor.text = "Invalid Author"
        }
        
        if let price = data.price{
            bookPrice.text = price
        }else{
            bookPrice.text = "Invalid Price"
        }
        
        if data.amazon_product_url != nil {
            buyBook.setTitle("Buy on Amazon", for: .normal)
//            buyBook.addTarget(self, action: #selector(buyBookAmazon(urlValue:)), for: .touchUpInside)
        }else{
            buyBook.setTitle("Buy", for: .normal)
        }
        
        
    }
    
    @objc func buyBookAmazon(urlValue: String) {
        if let url = URL(string: urlValue), UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
    
}
