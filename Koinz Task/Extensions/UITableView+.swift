//
//  UITableView+.swift
//  Koinz Task
//
//  Created by Youssef on 15/07/2023.
//

import UIKit

extension UITableView {
    
    func registerCellNib<Cell: UITableViewCell>(cellClass: Cell.Type) {
        register(UINib(nibName: String(describing: Cell.self), bundle: nil), forCellReuseIdentifier: String(describing: Cell.self))
    }
    
    func dequeue<T: UITableViewCell>(_ T: T.Type) -> T {
        let identifier = String(describing: T.self)
        
        let cell = self.dequeueReusableCell(withIdentifier: identifier) as! T
        
        return cell
    }
}
