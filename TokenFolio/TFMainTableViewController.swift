//
//  TPMainTableViewController.swift
//  TokenFolio
//
//  Created by Riccardo Scanavacca on 22/06/2017.
//  Copyright © 2017 Riccardo Scanavacca. All rights reserved.
//

import UIKit
import CoreData

class TFMainTableViewController: UITableViewController {
    
    var fetchedResultsController: NSFetchedResultsController<Token>!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureFetchedResultsController()
        
        
    }
    
    func configureFetchedResultsController() {
        
        let moc = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let request = NSFetchRequest<Token>(entityName: "Token")
        let rankSort = NSSortDescriptor(key: "rank", ascending: true)
        request.sortDescriptors = [rankSort]
        
        self.fetchedResultsController = NSFetchedResultsController<Token>(fetchRequest: request,
                                                                     managedObjectContext: moc,
                                                                     sectionNameKeyPath: nil,
                                                                     cacheName: nil)
        self.fetchedResultsController.delegate = self
        
        do {
            try fetchedResultsController.performFetch()

            
        } catch {
            
            fatalError("Failed to initialize FetchedResultsController: \(error)")
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
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
        let token = fetchedResultsController.object(at: indexPath)
        
        cell.textLabel?.text = token.name
//        cell.detailTextLabel?.text = "$" + token.priceUsd!
        
        return cell
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
            break
        // update cell at indexPath
        case .move:
            tableView.deleteRows(at: [indexPath! as IndexPath], with: UITableViewRowAnimation.automatic)
            tableView.insertRows(at: [indexPath! as IndexPath], with: UITableViewRowAnimation.automatic)
        }

    }
    
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }
    
    
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "ADD_SEGUE" {
            
            
        }
        
    }
    

}
