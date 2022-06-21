//
//  ViewController.swift
//  JsonPlaceholderPhotoUIKit
//
//  Created by Toan Pham on 6/20/22.
//

import UIKit
import Combine

class HomeViewController: UIViewController {
    private let homeViewModel: HomeViewModel = .init()
    private var photosSubscription: AnyCancellable?
    
    private let tableView: UITableView = {
        let table = UITableView()
        table.register(PhotoTableViewCell.self, forCellReuseIdentifier: "cell")
        return table
    }()
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        addSubscription()
        setUpView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addSubscription(){
        photosSubscription = homeViewModel.$photos
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.tableView.reloadData()
            }
    }
    
    private func setUpView(){
        tableView.dataSource = self
        tableView.delegate = self
        
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
    }
   
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? PhotoTableViewCell ?? PhotoTableViewCell()
        cell.photo = homeViewModel.photos[indexPath.row]
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        homeViewModel.photos.count
    }
    
}


extension UIImage {
    static func loadRemoteImage(url: URL, completion: @escaping (UIImage) -> Void) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let responseData = data,
                  let image = UIImage(data: responseData),
                  error == nil
            else {
                return
            }
            DispatchQueue.main.async {
                completion(image)
            }
        }.resume()
    }
}
