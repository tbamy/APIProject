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
    
    var bookViewModel = DIContainer.shared.makeBookViewModel()
    
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
        
        bookViewModel.delegate = self
        
        Task {
            await bookViewModel.fetchBooks()
        }
        
            activityIndicator.startAnimating()
        bookViewModel.responseHandler = { [weak self] booksModel in
            self?.didReceiveResponse(data: booksModel)
            
//            DispatchQueue.main.async { [weak self] in
////                print(booksModel?.results)
//                self?.booksModel = booksModel
//                self?.activityIndicator.stopAnimating()
//                self?.booksTable.reloadData()
//            }
        }
        
        bookViewModel.errorHandler = { error in
            print("error is \(error!)")
        }
    }
    
//    func fetchBooks() async {
//        activityIndicator.startAnimating()
//        let booksAPI = NetworkCall()
//
//        do {
//            guard let url = URL(string: "https://api.nytimes.com/svc/books/v3/lists/current/hardcover-fiction.json?api-key=WKHndJGECQsOKf2XYga2eyWRsDCygmdN") else {
//                print("Invalid URL")
//                return
//            }
//
//            if let booksData = try await booksAPI.BooksFetch(url: url) {
//                self.booksModel = booksData
//                self.activityIndicator.stopAnimating()
////                print("Fetched books data: \(booksData)")
//                self.booksTable.reloadData()
//            } else {
//                print("No data received")
//            }
//        } catch {
//            print(error.localizedDescription)
//        }
//    }
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
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        200
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let selectedData = booksModel?.results?.books?[indexPath.row]
        let detailsView = BooksDetailViewController()
        detailsView.bookData = selectedData
        navigationController?.pushViewController(detailsView, animated: true)
        
        
    }
}

extension BooksController: BooksViewModelDelegate{
    func didReceiveResponse(data: BooksModel?) {
        DispatchQueue.main.async { [weak self] in
            self?.booksModel = data
            self?.activityIndicator.stopAnimating()
            self?.booksTable.reloadData()
        }
    }
    
    func didReceiveError(error: String) {
        print("error is \(error)")
    }
    
    
}


