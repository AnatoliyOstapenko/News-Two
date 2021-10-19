//
//  ViewController.swift
//  News Two
//
//  Created by MacBook on 18.10.2021.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    // create array
    private var viewModels = [NewsTableViewCellViewModel]()
    
    
    
    // create UITableView
    private let tableView: UITableView = {
        let table = UITableView()
        table.register(NewsTableViewCell.self, forCellReuseIdentifier: NewsTableViewCell.identifier)
        return table
    }()
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // add title to bar
        title = "News"
        
        //add UITableView
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        
        // let's chek it other time:
        //view.backgroundColor = .systemBackground
        
        NewsManager.shared.getTopStories { [weak self] result in
            
            switch result {
            case .success(let articles):
                self?.viewModels = articles.compactMap({
                    NewsTableViewCellViewModel(title: $0.title, subtitle: $0.description ?? "no description", imageURL: URL(string: $0.urlToImage ?? "no image"), imageData: nil)
                })
                
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
                
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        // stretch tableview trough view
        tableView.frame = view.bounds
    }
    
    
    
    // TableView
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: NewsTableViewCell.identifier, for: indexPath) as? NewsTableViewCell else { fatalError("error with dequeueReusableCell")}
        
        cell.configure(with: viewModels[indexPath.row])
        
        return cell
    }
    
    // it has to be further explored
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    // height for row
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    


}

