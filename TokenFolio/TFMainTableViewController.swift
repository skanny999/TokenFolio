//
//  TPMainTableViewController.swift
//  TokenFolio
//
//  Created by Riccardo Scanavacca on 22/06/2017.
//  Copyright © 2017 Riccardo Scanavacca. All rights reserved.
//

import UIKit
import CoreData
import DZNEmptyDataSet

class TFMainTableViewController: UITableViewController {
    
    
    @IBOutlet weak var portfolioValueLabel: UILabel!
    
    
    var fetchedResultsController: NSFetchedResultsController<Token>!
    var refreshController : UIRefreshControl!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureFetchedResultsController()
        updatePortfolioLabel()
        configureRefreshController()
        configureEmptyDataSet()
        tableView.backgroundView = UIImageView(image: UIImage(named: "Backgound.png"))
    }
    
    
    func configureTitle() {
        
        let titleAttributes = [
            NSFontAttributeName: UIFont.systemFont(ofSize: 24, weight: UIFontWeightMedium)
        ]
        navigationController?.navigationBar.titleTextAttributes = titleAttributes
        
    }
    
    
    
    func configureRefreshController() {
        
        refreshController = UIRefreshControl()
        refreshController.attributedTitle = NSAttributedString(string: "Refreshing...")
        refreshController.addTarget(self, action: #selector(refresh), for: UIControlEvents.valueChanged)
        tableView.refreshControl = refreshController

    }
    

    
    
    func configureFetchedResultsController() {
        
        fetchedResultsController = TFCoreDataProvider.shared.selectedTokensFetchResultController()
        fetchedResultsController.delegate = self
        
        performFetch()

    }
    
    func refresh() {
        
        TFUpdateManager.updateTokens()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0, execute: {
            
            self.refreshController?.endRefreshing()
        })

        
    }
    
    
    func performFetch() {
        
        do {
            try fetchedResultsController.performFetch()
        }
        catch {
            
            fatalError("Failed to initialize FetchedResultsController: \(error)")
        }
    }
    
    
    
    func updatePortfolioLabel() {
        
        var totalValue = Double()
        
        TFCoreDataProvider.shared.fetchSelectedTokens { (tokens) in
            
            if tokens.count == 0 {
                
                totalValue = 0
            }
            else {
                
                for token in tokens {
                    
                    totalValue += token.totalValue!.doubleValue
                }
            }
            
            self.portfolioValueLabel.text = Value.formattedValue(totalValue)
        }
    }


    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        if let sections = fetchedResultsController.sections {
            
            return sections.count
        }
        
        return  0
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if let sections = fetchedResultsController.sections {
            let currentSection = sections[section]
            
            return currentSection.numberOfObjects
            
        }
        
        return 0
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {

            let token = self.fetchedResultsController.object(at: indexPath)
            token.remove()
            
        }
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TOKEN_CELL", for: indexPath) as! TFTokenTableViewCell
        let token = fetchedResultsController.object(at: indexPath)
        
        cell.configureCellWithToken(token)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 90.0
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let token = fetchedResultsController.object(at: indexPath);
        
        performSegue(withIdentifier: "DETAILS_SEGUE", sender: token)
 
    }
    

}

extension TFMainTableViewController : NSFetchedResultsControllerDelegate {
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        
        switch type {
        case .insert:
            tableView.insertRows(at: [newIndexPath! as IndexPath], with: UITableViewRowAnimation.automatic)
        case .delete:
            tableView.deleteRows(at: [indexPath! as IndexPath], with: UITableViewRowAnimation.automatic)
        case .update:
            tableView.reloadData()
        case .move:
            tableView.deleteRows(at: [indexPath! as IndexPath], with: UITableViewRowAnimation.automatic)
            tableView.insertRows(at: [indexPath! as IndexPath], with: UITableViewRowAnimation.automatic)
        }

    }
    
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
        
        refreshController?.endRefreshing()
        updatePortfolioLabel()
    }

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "DETAILS_SEGUE" {
            
            let detailViewController = segue.destination as! TFDetailViewController
            
            detailViewController.token = sender as? Token
        }
        
    }
}

extension TFMainTableViewController: DZNEmptyDataSetSource, DZNEmptyDataSetDelegate {
    
    func configureEmptyDataSet() {
        
        tableView.emptyDataSetSource = self
        tableView.emptyDataSetDelegate = self
        tableView.tableFooterView = UIView()
        
    }
    
    func title(forEmptyDataSet scrollView: UIScrollView) -> NSAttributedString? {
        let str = "Welcome to TokenFolio"
        let attrs = [NSFontAttributeName: UIFont.systemFont(ofSize: 24, weight: UIFontWeightMedium)]
        return NSAttributedString(string: str, attributes: attrs)
    }
    
    func description(forEmptyDataSet scrollView: UIScrollView) -> NSAttributedString? {
        let str = "Tap the Plus button to add your first Token!"
        let attrs = [NSFontAttributeName: UIFont.systemFont(ofSize: 20, weight: UIFontWeightMedium)]
        return NSAttributedString(string: str, attributes: attrs)
    }
    
    func image(forEmptyDataSet scrollView: UIScrollView) -> UIImage? {
        return UIImage(named: "taylor-swift")
    }
    
    func buttonTitle(forEmptyDataSet scrollView: UIScrollView, for state: UIControlState) -> NSAttributedString? {
        let str = "+"
        let attrs = [NSFontAttributeName: UIFont.systemFont(ofSize: 60, weight: UIFontWeightLight)]
        return NSAttributedString(string: str, attributes: attrs)
    }
    
    func emptyDataSet(_ scrollView: UIScrollView, didTap button: UIButton) {

        performSegue(withIdentifier: "ADD_SEGUE", sender: nil)
        
    }
    
    
    
}
