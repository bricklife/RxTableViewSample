//
//  CellIdentifierTableViewController.swift
//  RxTableViewSample
//
//  Created by Shinichiro Oba on 2015/11/26.
//  Copyright © 2015年 Shinichiro Oba. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class CellIdentifierTableViewController: UITableViewController {
    
    let items = Variable<[AnyObject]>([])
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bind()
    }
    
    func bind() {
        tableView.dataSource = nil
        
        items.asObservable().bindTo(tableView.rx_itemsWithCellIdentifier("Cell", cellType: UITableViewCell.self)) { (_, object, cell) in
            cell.textLabel?.text = object.description
            }
            .addDisposableTo(disposeBag)
    }
    
    @IBAction func addButtonPushed(sender: AnyObject) {
        items.value.insert(NSDate(), atIndex: 0)
    }
    
}
