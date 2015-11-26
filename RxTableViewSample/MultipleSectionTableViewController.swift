//
//  MultipleSectionTableViewController.swift
//  RxTableViewSample
//
//  Created by Shinichiro Oba on 2015/11/26.
//  Copyright © 2015年 Shinichiro Oba. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class MultipleSectionTableViewController: UITableViewController {
    
    let items = Variable<[[AnyObject]]>([])
    
    let dataSource = SectionedDataSource()
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        items.value.append(["One", "Two", "Three"])
        items.value.append([1, 2, 3, 4, 5])
        
        bind()
    }
    
    func bind() {
        tableView.dataSource = nil
        
        items.bindTo(tableView.rx_itemsWithDataSource(dataSource))
            .addDisposableTo(disposeBag)
    }
}


class SectionedDataSource: NSObject, RxTableViewDataSourceType, UITableViewDataSource {
    
    typealias Element = [[AnyObject]]
    
    var items: Element?
    
    func tableView(tableView: UITableView, observedEvent: RxSwift.Event<Element>) {
        switch observedEvent {
        case .Next(let value):
            self.items = value
            
            tableView.reloadData()
            
        case .Error(let error):
            print("Error: \(error)")
            
        case .Completed:
            print("Completed")
        }
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return items?.count ?? 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items?[section].count ?? 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        
        cell.textLabel?.text = items![indexPath.section][indexPath.row].description
        
        return cell
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Section #\(section + 1)"
    }
}
