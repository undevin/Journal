# Journal

Students will build a simple journal app to practice MVC separation, segues, table views, and persistence.

Journal is an excellent app to practice basic Cocoa Touch principles and design patterns. Students are encouraged to repeat the building journal regularly until they master the principles and patterns and build journals without a guide.

Students who complete this project independently can:

### Day One

* Understand basic model-view-controller design and implementation
* Create a custom model object with a memberwise initializer
* Understand, create, and use a shared instance
* Create a model object controller with create and delete functions
* Implement the Equatable protocol
* Understand and implement the `UITextFieldDelegate` protocol to dismiss the keyboard
* Create relationship segues in Storyboards
* Implement 'prepare(for segue: UIStoryboardSegue, sender: Any?)' to configure destination view controllers
* Understand, use, and implement the 'updateViews' pattern
* Save and load data using JSON Persistence and the Codable protocol

### Day Two

* Be able to use multiple models in the mvc design pattern
* Be able to refactor an application to reference a new source of truth
* Implement an update function on the model controller to update existing data

## Day One - Model Objects and Controllers

### Setup

1. Make sure you have forked and cloned this project
2. Once you have navigated into this project in terminal (using the cd command), switch over to the starter branch (git checkout starter) and open the project
3. Create a file structure to organize your code (ex. Resources, Views, etc...). Don't forget to relocate your info.plist
* Note: When using it git, it is best to not create a folder (ex. Model Controller) until you have a file to put in the folder. Git does not like tracking empty folders.

### Entry

Create an Entry model class that will hold title, text, and timestamp properties for each entry.

1. Add a new `Entry.swift` file and define a new `Entry` class.
2. Add properties for title, body and timestamp (hint: timestamp should not be a String or an Int).
3. Add a memberwise initializer that takes parameters for each property.
* Consider setting a default parameter value for the timestamp.

### EntryController

Create a model object controller called `EntryController` that will manage creating and deleting entries.

1. Add a new `EntryController.swift` file and define a new `EntryController` class within then class.
2. Create a `shared` property as a shared instance (hint: remember, shared instances require an important keyword at the beginning of the line of code).
3. Add an `entries` array property, and set its value to an empty array of `Entry`.
4. Create a `createEntryWith(title: ...)` function that takes in a `title`, and `body`. It should create a new instance of `Entry` and add it to the `entries` array
5. Create a `delete(entry: Entry)` function that removes the entry from the entries array
* There is no 'removeObject' function on arrays. You will need to first find the index of the object and then remove the object at that index.
* You will face a compiler error because we have not given the Entry class a way to find equal objects. To resolve the error, implement the Equatable protocol in the next step.

### Equatable Protocol

Implement the Equatable protocol for the Entry class. The Equatable protocol helps to check for equality between variables of a specific class. To ensure that the two objects we are comparing are the same, we will need to make sure the values of all the variables (title, body, and timestamp) are the same. 

1. Conform to the Equatable protocol in an extension to the bottom of the `Entry.swift` file. This will prompt you with and error - use the fix button to add the necessary protocol stub (function).
2. Return the result of the comparison between the 'lhs' and 'rhs' parameters by checking the property values on each parameter.
3. If you have not already, go back to your EntryController and finish building out the delete function.

### Entry List View

Build a view that lists all journal entries. Use a UITableViewController and implement the UITableViewDataSource functions.

The UITableViewController subclass template comes with a lot of boilerplate and commented code. For readability, please remove all unnecessary boilerplate from the code.

This view will reload the table view each time it appears in order to display newly created entries.

1. Add a UITableViewController as the root view controller in Main.storyboard and embed it into a UINavigationController.
2. Create an `EntryListTableViewController` file as a subclass of UITableViewController. Set the class of the root view controller scene in your Main.storyboard to be an `EntryListTableViewController`.
3. Implement the UITableViewDataSource functions using the EntryController `entries` array.
* Pay attention to the `reuseIdentifier` in the Storyboard scene and the `dequeueReusableCell(withIdentifier:for:)` function call.
4. Set up the cells to display the title of the entry (hint: this will need to be done in the cellForRowAt method). Do not forget to set your cell type to 'basic' on your view controller scene.
5. Implement the UITableViewDataSource `tableView(_:commit:forRowAt:)` function to enable swipe to delete functionality
6. Add a UIBarButtonItem to the UINavigationBar. Select 'Add' in the System Item menu from the Identity Inspector to set the button as a plus symbol. These are system bar button items, including localization and other benefits. Don't do anything further with this button, we will take care of it later.

