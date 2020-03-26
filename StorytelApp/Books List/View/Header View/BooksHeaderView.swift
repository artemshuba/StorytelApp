//
//  BooksHeaderView.swift
//  StorytelApp
//
//  Created by Artem Shuba on 26/03/2020.
//  Copyright © 2020 Artem Shuba. All rights reserved.
//

import UIKit

class BooksHeaderView : UIView {
    // MARK: - Properties: private
    
    private lazy var titleLabel = UILabel()
    
    // MARK: - Properties: public
    
    var query: String = "" {
        didSet {
            updateViews()
        }
    }
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupLayout()
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setupLayout()
        setupViews()
    }
    
    // MARK: - Properties: private
    
    private func setupLayout() {
        addSubview(titleLabel)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.widthAnchor.constraint(equalTo: widthAnchor),
            titleLabel.topAnchor.constraint(equalTo: topAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
    
    private func setupViews() {
        backgroundColor = .systemFill
        
        titleLabel.font = .systemFont(ofSize: 32, weight: .medium)
        titleLabel.textAlignment = .center
    }
    
    private func updateViews() {
        titleLabel.text = "Query: \(query)"
    }
}
