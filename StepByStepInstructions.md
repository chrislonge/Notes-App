# Step By Step Instructions

## Initial Project and Storyboard Setup

* New Project -> Single View App -> Choose Swift
* Start by renaming the `ViewController.swift` file to `DetailViewController`
  * Click on the original `ViewController.swift` file, highlight `ViewController` in the source code, right click -> Refactor -> Rename
* In `Main.storyboard` click on the View Controller scene, then in **Identity Inspector** set `DetailViewController` as the class
* Find `Table View Controller` in the Object Library and drag it into `Main.storyboard`
* Click the newly created `Table View Controller` then in the Xcode dropdown menu's go to Editor -> Embed In -> Navigation Controller
* Click on the new `Navigation Controller` and in the **Attribute Inspector** check the "Is Initial View Controller" option
* Go to Project Navigator and add a new file to the project
  * Use the **Cocoa Touch Class** option then hit next
  * Update "Class" to `MasterViewController`
  * Update "Subclass of" to `UITableViewController`
  * Click Next and then Create
* Go back to `Main.storyboard` and click on your  `Table View Controller` scene
* Once selected, go to the **Identity Inspector** and under Class make sure you select your newly created `MasterViewController`

## Configuring MasterViewController

### A few notes on `UITableViewController`

The `UITableViewController` creates a `UITableView` and sets itself as the delegate and the data source of the table view. If you were to create a `UIViewController` that has a table view and does not inherit from `UITableViewController` you would have to set up the data source and the delegate of your table view yourself.

`UITableView` declares two protocols `UITableViewDataSource` and `UITableViewDelegate`. The data source protocol is used by the table view to determine the content it needs to display, the delegate protocol is used to inform another class about cells that have been selected and to provide an interface for modifying the table view behavior.

In other words, `UITableViewController` comes with boilerplate code ready for you to use and also comes pre-wired to use the `UITableViewDataSource` and `UITableViewDelegate` protocols.

#### Create the Model

* Create a new swift file to hold our `Note` model
  * File -> New -> File -> Swift File
  * Name the file `Note.swift`
  * Inside this file we will declare our model as a `struct` for storing information about Notes:
    ```swift
    struct Note {
      var content: String?
      let dateCreated = Date()
    }
    ```
* Create our `notes` model inside of `MasterViewController` by creating an array of `Note`'s:
  ```swift
  var notes = [Note]()
  ```

#### Implement the `UITableView` protocols

* Find the `numberOfSections()` table view data source function and change the return value to: `1`
  ```swift
  return 1
  ```
  * Note that `numberOfSections()` is a **Required** function
* Find the `tableView(numberOfRowsInSection)` table view data source function and change it to return the count of `notes`:
  ```swift
  return notes.count
  ```
  * Note that `tableView(numberOfRowsInSection)` is a **Required** function
* Uncomment the `tableView(cellForRowAt indexPath)` function
* In `Main.storyboard` find the Table View Cell in the Master View Controller scene, then inside the **Attributes Inspector** give the table cell the Identifier: `noteCell`
  * **PRO TIP:** Use the **Document Outline** sidebar section to easily highlight different UI components
* Back in `MasterViewController.swift` create a `String` constant for the identifier and use it with the `dequeuResuableCell()` function inside of the `tableView(cellForRowAt indexPath)` function:
  ```swift
  let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
  ```
* Under "Configure the cell" comment in the `tableView(cellForRowAt indexPath)` function, set the `textLabel` of each table view cell equal to the `content` of your `notes` model using the appropriate index
  * You can use `indexPath.row` to give you the row or index the cell is on
  ```swift
  cell.textLabel?.text = notes[indexPath.row]
  ```
* In the `viewDidLoad()` function add a few `Note`s to the `notes` array to test out your table view:
  ```swift
  notes.append(Note(content: "Hello"))
  notes.append(Note(content: "World!"))
  ```
* Build and run the app and you should see 2 cells displayed

## App Navigation: Creating a Segue

A *segue* defines a transition between two view controllers in your app’s storyboard file. We will use segue's to to transition from our `MasterViewController` to our `DetailViewController` whenever a user clicks on a tableView cell or wants to add a new note.

Segue's also provide a way to pass data from one controller to the next. In our case, we will use the segue to pass a `Note` from the `MasteViewController` to the `DetailViewController`.

* Create a segue from the `MasterViewController` tableView cell to `DetailViewController`
  > **PRO TIP:** Use the **Document Outline** sidebar section to easily highlight different UI components
  * Control Drag from the `noteCell` component to the `DetailViewController` scene
  * Select `Show` in the popup to create a segue of type `Show`
  * Click on the new segue in the storyboard then on **Attributes Inspector**. Give it the Identifier name: `showNote`
* In `MasterViewController.swift` create a `String` constant to match the Identifier
  ```swift
  let showNoteSegue = "showNote"
  ```
* Uncomment the `prepare(for segue)` code towards the bottom of `MasterViewController.swift`
* Run the app to test out your segue functionality

## Configuring the DetailViewController