### Pause and test things out....
If you run your application now, you should see a tableView with nothing on it. You should also see a plus button in the top right corner that, when tapped, does nothing. While this is correct, it doesn't really give us a way of testing out our code. At the moment, we still have a bit more to implement before we can test anything. This is where mock data becomes useful. In your viewDidLoad lifecycle method, after super.viewDidLoad(), add the following code `EntryController.shared.createEntryWith(title: "Test Title", body: "Test Body")`, followed by `tableView.reloadData()`

Re-run your app. You should now see an entry on your tableView with the title "Test Title". Clicking on it won't do anything yet, however, you should be able to swipe to delete. If you can see "Test Title" and are able to delete it, your code is in a good place and you can move on. If not, spend 20 minutes to try and work it out. If you cannot solve your problem in 20 minutes, post a message in the queue channel on discord.

Once you have everything working, make sure to remove the two lines of code we added to the viewDidLoad lifecycle method.

### Detail View

Build a view that allows a user to create a new entry, or view an existing one. Use a UITextField to capture the title, a UITextView to capture the body, a UIBarButtonItem to save the new entry, and a UIButton to clear the title and body text areas.

The Detail View should follow the 'updateViews' pattern for updating the view elements with the details of a model object. To follow this pattern, add an 'updateViews' function that checks for a model object. The function updates the view with details from the model object.

1. Add an `EntryDetailViewController` file as a subclass of UIViewController and add an optional `entry` property to the class. You can remove the navigation boiler-plate code.
2. Add a UIViewController scene to Main.storyboard and set the class to `EntryDetailViewController`
3. Add a UITextField for the entry's title text to the top of the scene (don't forget to constrain it), add an outlet to the class file called `titleTextField`. Set the delegate relationship by adopting the UITextFieldDelegate protocol in the `EntryDetailViewController` class.
* Step 3 is something you have not seen before. Take 20 minutes to try and figure out how to do this (use google and stack overflow). If you cannot figure it out, no worries, connect with an instructor via the queue channel.
4. Implement the delegate function `textFieldShouldReturn` and call the resignFirstResponder() method on the titleTextField to dismiss the keyboard.
* Like Step 3, Step 4 is something you have not seen before. Take 20 minutes to try and figure out how to do this. If you cannot figure it out, connect with an instructor via the queue channel.
5. Select your UITextField and give it a default placeholder of "Enter title here..."
6. Add a UITextView for the entry's body text beneath the title text field and add an outlet to the class file `bodyTextView`.
7. Give the UITextView a default text of "Write entry here... "
8. Add a UIButton beneath the body text view and add an IBAction to the class file that clears the text in the titleTextField and bodyTextView.

Now, we need to add a save button to the top right corner, but our navigation bar is not present because we have not created a segue from the `EntryListTableViewController` yet. So let's do that, and then we can wrap up our detail view.

### Segue

Add two separate segues from the List View to the Detail View. The segue from the plus button will tell the EntryDetailViewController that it should create a new entry. The segue from a selected cell will tell the EntryDetailViewController that it should display a previously created entry.

1. Add a 'show' segue from the Add button to the EntryDetailViewController scene. This segue will not need an identifier since we will not be passing information using this segue. 
2. Add a 'show' segue from the table view cell to the EntryDetailViewController scene and give the segue an identifier.
*When naming the identifier, consider that this segue will be used not only to display an existing entry but also to edit an entry(day 2)*.
3. Add a `prepare(for segue: UIStoryboardSegue, sender: Any?)` function to the EntryListTableViewController (hint: this comes as part of the boiler-plate code, all you should have to do is uncomment it).
4. Implement the `prepare(for segue: UIStoryboardSegue, sender: Any?)` function. If the identifier is 'showEntry' (or whatever entry name you used on Step 2) we will pass the selected entry to the DetailViewController, which will call our `updateViews()` function (which we will create shortly).
* You will need to capture the selected entry by using the indexPath of the selected row.
* Remember that the `updateViews()` function will update the destination view controller with the entry details.

