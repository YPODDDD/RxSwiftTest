//
//  UITableViewCell+XIB.swift
//  RxSwiftTest
//
//  Created by Ypodddd on 7/23/21.
//

import UIKit

extension UITableViewCell {
    static func register(for tableView: UITableView)  {
        let cellName = String(describing: self)
        let cellIdentifier = cellName + "Identifier"
        let cellNib = UINib(nibName: String(describing: self), bundle: nil)
        tableView.register(cellNib, forCellReuseIdentifier: cellIdentifier)
    }
    
    static var identifierName: String {
        get {
            let cellName = String(describing: self)
            let cellIdentifier = cellName + "Identifier"
            return cellIdentifier
        }
    }
}

