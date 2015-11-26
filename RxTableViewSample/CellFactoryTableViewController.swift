//
//  CellFactoryTableViewController.swift
//  RxTableViewSample
//
//  Created by Shinichiro Oba on 2015/11/26.
//  Copyright © 2015年 Shinichiro Oba. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class CellFactoryTableViewController: UITableViewController {
    
    let items = Variable<[AnyObject]>([])
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bind()
    }
    
    func bind() {
        tableView.dataSource = nil
        
        items.bindTo(tableView.rx_itemsWithCellFactory) { (tableView, i, object) in
            let cell = tableView.dequeueReusableCellWithIdentifier("Cell")!
            
            cell.textLabel?.text = object.description
            
            return cell
            }
            .addDisposableTo(disposeBag)
    }
    
    @IBAction func addButtonPushed(sender: AnyObject) {
        items.value.insert(NSDate(), atIndex: 0)
    }
    
}