### Wrap-Up Detail View

Hop back to your `EntryDetailViewController` and finish out the remaining steps.

1. Add a UIBarButtonItem to the UINavigationBar as a `Save` System Item and add an IBAction to the class file called `saveButtonTapped`.
2. In the `saveButtonTapped` IBAction, using an if let (conditional unwrapping) check if the optional `entry` property holds an entry. If it does, add a print statement that says "to be implemented tomorrow". If not (meaning if the `entry` property is nil, call the `createEntryWith()` function on the `EntryController`. This will require you to use your outlets to access the users title and body inputs.
3. Still inside the `saveButtonTapped` IBAction, but outside of the if let, add code to dismiss the current view and pop back to the `EntryListTableViewController`.
4. Add an `updateViews()` function that checks if the optional `entry` property holds an entry (hint: use a guard statement to do this). If it does, implement the function to update all view elements that reflect details about the model object `entry` (in this case, the titleTextField and bodyTextView)
5. Update the `viewDidLoad()` function to call `updateViews()`

At this point your app should be working almost perfectly. You might notice, however, when you create a new entry and navigate back to the `EntryListTableViewController`, your new entry is not there. To fix this, call the method to reload your tableView's data inside of the `viewWillAppear()` function (hint: you will need to add this lifecycle method to your code).

At this point, everything should be working. However, we do still have one final problem. If we stop the app and re-run it, none of our data is there. To solve this, we are going to need to add persistence. 

### Add Data Persistence functionality to the EntryController

Our `EntryController` object is the source of truth for entries. We are now going to add a layer of persistent storage. We need to update the `EntryController` to save the entries array to persistent storage when a change happens (whether it be an entry is created or deleted). Will will also need to create the functionality to save to the persistent store and load from it.

#### Creating the URL
1. Copy and paste this method into the project. Note that this method returns a URL, which is the URL for the file location where we will be saving our data.
```
private func fileURL() -> URL {
    let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    let documentsDirectoryURL = urls[0].appendingPathComponent("Journal.json")
    return documentsDirectoryURL
}
```

#### Saving data to the URL
1. Write a method called `saveToPersistentStorage()` that will save the current entries array to a file on disk.
2. Call `encode(value: Encodable) throws` on an instance of JSONEncoder, passing in the array of entries as the Encodable argument. Assign the return of this function to a constant named `data`. _**NOTE - The objects in the array need to be `Codable` objects.** Go back to the Entry class and adopt the Codable protocol._  Please see Encoding & Decoding Custom Types:  https://developer.apple.com/documentation/foundation/archives_and_serialization/encoding_and_decoding_custom_types or reference the guided lecture from this morning.
3. Notice that this function throws; that means that this function will throw an error if it does not work the way it should when called. Functions that throw need to be marked with `try` in front of the function call. Put this call inside a **do try catch block** and `catch` any error that throws. 
4. Call `data.write(to: URL)` This function asks for a URL. We can pass in the `fileURL()` as an argument, which will write the data at the URL. *Hint - This is also a throwing function and needs ALL the parts of a **do try catch block**.*
5. Call `saveToPersistentStorage()` any time that the list of entries is modified (CRUD functions)

##### Quick lesson on local urls 
The screenshot below shows how local URLs work. URLs are not just web-based. On the computer, there are local file URLs. Open the finder and right-click to "get info". When done, it will show the location of the folder on the local machine. For example, Joey's Mac / Desktop / Dev Mountain Bank / etc. 
Local files are separated by components which are forward-slashes. Extensions are . (dots). Images are a good example of extensions such as .jpg or .png. In the above code, we are saving our information as .json data.
<img width="1676" alt="screen shot 2018-10-01 at 11 03 26 am" src="https://user-images.githubusercontent.com/23179585/46303711-d7f20300-c569-11e8-979a-d5b777e371ea.png">

#### Loading data from the URL
1. Write a method called `loadFromPersistentStorage()` that will load the current data from the file on disk where we saved our entries(data). 
2. Create a constant called `data` to hold the data that you will get back by calling `Data(contentsOf:)`. Now pass in the `fileURL()` as an argument (hint: this is a throwing function).
3. Call `decode(from:)` on an instance of the JSONDecoder. Assign the return of this function to a constant named `entries`. This function takes in two arguments: a type `[Entry].self`, and your instance of data. It will decode the data into an array of Entry.
4. Now set self.entries to this array of entries.
5. Finally, you need to call the `loadFromPersistentStorage()` function. While there are many different places you could do this successfully, for now, go to the `viewDidLoad()` lifecycle method in your `EntryListTableViewController` and call `EntryController.shared.loadFromPersistentStorage()`.
* Note: The first time you run your app after implementing your persistence functions you will have no saved data, and therefore you will see an error message in your debug console. This is normal. After you have stored data you should not recieve an error message when `loadFromPersistentStorage()` is called.

Run the app; it should now function properly— make sure to thorougly test for bugs. You should be able to:
1. Upon launch, see a tableView with all entries (none if you haven't created any or have deleted all of them).
2. Be able to click the add button in the top right corner and navigate to the `EntryDetailViewController`.
3. Be able to hit the clear button at the bottom of the screen and see you text field and text view become empty.
4. Click the save button in the top right corner of the `EntryDetailViewController` and be navigated back to the `EntryListTableViewController`, where you should then see your newly created entry.
5. Be able to click on an entry in the `EntryListTableViewController` and be navigated to the `EntryDetailViewController` where you should see that entry's title and and body text (if you click save here it should simply navigate you back to the `EntryListTableViewController` and your debug console should prompt you with a message that says: "to be implemented tomorrow").


## Day Two - Controller Implementation

Today you are going to expand upon your Journal application. So far you have a single journal that can store one or many entries. We are going to refactor our application so that we can have an array of journals (ex. Travel Journal, Pain Journal, etc...). In order to do this, a few things are going to have to change. For starters, we won't have a source of truth that contains an array of entries anymore. Instead, you will need to have a source of truth that contains an array of journals, and each journal will hold an array of entries. Here is a breakdown of what you will need to do:
1. Create a Journal model.
2. Create a Journal model controller.
3. Move persistence methods from the EntryController to the JournalController.
4. Refactor the storyboards to start with a list of Journals.
5. Add an update(entry: Entry) function to the EntryController.

### Journal

Create a Journal model class that will hold a title and an entries property.

1. Add a new `Journal.swift` file and define a new `Journal` class.
2. Add properties for title and entries (hint: entries will be an array of Entry).
3. Add a memberwise initializer that takes parameters for each property.
* Consider setting a default parameter value for the entries array.

### JournalController

Create a model object controller called `JournalController` that will manage creating, deleting and updating journals. Steps 6 and 7 are going to take a little bit of thinking. Give it your best shot! If you are stuck for more than 20 minutes send a message in the queue channel.

1. Add a new `JournalController.swift` file and define a new `JournalController` class within then class.
2. Create a `shared` property as a shared instance.
3. Add an `journals` array property, and set its value to an empty array of `Journal`.
4. Create a `createJournalWith(title: String)` function that takes in a `title`. It should create a new instance of `Journal` and add it to the `journals` array
5. Create a `delete(journal: Journal)` function that removes the journal from the `journals` array.
* Find the index of the object and then remove the object at that index.
* You will face a compiler error because we have not given the `Journal` class a way to find equal objects. To resolve the error, implement the Equatable protocol on the `Journal` class.
6. Create an `addEntryTo(journal: ...)` function that should take in an existing journal as a parameter as well as an entry. In the body of this function append the entry to the journals array of entries.
7. Create a `removeEntryFrom(journal: ...)` function that should take in an existing journal as a parameter as well as an entry. In the body of this function you will need to find the index of the given entry, and then remove the object at that index from the given journals array of entries.

### Add Data Persistence functionality to the JournalController

With our `EntryController` no longer being the best location for our source of truth, we are going to have to refactor it quite significantly. Starting with changing the location of our persistence functions. 

1. Copy the `fileURL()` function on our `EntryController` and paste it at the bottom of the `JournalController`.
2. Write a `saveToPersistentStorage()` method that will save the current journals array (hint: this will look exactly like the `saveToPersistentStorage()` method you have on the `EntryController`, except it will save journals instead of entries).
* _You code will likely give you an error. We cannot encode or decode without first making our model Codable._
3. Write a `loadFromPersistentStorage()` method that will load the saved data (hint: this will look exactly like the `loadFromPersistentStorage()` method you have on the `EntryController`, except it will load journals instead of entries).
4. You can now delete the persistence functions (`fileURL()`, `saveToPersistentStorage()`, and `loadFromPersistentStorage()`) from the `EntryController` altogether. You will also need to go into each CRUD function on the `EntryController` and remove the `saveToPersistentStorage()` function.
5. Back on the `JournalController`, make sure to call `saveToPersistentStorage()` at the end of each one of your CRUD functions, if you have not already.

### Refactor EntryController

We still need to do a little more refactoring to our `EntryController`.

1. We no longer need to entries array (former source of truth), because our entries will now will on a journal object. So delete `var entries: [Entry] = []` (ignore any errors for the moment).
2. Beause we no longer have an entries source of truth, there is not a need to have a shared instance. Sure, it gives us access to these functions, but that is not a good enough reason to have a shared instance. So delete `static let shared = EntryController()`.

We have now trimmed down our `EntryController` significantly, and what remains has errors. The remaining code is attempting to utilize the entries array that no longer exists. 

3. In the `createEntryWith()` function, remove `entries.append(newEntry)` and instead call the `addEntryTo()` function that lives on your `JournalController`. You will note that this function requires you to pass in a journal, which means you will also need to modify the `createEntryWith()` function parameters to take in a journal and then pass that journal into your `createEntryWith()` function.
4. In the `deleteEntry()` function, remove all the code. None of it will work. However, you have already written the code needed for this work. Simply call your `removeEntryFrom()` function located in your `JournalController`. Like Step 3, this function requires a journal. So, modify the the `deleteEntry()` function parameters to take in a journal and then pass that journal into your `removeEntryFrom()` function.
5. Now, because `EntryController` no longer has a shared instance, these functions are no longer accessible. To make them accessible, add the `static` keyword before both functions.

If you were to build now you would notice we have a few errors. That is because you have multiple lines of code referring to an EntryController.shared which no longer exists. Don't worry, it will all be taken care of.

### Refactor Storyboard
1. Delete the Navigation Controller in your Main.storyboard. This is going to make your add button () and save button () dissappear. Don't freak out though. They are actually still hiding in there.
2. Add a View Controller (yes - a viewController, not a tableViewController) to your Main.storyboard and then embed it in a Navigation Controller.
*_Hint: You will need to reset your storyboards inital view controller._
3. Add a view to the top of your view controller and constrain it to have a height of 100, be 32 points from the top, and 0 points from the view controllers leading and trailing edges.
4. Add a table view to the view controller you just added. Give the table view 1 prototype cell. Set the cell to have a style of right detail. Give the cell an identifier of `journalCell`.
5. Constrain your table view with 0's on all sides (top should be referring to the view you just added).
6. Add a show segue from the cell to your `EntryListTableViewController`. This should bring your add bar button and save bar button back. Give the segue an identifier of `toEntryList`.
7. Add a textField and a button to the view at the top of your view controller. Embed them in a stack view and make sure the axis is set to vertical. Set the alignment to Fill, the distribution to Fill Equally, and the spacing to 8.
8. Constrain the stack view to be centered horizontally and vertically in the view. Set it to have a width equal to 80% of the view.
9. Give the textField some placeholder text like, `Enter Journal Title Here...` and give the button a label like, `Create New Journal`.

You might have noticed that the view controller still has no class, and that is correct. That is because we have not created a view controller file to control this view controller scene. Next you will create that view controller file, connect the outlets and actions, and build out the necessary functions. After that, you will modify the `EntryListTableViewController` and `EntryDetailViewController` as needed.


### JournalListViewController

Create a view controller called `JournalListViewController` that will manage your Journal List view controller scene. 

1. Add a new `JournalListViewController` file (subclass of a UIViewController) and delete boiler-plate comments that you don't want.
2. Class your Journal List view controller in your Main.storyboard as a `JournalListViewController`.
3. Connect your text field outlet and name it `journalTitleTextField`.
4. Connect your create new journal button action and name it `createNewJournalButtonTapped`. You will come back and build out this function on step 8.
5. Connect your tableView outlet and name it `journalListTableView`.
*_Don't forget to set your dataSource and delegate for your  `journalListTableView` (hint: this will prompt you with an error, fix it)._
6. Build out your two dataSource functions `numberOfRowsInSection` and `cellForRowAt`. 
*_In `cellForRowAt`, include the title of your journal and the count of it's entries. You will notice that `cellForRowAt` does not include a default cell that a tableViewController provides for you. You will need to add this yourself. Give it your best shot. Reference your EntryListTableViewController for help. Reach out in the queue channel if you have not solved it after 20 minutes._
7. Now, when you navigate (or segue) over to your `EntryListTableViewController`, you need to tell your `EntryListTableViewController` which journals entries to load. This is where `prepare(for segue)` is crucial. This function allows you to pass a specific journal over. Build out your `prepare(for segue)` function, and pass over whichever journal the user selected.
*_Hint 1: You will notice that you don't have access to a tableView in your `prepare(for segue)` function. You will need to access the `indexPathForSelectedRow` of your `journalListTableView`._
*_Hint 2: Make sure to go to your `EntryListTableViewController` and give it a landing pad to receive a journal. This should be an optional Journal._
8. Let's not forget about our `createNewJournalButtonTapped`. In the body of this IBAction, use the text from your `journalTitleTextField` (making sure it is not empty) to create a new journal. After calling your `createJournalWith()` function, tell your `journalListTableView` to reload it's data, and set the  `journalTitleTextField` back to an empty string.
9. Finally, before you move on, go up to your lifecycle methods and and the `viewWillAppear()` method. Inside this method, tell your table view to relaod it's data. That way, when you navigate back to this page, you can show the updated amount of entries in any given journal.


### Refactor EntryListTableViewController

Finally, you can fix some of those errors that have been showing on your `EntryListTableViewController`. To do this, you are going to refactor your dataSource methods to refer to the entries of the Journal you just passed over, instead of using `EntryController.shared.entries`, which no longer exists. (Hint: Make sure you are using auto-complete as you type your code.)

1. Remove the `EntryController.shared.loadFromPersistentStorage()` line of code in your `viewDidLoad()`. It is no longer necessary. Our app now loads our data when it launches to the `JournalListViewController`.
2. Update your `numberOfRowsInSection` method to return the count of the entries of your journal property.
*_Hint: Because the journal is optional, and cannot be guaranteeed to be there, you will need unwrap it. Or, this might be a good ocassion to use nil-coalescing._
3. Update your `cellForRowAt` method to refer to a specific entry from the array of entries on your journal property.
*_Hint: Because the journal is optional, and cannot be guaranteeed to be there, you will need unwrap it. If it is nil, you will want to return a `UITableViewCell()`._
4. Update your `commit editingStyle` method to refer to a specific entry from the array of entries on your journal property. Delete the `EntryController.shared.deleteEntry(entry: entryToDelete)` line of code and retype it. This time, you will not need to use the a shared instance. So your line of code should look something like this: `EntryController.deleteEntry(entry: <#T##Entry#>, journal: <#T##Journal#>)`. Make sure to pass in your entry and journal.
*_Hint: Because the journal is optional, and cannot be guaranteeed to be there, you will need unwrap it._
*_Step 4 is a tough one. Give it your best attempt. If you cannot solve it after 20 minutes, send a message in the queue channel._
5. Like with steps 2, 3, and 4, you will need to update your `prepare(for segue)` method to refer to a specific entry from your journal property.
*_Hint: Because the journal is optional, and cannot be guaranteeed to be there, you will need unwrap it._

### Refactor EntryDetailViewController

You will notice you still have one error on you `EntryDetailViewController`. It is trying to call `EntryController.shared` which no longer exists.

1. Delete that line of code and recall the function without using a shared instance.
*_You will see that there is still a problem. You need to pass in a journal, but do not have access to one. You will fix this over the next few steps._
2. Add an optional journal property below your `var entry: Entry?`.
3. Within your guard statement in `saveButtonTapped()`, unwrap your optional journal.
4. Pass in the unwrapped title, body, and journal to your `EntryController.createEntryWith()` function.

### Update EntryListTableViewController to pass a Journal
1. Go back to your `prepare(for segue)` method on your `EntryListTableViewController` and pass over your unwrapped journal to your destination's journal property.
2. Now, while this will pass a journal over to the `EntryDetailViewController` if you select on an existing journal, it will not work if you click the add button in the top right hand corner to create a new entry. To fix this, you need to look at your `prepare(for segue)` method. It has code that checks `if segue.identifier == "showEntry"`. If it does not, however, we still need to pass the journal over. So, add on `else if segue.identifier == "createNewEntry"`. In here, you will need to unwrap the destination and journal, and set the destination's journal property to the value of that unwrapped journal.
*_Hint: Don't forget to give the segue an identifier on your Main.storyboard._

Run your app. You should see a near-complete, working app. If you do not, spend 20 minutes debugging and then send a message in the queue channel if your bugs are  ot resolved. You have one final change to make. At the moment, if we click on a journal's entry, we can see it displayed in the detail view. However, if we make changes to it and click save, none of the changes are actually saved. Instead we see a print out in our debug console saying "We will handle this tomorrow." Well, tomorrow is today, so let's handle it...

### Add update( ) to EntryController
1. At the moment, we don't have a function to update an entry, so go to your `EntryController` and add a static function called `update()`. It should take in 3 parameters: an entry, a title, and a body.
2. In the body of `update()`, set the passed in entry's title to the passed in title, and the entry's body to the passed in body.
*_Hint: If you get any errors here, go and check the properties on your `Entry` model. Are they constants or variables?_
3. Now, you need to save your changes. In order to do this, call the `saveToPersistentStorage()` function on your `JournalController`.

### EntryDetailViewController - the final edit
1. Go to your `EntryDetailViewController` and, inside your `saveButtonTapped()` IBAction, replace `print("We will handle this tomorrow.")` with a call to your newly created `update()` function on your `EntryController`.

Run your app. It should be working perfectly now! If it does not, spend 20 minutes debugging, and if you cannot solve the problem please send a message in the queue channel.

You might be thinking, "This was a lot of work to refactor this application. Might it have been easier just to rebuild it from scratch?" It might have been. This prompts two thoughts. Firstly, this demonstrates the importance of planning and understanding what you want to include in an app. Propper planning will often save you a lot of time coding. Secondly, it is still of immense benefit to have to refactor applications while learning. It helps you develop a better understanding of how data is moving around your app. Use refacrotring opportunities for this purpose. It is also worth keeping in mind, if you are working on an app that is thousands of lines long you will most certainly not want to rebuild the whole application.

### Black Diamonds
* You might have noticed that your Entry model includes a timestamp, but it has not been used anywhere. Update your `EntryListTableViewController` scene to have a style of right detail instead of basic. Update your `EntryListTableViewController` file to show the timestamp in the detail text view. _Hint: Do some research on `DateFormatter()`, it can provide you some ways of turning a swift date into a nice looking string._
* On your JournalListViewController, adjust the `Create New Journal` button to be grayed out and unselectable if the `journalTitleTextField` is empty.
* Add support for tags on journals, add functionality to select a tag to display a list of entries with that tag.

## Copyright

© DevMountain LLC, 2015. Unauthorized use and/or duplication of this material without express and written permission from DevMountain, LLC is strictly prohibited. Excerpts and links may be used, provided that full and clear credit is given to DevMountain with appropriate and specific direction to the original content.
