//
//  PopularController.swift
//  APIProject
//
//  Created by WEMA on 18/01/2024.
//

import UIKit

class PopularController: UIViewController {
    @IBOutlet weak var category: UILabel!
    @IBOutlet weak var popularTable: UITableView!
    
    var popularModel: PopularModel?
    let activityIndicator = UIActivityIndicatorView(style: .large)
    override func viewDidLoad() {
        super.viewDidLoad()
        
        activityIndicator.hidesWhenStopped = true
        activityIndicator.center = view.center
        view.addSubview(activityIndicator)
        
        popularTable.register(UINib(nibName: "PopularTableViewCell", bundle: nil), forCellReuseIdentifier: "PopularTableViewCell")
        popularTable.dataSource = self
        popularTable.delegate = self
        
        category.text = "Popular Stories"
        
        Task {
            await fetchPopular()
        }
    }
    
    func fetchPopular() async {
        activityIndicator.startAnimating()
        let popularAPI = Popular() 

        do {
            guard let url = URL(string: "https://api.nytimes.com/svc/mostpopular/v2/viewed/1.json?api-key=WKHndJGECQsOKf2XYga2eyWRsDCygmdN") else {
                print("Invalid URL")
                return
            }

            if let popularData = try await popularAPI.fetch(url: url) {
                self.popularModel = popularData
                self.activityIndicator.stopAnimating()
//                print("Fetched books data: \(popularData)")
                self.popularTable.reloadData()
            } else {
                print("No data received")
            }
        } catch {
            print(error.localizedDescription)
        }
    }
}

extension PopularController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return popularModel?.results?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PopularTableViewCell", for: indexPath) as! PopularTableViewCell
        if let results = popularModel?.results?[indexPath.row] {
            cell.updateCell(with: results)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        170
    }
}
