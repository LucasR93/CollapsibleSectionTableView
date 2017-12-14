//
//  Created by Lucas Reiners on 14.12.17.
//  Copyright © 2017 Lucas Reiners. All rights reserved.
//

import UIKit

open class CollapsibleSectionTableView: UITableView, CollapsibleTableViewHeaderDelegate {

    public var collapseDelegate: CollapsibleSectionTableViewDelegate?

    fileprivate var _sectionsState = [Int: Bool]()

    public override init(frame: CGRect, style: UITableViewStyle) {
        super.init(frame: frame, style: style)
        setup()
    }

    required public init(coder aCoder: NSCoder) {
        super.init(coder: aCoder)!
        setup()
    }

    func setup() {
        super.delegate = self
        super.dataSource = self
    }

    public func isSectionCollapsed(_ section: Int) -> Bool {
        if _sectionsState.index(forKey: section) == nil {
            _sectionsState[section] = collapseDelegate?.shouldCollapseByDefault?(self) ?? false
        }
        return _sectionsState[section]!
    }

    func getSectionsNeedReload(_ section: Int) -> [Int] {
        var sectionsNeedReload = [section]

        // Toggle collapse
        let isCollapsed = !isSectionCollapsed(section)

        // Update the sections state
        _sectionsState[section] = isCollapsed

        let shouldCollapseOthers = collapseDelegate?.shouldCollapseOthers?(self) ?? false

        if !isCollapsed && shouldCollapseOthers {
            // Find out which sections need to be collapsed
            let filteredSections = _sectionsState.filter {
                !$0.value && $0.key != section
            }
            let sectionsNeedCollapse = filteredSections.map {
                $0.key
            }

            // Mark those sections as collapsed in the state
            for item in sectionsNeedCollapse {
                _sectionsState[item] = true
            }

            // Update the sections that need to be redrawn
            sectionsNeedReload.append(contentsOf: sectionsNeedCollapse)
        }

        return sectionsNeedReload
    }

    func toggleSection(_ section: Int) {
        let sectionsNeedReload = getSectionsNeedReload(section)
        self.reloadSections(IndexSet(sectionsNeedReload), with: .automatic)
    }
}
