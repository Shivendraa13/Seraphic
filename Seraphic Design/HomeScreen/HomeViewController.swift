//
//  HomeViewController.swift
//  Seraphic Design
//
//  Created by Shivendra on 12/12/24.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var advisorCollectionView: UICollectionView!
    @IBOutlet weak var favAdvisorCollectionView: UICollectionView!
    @IBOutlet weak var onlineAdvisorCollectionView: UICollectionView!
    
    private var advisorImage = [AdvisorStruct(image: UIImage(named: "advisorImage1"), name: "Isabella", status: "Online"),AdvisorStruct(image: UIImage(named: "advisorImage2"), name: "Methew Goemez", status: "Online"),AdvisorStruct(image: UIImage(named: "advisorImage1"), name: "Methew Goemez", status: "Online"),AdvisorStruct(image: UIImage(named: "advisorImage2"), name: "Isabella", status: "Busy")]
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setupCollectionViewLayout()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setCollectionView()
        favAdvisorCollectionView.translatesAutoresizingMaskIntoConstraints = false
        
        // Add constraints
        NSLayoutConstraint.activate([
            favAdvisorCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            favAdvisorCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
            favAdvisorCollectionView.heightAnchor.constraint(equalToConstant: 168)
        ])
    }
    
    func setupCollectionViewLayout() {
        if let layout = favAdvisorCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .horizontal
            let padding: CGFloat = 0
            layout.itemSize = CGSize(width: 118 - (2 * padding), height: 168)
            layout.minimumLineSpacing = 16
        }
    }
    
    func setCollectionView() {
        let cellNib = UINib(nibName: "AdvisiorCell", bundle: nil)
        advisorCollectionView.register(cellNib, forCellWithReuseIdentifier: "AdvisiorCell")
        let cellNib1 = UINib(nibName: "FavouriteAdvisorCell", bundle: nil)
        favAdvisorCollectionView.register(cellNib1, forCellWithReuseIdentifier: "FavouriteAdvisorCell")
        let cellNib2 = UINib(nibName: "OnlineCell", bundle: nil)
        onlineAdvisorCollectionView.register(cellNib2, forCellWithReuseIdentifier: "OnlineCell")
        
        if let layout = advisorCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            let spacing: CGFloat = 10 // Space between cells
            let totalSpacing = spacing * 3 // Total spacing (left + right + between cells)
            
            let width = (advisorCollectionView.frame.width - totalSpacing) / 2 // Calculate width for two cells
            layout.itemSize = CGSize(width: width, height: 385) // Set item size; height can be proportional
            layout.minimumInteritemSpacing = spacing
            layout.minimumLineSpacing = spacing
            layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
        }
        
        if let layout = onlineAdvisorCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            let spacing: CGFloat = 10 // Space between cells
            let width = onlineAdvisorCollectionView.frame.width - (2 * spacing) // Full width minus spacing
            layout.itemSize = CGSize(width: width, height: 218) // Set height as needed
            layout.minimumLineSpacing = spacing
            layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
        }
        
    }
    
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == advisorCollectionView {
            return advisorImage.count
        } else if collectionView == favAdvisorCollectionView {
            return advisorImage.count
        } else if collectionView == onlineAdvisorCollectionView {
            return advisorImage.count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == advisorCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AdvisiorCell", for: indexPath) as! AdvisiorCell
            cell.advisorImage.image = advisorImage[indexPath.item].image
            cell.advisorname.text = advisorImage[indexPath.item].name
            if advisorImage[indexPath.item].status == "Busy" {
                cell.statusView.backgroundColor = UIColor(hex: "FF2F48")
                cell.statusLabel.text = "Busy"
            }
            return cell
        } else if collectionView == favAdvisorCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FavouriteAdvisorCell", for: indexPath) as! FavouriteAdvisorCell
            cell.nameLabel.text = advisorImage[indexPath.item].name
            cell.imageName.image = advisorImage[indexPath.item].image
            return cell
        } else if collectionView == onlineAdvisorCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "OnlineCell", for: indexPath) as! OnlineCell
            cell.advisorImage.image = advisorImage[indexPath.item].image
            cell.nameLabel.text = advisorImage[indexPath.item].name
            return cell
        }
        return UICollectionViewCell()
    }
}
