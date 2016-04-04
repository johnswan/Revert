//
//  Copyright © 2016 Itty Bitty Apps. All rights reserved.

import UIKit

final class SearchViewController: UITableViewController {
  required init?(coder aDecoder: NSCoder) {
    self.dataSource = DataSource(
      collection: self.collection,
      configureCell: self.dynamicType.configureCell,
      cellIdentifier: Storyboards.Cell.TableViewController
    )

    super.init(coder: aDecoder)
  }

  override func viewDidLoad() {
    super.viewDidLoad()

    self.tableView.dataSource = self.dataSource
  }

  //MARK: Private
  private let collection = CollectableCollection<Person>(items: .Persons)
  private let dataSource: DataSource<Person, BasicCell>
}

private extension SearchViewController {
  static func configureCell(cell: BasicCell, object: Person) {
    cell.accessoryType = .None

    cell.titleLabel.text = object.name
    cell.subtitleLabel.text = object.city
  }
}

extension SearchViewController: UISearchResultsUpdating {
  func updateSearchResultsForSearchController(searchController: UISearchController) {
    if let searchText = searchController.searchBar.text where searchController.searchBar.text?.characters.count > 0 {
      self.dataSource.filter({
        $0.city.localizedStandardContainsString(searchText) || $0.name.localizedStandardContainsString(searchText)
      })
    } else {
      self.dataSource.filter(nil)
    }

    self.tableView.reloadData()
  }
}
