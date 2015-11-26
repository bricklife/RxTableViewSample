//
//  ViewController.swift
//  RxTableViewSample
//
//  Created by Shinichiro Oba on 2015/11/26.
//  Copyright © 2015年 Shinichiro Oba. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    let items = Variable<[AnyObject]>([])
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bind()
    }
    
    func bind() {
        items.bindTo(tableView.rx_itemsWithCellIdentifier("Cell")) { (_, object, cell) in
            cell.textLabel?.text = object.description
            }
            .addDisposableTo(disposeBag)
    }
    
    @IBAction func addButtonPushed(sender: AnyObject) {
        items.value.insert(NSDate(), atIndex: 0)
    }
    
}
