//
//  UITableView+ReloadDataComplete.swift
//  SpeechToTextDemo
//
//  Created by SHUN on 12/20/16.
//  Copyright © 2016 q2650108. All rights reserved.
//

import Foundation
import UIKit

extension UITableView {
    func reloadData(completion: @escaping ()->()) {
        UIView.animate(withDuration: 0, animations: { self.reloadData() })
        { _ in completion() }
    }
}
