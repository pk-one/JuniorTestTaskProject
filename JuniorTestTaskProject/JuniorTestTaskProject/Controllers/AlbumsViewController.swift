//
//  AlbumsViewController.swift
//  JuniorTestTaskProject
//
//  Created by Pavel Olegovich on 14.10.2021.
//

import UIKit

class AlbumsViewController: UIViewController {

    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        tableView.register(AlbumsTableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private let searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setupDelegate()
        setNavigationBar()
        setupSearchController()
        setConstraints()
    }

    private func setupViews() {
        view.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        view.addSubview(tableView)
    }
    
    private func setupDelegate() {
        tableView.delegate = self
        tableView.dataSource = self
        
        searchController.searchBar.delegate = self
    }
    
    private func setNavigationBar() {
        navigationItem.title = "Альбомы"
        navigationItem.searchController = searchController
        
        let userInfoButton = createCustomBarButtonItem(selector: #selector(userInfoButtonTapped))
        navigationItem.rightBarButtonItem = userInfoButton
    }
    
    private func setupSearchController() {
        searchController.searchBar.placeholder = "Поиск"
        searchController.obscuresBackgroundDuringPresentation = false
    }
    
    @objc private func userInfoButtonTapped() {
//        let userInfoViewController = UserInfoViewController()
//        navigationController?.pushViewController(userInfoViewController, animated: true)
    }
}

//MARK: - UITableViewDataSource
extension AlbumsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! AlbumsTableViewCell
        
        return cell
    }
}

//MARK: - UITableViewDelegate
extension AlbumsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let detailAlbumViewController = DetailAlbumViewController()
//        navigationController?.pushViewController(detailAlbumViewController, animated: true)
    }
}

//MARK: - UISearchBarDelegate
extension AlbumsViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print(searchText)
    }
}

//MARK: - SetConstraints
extension AlbumsViewController {
    private func setConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
}
