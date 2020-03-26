//
//  BookCell.swift
//  StorytelApp
//
//  Created by Artem Shuba on 25/03/2020.
//  Copyright © 2020 Artem Shuba. All rights reserved.
//

import UIKit
import SDWebImage

class BookCell: UITableViewCell {
    // MARK: - Properties: private
    
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var authorsLabel: UILabel!
    @IBOutlet private weak var narratorsLabel: UILabel!
    @IBOutlet private weak var coverImageView: UIImageView!
    
    // MARK: - Lifecycle
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        sd_cancelCurrentImageLoad()
        coverImageView.image = nil
    }
    
    // MARK: - Public
    
    func configure(with viewModel: BookViewModel) {
        titleLabel.text = viewModel.title
        
        authorsLabel.text = viewModel.displayAuthors
        narratorsLabel.text = viewModel.displayNarrators
        
        guard let imageUrl = viewModel.coverUrl else { return }
        
        coverImageView.sd_setImage(with: imageUrl, placeholderImage: nil)
    }
}
