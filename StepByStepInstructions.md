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
* In `Main.storyboard` go to the **Object Library** and find a **Bar Button Item**
* Drag a Button Item onto the right side of the navigation bar of the Table View Controller scene
* In the **Attribute Inspector** make the "System Item" equal to "Add"
* In `MasterViewController` find the `viewDidLoad()` method and uncomment the `navigationItem` line of code
* Change the code to use the leftBarButtonItem instead: `self.navigationItem.leftBarButtonItem = self.editButtonItem`
* Create an `IBAction` in `MasterViewController` which will be used to add new Notes into your model. This should be an **IBAction** from your + `Bar Button Item` in `Main.storyboard` to your `MasterViewController`
* Make sure you click on **Show the Assistant Editor** so you can see your `MasterViewController.swift` and `Main.storybaord` files next to each other
  * **PRO TIP:** You can hold `Option + Shift` then click on a file to give you presentation options
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
* Start by renaming the `ViewController.swift` file to `DetailViewController`
  * Click on the original `ViewController.swift` file, highlight `ViewController` in the source code, Right click -> Refactor -> Rename
* In `Main.storyboard` click on the View Controller scene, then in **Identity Inspector** set `DetailViewController` as the class
* Create a segue from the `MasterViewController` tableView cell to `DetailViewController`
  * Control Drag from the `NotesCell` to the `DetailViewController` scene
  * Select `Show` in the popup to create the segue
  * Click on the new Segue then on **Attributes Inspector**, and give it the Identifier name: `MasterToDetail`
* In `MasterViewController.swift` create a String constant to match the Identifier
  ```swift
  let segueIdentifier = "MasterToDetail"
  ```
* Uncomment the `func prepare(for segue)` code
* Run the app to test out your Segue functionality

## Configuring the DetailViewController

* In `Main.storyboard` add a **Text View** to the Detail View Controller scene
  * From the **Object Library** drag and drop a **Text View** onto the scene and adjust it to fit properly
* Connect the **Text View** as an IBOutlet to the `DetailViewController`
  * Make sure you **Show the Assistant Editor** so you can see the Storyboard and DetailViewController class next to each other
  * **PRO TIP:** You can hold `Option + Shift` then click on a file to give you presentation options
  * Control click and drag the **Text View** onto `DetailViewController`
  * Make sure **Outlet** is selected in the popup and give it the name: `textView`
  * The final IBOutlet should look something like this:
    ```swift
    @IBOutlet weak var textView: UITextView!
    ```
* Add a `var` to `DetailViewController` which will be used to hold your String data aka the Note
  * **NOTE:** Make the String `var` is an optional `?`
  ```swift
  var note: String?
  ```
* Write a function called `configureView()` to set `textView.text` equal to the value of the note that was passed in from the segue:
  ```swift
  func configureView() {
    if let note = note {
      textView.text = note
    }
  }
  ```
* Finally, make sure to call your new `configureView()` function from the `viewDidLoad()` lifecycle function

## Passing Data From Master to Detail

* In `MasterViewController` we need to update the `func prepare(for segue)` function to properly send data to the `DetailViewController` when we segue
* Inside the `prepare(for segue)` function we need to do two things:
  * Get the new view controller using `segue.destinationViewController`.
  * Pass the selected note to the new view controller.
* The `prepare(for segue)` function should look something like the following:
  ```swift
  if segue.identifier == segueIdentifier {
    if let indexPath = tableView.indexPathForSelectedRow {
      let note = notes[indexPath.row]
      let detailViewController = segue.destination as! DetailViewController
      detailViewController.note = note
    }
  }
  ```
* Build and run the app and verify that you are passing data correctly to the `DetailViewController`

## Bonus Functionality

* Add Persistence
  * Here are some options:
    * Core Data
    * Realm
    * NSUserDefaults
    * Firebase
* When you click on the + button to add a new note, automatically move to detail view controller
