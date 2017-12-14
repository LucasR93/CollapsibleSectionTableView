//
// Created by Lucas Reiners on 14.12.17.
// Copyright (c) 2017 Lucas Reiners. All rights reserved.
//

import Foundation
import UIKit

extension CollapsibleSectionTableView: UITableViewDelegate {

    public func numberOfSections(in tableView: UITableView) -> Int {
        return collapseDelegate?.numberOfSections?(in: tableView) ?? 1
    }

    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        collapseDelegate?.collapsibleTableView?(tableView, didSelectRowAt: indexPath)
    }

    // Header
    public final func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "header") as? CollapsibleTableViewHeader ?? CollapsibleTableViewHeader(reuseIdentifier: "header")
        if let typedTable = tableView as? CollapsibleSectionTableView {
            let title = typedTable.collapseDelegate?.collapsibleTableView?(tableView, titleForHeaderInSection: section) ?? ""

            header.titleLabel.text = title
            header.arrowLabel.text = ">"
            header.setCollapsed(typedTable.isSectionCollapsed(section))

            header.section = section
            header.delegate = self

            return header
        }
        return nil
    }

    public final func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return collapseDelegate?.collapsibleTableView?(tableView, heightForHeaderInSection: section) ?? 44.0
    }

    public func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return collapseDelegate?.collapsibleTableView?(tableView, heightForFooterInSection: section) ?? 0.0
    }

}

extension CollapsibleSectionTableView: UITableViewDataSource {
    public final func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let delegate = collapseDelegate else {
            assert(false, "The CollapseDelegate is nil")
            return 0
        }
        return isSectionCollapsed(section) ? 0 : delegate.collapsibleTableView(tableView, numberOfRowsInSection: section)
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let delegate = collapseDelegate else {
            assert(false, "The CollapseDelegate is nil")
            return UITableViewCell()
        }
        return delegate.collapsibleTableView(tableView, cellForRowAt: indexPath)
    }

}
