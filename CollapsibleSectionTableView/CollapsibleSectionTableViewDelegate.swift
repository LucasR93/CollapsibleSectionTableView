//
// Created by Lucas Reiners on 14.12.17.
// Copyright (c) 2017 jeantimex. All rights reserved.
//

import Foundation
import UIKit

@objc public protocol CollapsibleSectionTableViewDelegate {
    @objc optional func numberOfSections(in tableView: UITableView) -> Int
    func collapsibleTableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    func collapsibleTableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    @objc optional func collapsibleTableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat
    @objc optional func collapsibleTableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat
    @objc optional func collapsibleTableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String?
    @objc optional func collapsibleTableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    @objc optional func shouldCollapseByDefault(_ tableView: UITableView) -> Bool
    @objc optional func shouldCollapseOthers(_ tableView: UITableView) -> Bool
}