* In `Main.storyboard` add a **Text View** to the Detail View Controller scene
  * From the **Object Library** drag and drop a **Text View** onto the scene and adjust it to fit properly
* Connect the **Text View** as an `IBOutlet` to the `DetailViewController`
  * Make sure you **Show the Assistant Editor** so you can see the Storyboard and `DetailViewController.swift` class next to each other
    > **PRO TIP:** You can hold `Option + Shift` then click on a file to give you different presentation options
  * Create the outlet by control clicking and dragging from the **Text View** onto `DetailViewController`
  * Make sure **Outlet** is selected in the popup and give it the name: `textView`
  * The final `IBOutlet` should look something like this:
    ```swift
    @IBOutlet weak var textView: UITextView!
    ```
* Add a `var` to `DetailViewController.swift` which will be used to hold your `Note`
* Also add a `var` which will be used to store index information. We'll need an index of type `Int` later when we are sending updated `Note`'s back to the `MasterViewController`.
  ```swift
  var note: Note?
  var noteIndex: Int?
  ```
  * **NOTE:** Make sure the `var`'s are optional `?`

* Write a function called `configureView()` to set `textView.text` equal to the value of the note that was passed in from the segue:
  ```swift
  func configureView() {
    if let note = note {
      textView.text = note.content
    }
  }
  ```
* Finally, make sure to call your new `configureView()` function from the `viewDidLoad()` lifecycle function

## Passing Data From Master to Detail Using the Segue

* In `MasterViewController` we need to update the `func prepare(for segue)` function to properly send `Note`'s to the `DetailViewController` when we segue
* Inside the `prepare(for segue)` function we need to do two things:
  * Get the new view controller using `segue.destinationViewController`
  * Pass the selected `Note` to the new view controller
* The `prepare(for segue)` function should look something like the following:
  ```swift
  if segue.identifier == showNoteSegue {
    if let indexPath = tableView.indexPathForSelectedRow {
      let note = notes[indexPath.row]
      let detailViewController = segue.destination as! DetailViewController
      detailViewController.note = note
      detailViewController.noteIndex = indexPath.row
    }
  }
  ```
* Build and run the app and verify that you are passing data correctly to the `DetailViewController`

## Adding Notes To The Model

* In `Main.storyboard` go to the **Object Library** and find a **Bar Button Item**
* Drag a Button Item onto the right side of the navigation bar of the Table View Controller scene
* In the **Attribute Inspector** make the "System Item" equal to "Add"
* In `MasterViewController.swift` find the `viewDidLoad()` method and uncomment the `navigationItem` line of code
* Change the code to use the leftBarButtonItem instead: `self.navigationItem.leftBarButtonItem = self.editButtonItem`
* Build and run the app. We should now have a "Edit" button on the left side of the navigation bar, and a + plus button on the right side

When a user presses the + button we want the app to create a new Note and then navigate to the detail page for editing. To accomplish this we'll need to create a new segue.

* Create a new segue from the + button to the DetailViewController scene
  > **PRO TIP:** Use the **Document Outline** sidebar section to easily highlight different UI components
  * Control Drag from the `+` button to the `DetailViewController` scene
  * Select `Show` in the popup to create a segue of type `Show`
  * Click on the new segue in the storyboard then on **Attributes Inspector**. Give it the Identifier name: `showNewNote`
* In `MasterViewController.swift` create a `String` constant to match the Identifier
  * You should not have the following constants declared:
    ```swift
    let cellIdentifier = "noteCell"
    let showNoteSegue = "showNote"
    let showNewNoteSegue = "showNewNote"
    ```
* Update the `prepare(for segue)` function in `MasterViewController.swift` to handle two different segue's and also add a new `Note` to the model:
  ```swift
  if segue.identifier == showNoteSegue {
    if let indexPath = tableView.indexPathForSelectedRow {
      let note = notes[indexPath.row]
      let detailViewController = segue.destination as! DetailViewController
      detailViewController.note = note
      detailViewController.noteIndex = indexPath.row
    }
  } else if segue.identifier == addNewNoteSegue {
    // Insert a new Note to the model before transitioning to DetailViewController
    notes.insert(Note(content: "New note"), at: 0)
    let indexPath = IndexPath(row: 0, section: 0)
    // Insert a new row in our tableView
    tableView.insertRows(at: [indexPath], with: .automatic)
    let detailViewController = segue.destination as! DetailViewController
    detailViewController.note = notes[0]
    detailViewController.noteIndex = 0
  }
  ```
* Build and run your app to test the + (add note) functionality

## Deleting Notes From The Model

To delete notes from the model we will take advantage of some of the boilerplate code the comes with `UITableViewController`.

* In `MasterViewController.swift` find the `tableView(canEditRowAt IndexPath)` data source function and uncomment it.
* Find the `tableView(commit edityingStyle, forRowAt indexPath)` data source function and uncomment it this one as well.
* Edit the `tableView(commit edityingStyle, forRowAt indexPath)` function to properly delete a `Note` from your model whenever it is called:
  ```swift
  if editingStyle == .delete {
    // Delete the row from the data source
    notes.remove(at: indexPath.row)
    tableView.deleteRows(at: [indexPath], with: .fade)
  }
  ```

