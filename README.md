TableKit is a light library to help you build a table list in a fast and security way.

## Features

- [x] data-driven
- [x] easy to use

### Problems in the traditional way

UIKit is ancient when it comes to modern UI library like Flutter, SwiftUI. We must remember the time that we learned how to use UIKit from a newbie. It contains the following steps when we want to construct a list:

```swift
// 1. register the target cells
tableView.register(cell.Type, forCellReuseIdentifier: identifier)
// 2. specify the length of list
func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return count
}
// 3. dequeue cell from the pool
func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
    return cell 
}
```

And if we want to modify the list like insert a new row or delete some sections. 
We should 

1. modify the data source first 
2. update the list by using tableView API
3. reload tableView with modifications

Seeing as the steps are too complicated and it's really easy to make our programs crash when we modify the table dynamically, especially in asynchronized situation. Now have a look with TableKit.

### How to build a table in TableKit way

```swift
// 1. initialize a tableController, the gizmos we will use to control the list
let tableController = TableController()
// 2. inherit Row with your beautiful cell
class CustomRow: Row<UITableViewCell> {
}
// 3. append new row to the list
tableController.append(row: row)
// 4. that's it! just reload
tableController.reloadData()
```

### License

TableKit is released under the MIT license. See LICENSE for details.
