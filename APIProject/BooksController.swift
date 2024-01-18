//
//  BooksController.swift
//  APIProject
//
//  Created by WEMA on 18/01/2024.
//

import UIKit
import Kingfisher

class BooksController: UIViewController {
    @IBOutlet weak var category: UILabel!
    @IBOutlet weak var booksTable: UITableView!
    
    var booksModel: BooksModel?
    
    let activityIndicator = UIActivityIndicatorView(style: .large)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        activityIndicator.hidesWhenStopped = true
        activityIndicator.center = view.center
        view.addSubview(activityIndicator)
        
        booksTable.register(UINib(nibName: "BooksTableViewCell", bundle: nil), forCellReuseIdentifier: "BooksTableViewCell")
        booksTable.dataSource = self
        booksTable.delegate = self
        
        category.text = "Hardcover Fiction Books"
        
        Task {
            await fetchBooks()
        }
    }
    
    func fetchBooks() async {
        activityIndicator.startAnimating()
        let booksAPI = Books()

        do {
            guard let url = URL(string: "https://api.nytimes.com/svc/books/v3/lists/current/hardcover-fiction.json?api-key=WKHndJGECQsOKf2XYga2eyWRsDCygmdN") else {
                print("Invalid URL")
                return
            }

            if let booksData = try await booksAPI.fetch(url: url) {
                self.booksModel = booksData
                self.activityIndicator.stopAnimating()
//                print("Fetched books data: \(booksData)")
                self.booksTable.reloadData()
            } else {
                print("No data received")
            }
        } catch {
            print(error.localizedDescription)
        }
    }
}

extension BooksController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return booksModel?.results?.books?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BooksTableViewCell", for: indexPath) as! BooksTableViewCell
        if let book = booksModel?.results?.books?[indexPath.row] {
            cell.updateCell(with: book)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        200
    }
}


