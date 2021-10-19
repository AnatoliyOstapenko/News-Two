//
//  NewsTableViewCell.swift
//  News Two
//
//  Created by MacBook on 18.10.2021.
//

import UIKit


class NewsTableViewCellViewModel {
    
    let title: String
    let subtitle: String
    let imageURL: URL?
    var imageData: Data?
    
    init(title: String, subtitle: String, imageURL: URL?, imageData: Data?) {
        self.title = title
        self.subtitle = subtitle
        self.imageURL = imageURL
        self.imageData = imageData
    }
}




class NewsTableViewCell: UITableViewCell {
    
    
    // create newsTitleLabel label
    private let newsTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 25, weight: .medium)
        return label
    }()
    // create subTitleLabel
    private let subTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .regular)
        return label
    }()
    // create newsImageView
    private let newsImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .systemRed
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    

   static let identifier = "NewsTableViewCell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        // add 3 private let to cell
        contentView.addSubview(newsImageView)
        contentView.addSubview(subTitleLabel)
        contentView.addSubview(newsTitleLabel)
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        // layout labels
        newsTitleLabel.frame = CGRect(x: 10, y: 0, width: contentView.frame.size.width - 200, height: 70)
        
        subTitleLabel.frame = CGRect(x: 10, y: 70, width: contentView.frame.size.width - 200, height: contentView.frame.size.height/2)
        
        newsImageView.frame = CGRect(x: contentView.frame.size.width - 200, y: 5, width: 190, height: contentView.frame.size.height - 10)
        
        
 
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
 
    }
    
    func configure(with viewModel: NewsTableViewCellViewModel) {
        
        newsTitleLabel.text = viewModel.title
        subTitleLabel.text = viewModel.subtitle
        
        
        guard let data = viewModel.imageData, let url = viewModel.imageURL else { return }
        newsImageView.image = UIImage(data: data)
        
        
    }
    

}
