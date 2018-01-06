# Step By Step Instructions

## Initial Project and Storyboard Setup

* New Project -> Single View App -> Choose Swift
* Find `Table View Controller` in the Object Library and drag it into `Main.storyboard`
* Click newly created `Table View Controller` then in Xcode dropdowns go to Editor -> Embed In -> Navigation Controller
* Click on the new `Navigation Controller` and in the **Attribute Inspector** check the "Is Initial View Controller" option
* Go to Project Navigator and add a new file to the project
  * Use the **Cocoa Touch Class** option then hit next
  * Update "Class" to `MasterViewController`
  * Update "Subclass of" to `UITableViewController`
  * Click Next and then Create
* Go back to `Main.storyboard` and click on your  `Table View Controller` scene
* Once selected, go to the **Identity Inspector** and under Class make sure you select your newly created `MasterViewController`

## Configuring MasterViewController

* **Discuss `UITableViewController` class and the table view data source and delegate protocols**
* `UITableViewController` comes pre-wired to use the `UITableViewDataSource` and `UITableViewDelegate` protocols
* `UITableViewDataSource` protocol needs to be implemented to properly handle table data. This is how the data source provides the table-view object with the information it needs to construct and modify a table view.
* `UITableViewDelegate` protocol allows the delegate to manage selections, configure section headings and footers, help to delete and reorder cells, and perform other actions.
* Create our `notes` model inside of `MasterViewController`:
  ```swift
  var notes = [String]()
  ```
* Find the `func numberOfSections()` table view data source function and change the return value to: `1`
  ```swift
  return 1
  ```
  * Note that `func numberOfSections()` is a **Required** function
* Find the `func tableView(numberOfRowsInSection)` table view data source function and change it to return the count of notes
  ```swift
  return notes.count
  ```
  * Note that `func tableView(numberOfRowsInSection)` is a **Required** function
* Uncomment the `func tableView(cellForRowAt indexPath)` function
* In `Main.storyboard` find the Table View Cell in the Master View Controller
* In the **Attributes Inspector** give the table cell the Identifier: `NotesCell`
* Back in `MasterViewController` create a `String` constant for the identifier and use it with the `dequeuResuableCell()` function inside of the `cellForRowAt indexPath` function:
  ```swift
  let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
  ```
* Under "Configure the cell" comment in the `cellForRowAt indexPath` function, set the `textLabel` of each cell equal to the contents of your notes model using the appropriate index
  ```swift
  cell.textLabel?.text = notes[indexPath.row]
  ```
* In the `viewDidLoad()` function add a few Strings to the Notes model to test out your table view:
  ```swift
  notes.append("Hello")
  notes.append("World!")
  ```
* Build and run the app and you should see 2 cells displayed

## Adding Notes To The Model

* **Discuss Outlets, and Actions if needed**
* In `MasterViewController` find the `viewDidLoad()` method and uncomment the `navigationItem` line of code
* Change the code to use the leftBarButtonItem instead: `self.navigationItem.leftBarButtonItem = self.editButtonItem`
* Create an `IBAction` in `MasterViewController` which will be used to add new Notes into your model. This should be an **IBAction** from your + `Bar Button Item` in `Main.storyboard` to your `MasterViewController`
* Make sure you click on **Show the Assistant Editor** so you can see your `MasterViewController.swift` and `Main.storybaord` files next to each other
* Control drag from your + `Bar Button Item` to the `MasterViewController` to create an `IBAction`
* For **Connection** select: **Action**
* For **Name** give it: `addNote` and click on **Connect**
* Inside your new action add the following functionality to append new notes to your model and update your tableView accordingly:
  ```swift
  @IBAction func addNote(_ sender: Any) {
    notes.insert("New note", at: 0)
    let indexPath = IndexPath(row: 0, section: 0)
    tableView.insertRows(at: [indexPath], with: .automatic)
  }
  ```
* Build and run your app to test the + (add note) functionality

## Deleting Notes From The Model

* Find the `tableView(canEditRowAt IndexPath)` data source function and uncomment it
* Find the `tableView(commit edityingStyle, forRowAt indexPath)` data source function and uncomment it
* Edit the `tableView(commit edityingStyle, forRowAt indexPath)` function to properly delete a Note from your model whenever it is called:
  ```swift
  if editingStyle == .delete {
    // Delete the row from the data source
    notes.remove(at: indexPath.row)
    tableView.deleteRows(at: [indexPath], with: .fade)
  }
  ```

## Creating the Segue

* **Discuss Segues**
* Create a segue from MasterViewController to ViewController
* Control Drag from Master to Detail
* Click on the Segue then on **Attributes Inspector** and give it the Identifier name: `MasterToDetail`
* In `Main.storyboard` create a String constant to match the Identifier
* Go to the **Object Library** and find a **Bar Button Item**
* Drag a Button Item into the right side of the navigation bar of the Table View Controller
* In the **Attribute Inspector** make the "System Item" equal to "Add"

## Bonus Functionality

* Add Persistence
  * Core Data
  * Realm
  * NSUserDefaults
  * Firebase
* When you click on the + button to add a new note, automatically move to detail view controller
