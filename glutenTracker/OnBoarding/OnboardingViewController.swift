//
//  OnboardingViewController.swift
//  glutenTracker
//
//  Created by Darrieumerlou on 02/04/2020.
//  Copyright © 2020 Darrieumerlou. All rights reserved.
//

import UIKit
import CloudKit

class OnboardingViewController: UIViewController {
    
    // ***********************************************
    // MARK: - Interface
    // ***********************************************
    @IBOutlet weak var nextButton: UIButton!
   // @IBOutlet weak var onboardingCollectionView: UICollectionView!
    // ***********************************************
    // MARK: - Properties
    // ***********************************************
    let cellPercentWidth: CGFloat = 0.7
    //var centeredCollectionViewFlowLayout: CenteredCollectionViewFlowLayout!
    // ***********************************************
    // MARK: - Implementation
    // ***********************************************
    override func loadView() {
        super.loadView()
        nextButton.layer.cornerRadius = nextButton.bounds.height / 2
    }
    
    override func viewDidLoad() {
            super.viewDidLoad()

            // Get the reference to the `CenteredCollectionViewFlowLayout` (REQUIRED STEP)
     //   centeredCollectionViewFlowLayout = onboardingCollectionView.collectionViewLayout as? CenteredCollectionViewFlowLayout

            // Modify the collectionView's decelerationRate (REQUIRED STEP)
     //   onboardingCollectionView.decelerationRate = UIScrollView.DecelerationRate.fast

            // Assign delegate and data source
     //       onboardingCollectionView.delegate = self
      //      onboardingCollectionView.dataSource = self

            // Configure the required item size (REQUIRED STEP)
//            centeredCollectionViewFlowLayout.itemSize = CGSize(
//                width: view.bounds.width * cellPercentWidth,
//                height: view.bounds.height * cellPercentWidth * cellPercentWidth
//            )
//
//            // Configure the optional inter item spacing (OPTIONAL STEP)
//            centeredCollectionViewFlowLayout.minimumLineSpacing = 20
//
//            // Get rid of scrolling indicators
//            onboardingCollectionView.showsVerticalScrollIndicator = false
//            onboardingCollectionView.showsHorizontalScrollIndicator = false
        }
    
    
    // ***********************************************
    // MARK: - Private Methods
    // ***********************************************
    
    private func checkIcloudAvailability() {
        CloudKitAvailability.checkIfAvailable(success: {
            self.dismiss(animated: true) {
                OnboardingLogic.default.finish()
            }
        }, failure: { error in
            self.showError(error.localizedDescription)
        })
    }
    // ***********************************************
    // MARK: - Actions
    // ***********************************************
    @IBAction func actionNext(_ sender: UIButton) {
        self.checkIcloudAvailability()
    }

    
//    struct Page {
//        var introduction: String
//    }
//
//    var pages = [Page]()
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//            return pages.count
//        }
//
//        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//
//            // Grab our cell from dequeueReusableCell, wtih the same identifier we set in our storyboard.
//            let cell = onboardingCollectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? OnboardingCollectionViewCell
//
//            // Error checking, if our cell is somehow not able to be cast
//            guard let pageCell = cell else {
//                print("Unable to instantiate user cell at index \(indexPath.row)")
//                return cell!
//            }
//
//            // Give the current cell the corresponding data it needs from our model
//            //pageCell.introduction.text = pages[indexPath.row].introduction
//            return pageCell
//        }

    }
    

