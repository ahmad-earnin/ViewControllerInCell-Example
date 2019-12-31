//
//  ColorsViewController.swift
//  ViewControllerInCell-Example
//
//  Created by William Boles on 03/04/2018.
//  Copyright © 2018 William Boles. All rights reserved.
//

import UIKit

class ColorsViewController: UIViewController {
    
    @IBOutlet var tableView: UICollectionView!

    lazy var colorViewControllers: [ColorViewController] = {
        var colorViewControllers = [ColorViewController]()
        
        for _ in 0...100 {
            let colorViewController = ColorViewController.createFromStoryboard()

            addChildContentViewController(colorViewController)
            colorViewControllers.append(colorViewController)
        }
        
        return colorViewControllers
    }()
    
    // MARK: - ViewLifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        tableView.collectionViewLayout = {
            let layout = UICollectionViewFlowLayout()
            layout.estimatedItemSize = CGSize(width: view.bounds.width, height: 80)
            return layout
        }()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
            self.tableView.performBatchUpdates({ }, completion: { _ in })
        }
    }
    
    // MARK: - ChildViewControllers
    
    private func addChildContentViewController(_ childViewController: UIViewController) {
        addChildViewController(childViewController)
        childViewController.didMove(toParentViewController: self)
    }
}

extension ColorsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let colorViewController = colorViewControllers[indexPath.row]

        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ColorTableViewCell.reuseIdentifier, for: indexPath) as? ColorTableViewCell else {
            fatalError("Unexpected cell being dequeued")
        }

        cell.hostedView = colorViewController.view
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return colorViewControllers.count
    }
}
