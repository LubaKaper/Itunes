//
//  ViewController.swift
//  ITunes
//
//  Created by Liubov Kaper  on 11/24/20.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    private let apiClient = APIClient()
    
    private var podcasts = [Podcast]() {
        didSet {
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .systemYellow
        searchBar.delegate = self 
        loadPodcats(for: "swift")
    }

    private func loadPodcats(for query: String) {
        apiClient.fetchPodcasts(for: query) { [weak self] (result) in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let podcasts):
                self?.podcasts = podcasts
            }
        }
    }

}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return podcasts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "podcastCell", for: indexPath) as? PodcastCell else {
            fatalError("could not dequeue PodcastCell")
        }
        let podcast = podcasts[indexPath.row]
        cell.configureCell(for: podcast)
        //cell.collectionNameLabel.text = podcast.collectionName
        return cell
    }
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let interItemSpacing:CGFloat = 10 // space between items
        let maxWidth = UIScreen.main.bounds.size.width // devices width
        let numberOfItems: CGFloat = 1
        let totalSpacing: CGFloat = numberOfItems * interItemSpacing
        let itemWidth: CGFloat = (maxWidth - totalSpacing) / numberOfItems
        return CGSize(width: itemWidth, height: itemWidth)
    }
    
}

extension ViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard !searchText.isEmpty else {
            loadPodcats(for: "swift")
            return
        }
        loadPodcats(for: searchText)
    }
    
}
