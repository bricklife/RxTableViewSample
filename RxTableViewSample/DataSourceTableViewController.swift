//
//  DataSourceTableViewController.swift
//  RxTableViewSample
//
//  Created by Shinichiro Oba on 2015/11/26.
//  Copyright © 2015年 Shinichiro Oba. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class DataSourceTableViewController: UITableViewController {
    
    let items = Variable<[AnyObject]>([])

    let dataSource = ArrayDataSource()
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bind()
    }
    
    func bind() {
        tableView.dataSource = nil
        
        items.asObservable().bindTo(tableView.rx_itemsWithDataSource(dataSource))
            .addDisposableTo(disposeBag)
    }
    
    @IBAction func addButtonPushed(sender: AnyObject) {
        items.value.insert(NSDate(), atIndex: 0)
    }
    
}


class ArrayDataSource: NSObject, RxTableViewDataSourceType, UITableViewDataSource {
    
    typealias Element = [AnyObject]
    
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
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items?.count ?? 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        
        cell.textLabel?.text = items![indexPath.row].description
        
        return cell
    }
    
}