## Passing Data Back to Master Using a Delegate

We want to be able to edit notes in `DetailViewController` and have the model in `MasterViewController` get updated. To accomplish this we will use a **protocol** that we define and a **delegate**. We need to make `MasterViewController` a delegate of `DetailViewController`. This allows our DetailVC to send a message back to the MasterVC, thus enabling us to send data back.

For `MasterViewController` to be a delegate of `DetailViewController` it must conform to `DetailViewController`'s protocol which we have to define. This tells `MasterViewController` which methods it must implement.

* First we must define our **protocol** for sending `Note`'s back. Add this to the top of the `DetailViewController.swift` file:
  ```swift
  protocol NoteUpdateDelegate: class {
    func updateNote(_ note: Note, at index: Int)
  }
  ```
  * The `updateNote` funciton is what we'll use to pass a `note` and `index` back to Master.
  * **NOTE:** The protocol and function goes outside of the `DetailViewController` class
* Declare a **weak optional** `delegate` inside the `DetailViewController` class of type `NoteUpdateDelegate`:
  ```swift
  weak var delegate: NoteUpdateDelegate?
  ```
  * We define the `var` as `weak` to avoid creating a **strong reference cycle**.
  * Please see the [GUIDE TO REFERENCES IN SWIFT](https://krakendev.io/blog/weak-and-unowned-references-in-swift) for more details on weak and strong references.

When a user hits the Back button, we need to update the current `Note` and then pass it back to Master. We will use the `viewWillDisappear()` lifecycle method to do this.

* Add the `viewWillDisappear()` method and then inside of the function update the current `Note`. Then use the delegate to pass the note back to Master:
  ```swift
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)

    // Update the current note
    note?.content = textView.text
    // Unwrap both optionals, then use the delegate to call function
    if let note = note, let index = noteIndex {
      delegate?.updateNote(note, at: index)
    }
  }
  ```
* Go back to `MasterViewController.swift` and make the class adopt the `NoteUpdateDelegate` protocol. We will use an **extension** to make things a little cleaner:
  ```swift
  extension MasterViewController: NoteUpdateDelegate {
  }
  ```

Since `MasterViewController` has now adopted the protocol, the class needs to implement the function we defined in the protocol.

* Implement the `updateNote(_ note: Note, at index: Int)` function. Use it to update the `notes` model and also update our table view:
  ```swift
  extension MasterViewController: NoteUpdateDelegate {
    func updateNote(_ note: Note, at index: Int) {
      notes[index] = note
      tableView.reloadData()
    }
  }
  ```

The final step is to assign `DetailViewController`'s delegate to be `MasterViewController`. We can assign the delegate inside the `prepare(for segue)` function since we attain a reference to `DetailViewController` before segue'ing.

* Update the `prepare(for segue)` function to properly assign `DetailViewController`'s delegate:
  ```swift
  detailViewController.delegate = self
  ```
* The final `prepare(for segue)` function should look something like this:
  ```swift
  if segue.identifier == showNoteSegue {
    if let indexPath = tableView.indexPathForSelectedRow {
      let note = notes[indexPath.row]
      let detailViewController = segue.destination as! DetailViewController
      detailViewController.delegate = self
      detailViewController.note = note
      detailViewController.noteIndex = indexPath.row
    }
  } else if segue.identifier == showNewNoteSegue {
    // Insert a new Note to the model before transitioning to DetailViewController
    notes.insert(Note(content: "New note"), at: 0)
    let indexPath = IndexPath(row: 0, section: 0)
    // Insert a new row in our tableView
    tableView.insertRows(at: [indexPath], with: .automatic)
    let detailViewController = segue.destination as! DetailViewController
    detailViewController.delegate = self
    detailViewController.note = notes[0]
    detailViewController.noteIndex = 0
  }
  ```
* Build and run your app to see if you successfully pass data back from Detail to Master.

### References

* [Using Delegation to Communicate With Other View Controllers](http://developer.apple.com/library/ios/featuredarticles/ViewControllerPGforiPhoneOS/ManagingDataFlowBetweenViewControllers/ManagingDataFlowBetweenViewControllers.html#//apple_ref/doc/uid/TP40007457-CH8-SW9) in the View Controller Programming Guide
* [Delegate Pattern](https://developer.apple.com/library/mac/#documentation/General/Conceptual/DevPedia-CocoaCore/Delegation.html)
* YouTube tutorial: [iOS Swift Basics Tutorial: Protocols and Delegates](https://www.youtube.com/watch?v=9LHDsSWc680)
* ["WEAK, STRONG, UNOWNED, OH MY!" - A GUIDE TO REFERENCES IN SWIFT](https://krakendev.io/blog/weak-and-unowned-references-in-swift)

## Bonus Functionality

* Add Persistence
  * Here are some options:
    * Core Data
    * Realm
    * NSUserDefaults
    * Firebase
* Add UI Constraints
  * Make it so the app looks good on any iPhone size