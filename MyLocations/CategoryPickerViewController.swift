import UIKit

class CategoryPickerViewController: UITableViewController {
  var selectedCategoryName = ""
  
    let categories = [
        "No Category",
        "Airport",
        "Aquarium",
        "Bar",
        "Brewery",
        "Club",
        "Dog Park",
        "Grocery Store",
        "Historic Building",
        "Hospital",
        "Hotel/Resort",
        "House",
        "Landmark",
        "Local Park",
        "Museum",
        "Music Venue",
        "National Park",
        "Other",
        "Restaurant",
        "Spa",
        "Sporting Venue",
        "State Beach",
        "Theme Park",
        "University",
        "Vineyard/Winery",
        "Zoo"
    ]
  var selectedIndexPath = IndexPath()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    for i in 0..<categories.count {
      if categories[i] == selectedCategoryName {
        selectedIndexPath = IndexPath(row: i, section: 0)
        break
      }
    }
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: AnyObject?) {
    if segue.identifier == "PickedCategory" {
      let cell = sender as! UITableViewCell
      if let indexPath = tableView.indexPath(for: cell) {
        selectedCategoryName = categories[(indexPath as NSIndexPath).row]
      }
    }
  }
    
  // MARK: - UITableViewDataSource
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return categories.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
    
    let categoryName = categories[(indexPath as NSIndexPath).row]
    cell.textLabel!.text = categoryName
    
    if categoryName == selectedCategoryName {
      cell.accessoryType = .checkmark
    } else {
      cell.accessoryType = .none
    }
    
    return cell
  }
  
  // MARK: - UITableViewDelegate
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    if (indexPath as NSIndexPath).row != selectedIndexPath.row {
      if let newCell = tableView.cellForRow(at: indexPath) {
        newCell.accessoryType = .checkmark
      }

      if let oldCell = tableView.cellForRow(at: selectedIndexPath) {
        oldCell.accessoryType = .none
      }

      selectedIndexPath = indexPath
    }
  }
}
