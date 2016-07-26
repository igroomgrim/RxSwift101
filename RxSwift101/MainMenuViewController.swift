//
//  MainMenuViewController.swift
//  RxSwift101
//
//  Created by Anak Mirasing on 7/26/16.
//  Copyright © 2016 iGROOMGRiM. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class MainMenuViewController: ViewController {
    @IBOutlet weak var tableView: UITableView!
    
    private let menu = Observable.just([
            "TableView"
        ])
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        menu.bindTo(tableView.rx_itemsWithCellIdentifier("MenuCell")) { _, menu, cell in
                cell.textLabel?.text = menu
            }
            .addDisposableTo(disposeBag)
        
        tableView.rx_modelSelected(String)
            .subscribeNext { menu in
                print("Selected : \(menu)")
            }
            .addDisposableTo(disposeBag)
        
        tableView.rx_itemSelected
            .map { [unowned self]indexPath in
                self.tableView.deselectRowAtIndexPath(indexPath, animated: true)
            }
            .subscribe()
            .addDisposableTo(disposeBag)
    }
}
