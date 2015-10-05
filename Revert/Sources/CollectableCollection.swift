//
//  Copyright (c) 2015 Itty Bitty Apps. All rights reserved.
//

import Foundation

struct CollectableCollection<I: Collectable>: Collection {
  typealias T = CollectableGroup<I>

  let items: [CollectableGroup<I>]

  init(items: RevertItems) {
    self.items = items.data.map { CollectableGroup<I>(dictionary: $0) }
  }

  subscript(indexPath: NSIndexPath) -> I {
    return self[indexPath.section][indexPath.row]
  }
}
