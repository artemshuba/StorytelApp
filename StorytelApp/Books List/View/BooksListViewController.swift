//
//  BooksListViewController.swift
//  StorytelApp
//
//  Created by Artem Shuba on 24/03/2020.
//  Copyright © 2020 Artem Shuba. All rights reserved.
//

import UIKit

private let headerHeight: CGFloat = 250
private let footerHeight: CGFloat = 60

protocol BooksListView : PresenterView, LoadableView, IncrementallyLoadableView {
    func showBooks(withQuery query: String)
}

class BooksListViewController : UIViewController {
    // MARK: - Properties: private
    
    private lazy var tableView = UITableView()
    private lazy var activityIndicator = UIActivityIndicatorView()
    private lazy var footerContainerView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: footerHeight))
    private lazy var moreActivityIndicator = UIActivityIndicatorView()
    private lazy var headerContainerView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: headerHeight))
    private lazy var headerView = BooksHeaderView()
    
    private let presenter: BooksListPresenterProtocol
    
    // MARK: - Init
    
    init(presenter: BooksListPresenterProtocol) {
        self.presenter = presenter
        
        super.init(nibName: nil, bundle: nil)
        
        setupLayout()
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter.load()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        headerContainerView.frame = CGRect(x: 0, y: 0, width: tableView.frame.width, height: headerHeight)
    }
    
    // MARK: - Private
    
    private func setupLayout() {
        view.addSubview(tableView)
        view.addSubview(activityIndicator)
        
        footerContainerView.addSubview(moreActivityIndicator)
        headerContainerView.addSubview(headerView)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
        
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            activityIndicator.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            activityIndicator.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            activityIndicator.topAnchor.constraint(equalTo: view.topAnchor),
            activityIndicator.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
        
        moreActivityIndicator.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            moreActivityIndicator.leadingAnchor.constraint(equalTo: footerContainerView.leadingAnchor),
            moreActivityIndicator.trailingAnchor.constraint(equalTo: footerContainerView.trailingAnchor),
            moreActivityIndicator.topAnchor.constraint(equalTo: footerContainerView.topAnchor, constant: 20),
            moreActivityIndicator.bottomAnchor.constraint(equalTo: footerContainerView.bottomAnchor, constant: -20),
        ])
        
        headerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            headerView.widthAnchor.constraint(equalTo: headerContainerView.widthAnchor),
            headerView.heightAnchor.constraint(equalTo: headerContainerView.heightAnchor),
        ])
    }
    
    private func setupViews() {
        tableView.contentInsetAdjustmentBehavior = .never
        tableView.register(BookCell.nib, forCellReuseIdentifier: BookCell.reuseIdentifier)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableFooterView = footerContainerView
        tableView.tableHeaderView = headerContainerView
    }
}

// MARK: - UITableViewDataSource

extension BooksListViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter.numberOfBooks()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: BookCell.reuseIdentifier, for: indexPath) as? BookCell else {
            // Should never happen
            fatalError("Unexpected cell type")
        }
        
        let book = presenter.book(at: indexPath)
        
        cell.configure(with: book)
        
        return cell
    }
}

// MARK: - UITableViewDelegate

extension BooksListViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard indexPath.row == presenter.numberOfBooks() - 1 else { return }

        presenter.loadMore()
    }
}

// MARK: - BooksListView

extension BooksListViewController : BooksListView {
    func showBooks(withQuery query: String) {
        headerView.query = query
        tableView.reloadData()
    }
    
    func startActivity() {
        activityIndicator.startAnimating()
    }
    
    func stopActivity() {
        activityIndicator.stopAnimating()
    }
    
    func startMoreActivity() {
        moreActivityIndicator.startAnimating()
    }
    
    func stopMoreActivity() {
        moreActivityIndicator.stopAnimating()
    }
}
