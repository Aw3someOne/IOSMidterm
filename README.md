# iOS Midterm Tutorial
- Tag [`v1.0`](https://github.com/Aw3someOne/IOSMidterm/releases/tag/v1.0) is the "starting point for this guide if you would like to follow along"
- Tag `v1.x` is the code after step x has been completed

## Step 1 - Changing our Master/Detail app to use our Category Class instead of NSDate

#### MasterViewController

change `var objects = [Any]()` -> `var objects = [Category]()`

remove casts to NSDate

`objects.insert(Category(name: "New Category", description: "New Category Description"), at: 0)`

### DetailViewController
`var detailItem: Category?`

**Checkpoint: App should create and display information on categories without crashing**

## Step 2 - Adding a table to our DetailViewController

### Storyboard

1. Drag a new Table View Controller into empty space
2. Drag a Container View into Detail Scene
3. Control Drag from container view into the new table view and select embed
4. Give this segue a name `NoteTableSegue`
5. Add two labels to the child view table cell
6. Create a button on the Detail scene to create notes
7. Create new Cocoa Touch class `NoteTableViewController`, subclass of `UITableViewController` and implement `numberOfSections` and `tableView`

### `NoteTableViewController: UITableViewController`
```
var detailItem: Category?
override func numberOfSections(in tableView: UITableView) -> Int {
    // #warning Incomplete implementation, return the number of sections
    return 1
}
override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    // #warning Incomplete implementation, return the number of rows
    return (detailItem?.notes.count)!
}
```
8. Add the following to `DetailViewController`
### `DetailViewController`
```
var childViewController: NoteTableViewController?
override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "NoteTableSegue" {
        if let childVC = segue.destination as? NoteTableViewController {
            childVC.detailItem = detailItem
            childViewController = childVC
        }
    }
}
@IBAction func createNoteButtonPressed(_ sender: Any) {
    if let category = detailItem {
        category.notes.insert(Note(title: "New Note", body: "Descriptive text here"), at: 0)
    }
    let indexPath = IndexPath(row: 0, section: 0)
    childViewController?.tableView.insertRows(at: [indexPath], with: .automatic)
}
```
**Checkpoint: everything should compile, but clicking [Create note] doesn't do anything BabyRage**

This is because our newly created `TableViewController` doesn't do anything AND it's not linked to our storyboard

## Step 3

Go to the embedded tableviewcontroller and link it to our class
Now the create note button makes our app crash LUL

To fix this:

1. give our tableviewcell a new unique reuse identifier `noteCell`
2. Create a new Cocoa Touch class: `NoteTableViewCell` subclass: `UITableViewCell`
3. link it to our prototype cell
4. ctrl+clickdrag our two labels and create two outlets `titleLabel` and `descriptionLabel`
5. change row height of the tableview to 100 or something to get it to appear properly
6. Implement tableView of our `NoteTableViewController`
### `NoteTableViewCell: UITableViewCell`
```
override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "noteCell", for: indexPath) as! NoteTableViewCell

    // Configure the cell...
    let object = detailItem?.notes[indexPath.row]
    cell.titleLabel.text = object?.title
    cell.descriptionLabel.text = object?.body

    return cell
}
```
It works PogChamp
