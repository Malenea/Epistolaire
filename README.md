# Epistolaire
Blink take home test

Blink take home test is a test that asks to create a basic chat using a provided json file to have a offline-first focus.

## Timeline and choices
The test was realised in roughly 3 hours adding an extra for documentation and commenting.
Since no limitations were specified, the test was made using SwiftUI, it would however not be an issue to do the same test with UIKit. Replacing lazy stacks with a simple table view for the inbox and
collection view for the chat itself. SwiftUI allowed me to work more efficiently on the UI and react part.
One third party framework used for testing purposes (https://github.com/pointfreeco/swift-snapshot-testing), this allowed me to implement the snapshot tests.

## My take on it
### Architecture and design
I went for a hybrid architecture that resemble MVVM-c but with nested structures and more state based behaviour.
Design was made to separate the app in several layers each with their own responsability and minimum dependency.

- **Data layer** (and data protocols and data mocks) is at the top level, it contains the placeholder for a future API call and the methods to get the data from a json.
- **Domain layer** is below the data layer, it contains the business entities and the fixtures used for mocking them.
- **Shared layer** contains the helpers and extensions that are used across the features and the app.
- **Feature layer** contains the different feature modules and their business logic (at the moment, only the messaging feature).

Each layer was created to respect the **SOLID** principle.

The coordinator is used to handle the flow, presentation, pushes and dismisses of each view, as well as placeholders for view specific events.
The view design is so that the view itself serves as an event handler hub and embeds nested view model and view (named ContentView) to separate them from any business logic, making them testable from generic mocks.

## Business logic decisions
Some decisions were made on my side to deliver that test.

- The json is extracted as is, extracting all conversations and all messages at the same time.
- The replies are automatically appended at the end of the message stack, but are not retained on leaving the screen.
- The replies are automatically considered the same as the others, there is no distinction between user and person who is talked to.

## Testing
Basic testing were added, somes are still missing, but the idea was to test the UI and the most important logic parts of the app.

- Snapshot testing is added through mocking UI views and dependency injection to insure UI consistency and unwanted changes.
- Unit testing is added on interactors to insure consistency of results, this could be improved and is mainly here to have some unit testing.

## Limitations & improvements
Some limitations were decided for a matter of time, but through iterations, could be implemented.

- The added replies have no way to differentiate between the user and the person who is talked to, so the replies just add to the pile and are displayed the same. In the ideal we might want some user id to
be able to format messages differently to make the distinction between different senders.
- The added replies are ephemeral atm, they will get discarded upon leaving the view. In the ideal and depending on how sensitive the data is, we could find a way to store it, either using Core Data
or a more secure encryption solution.
In the ideal they would be stored locally until BE is reachable. At that stage it should push the changes to BE and retrieve the updated chat making sure to use ID and timestamps to keep idempotency.
- The different chats are retrieved from the json file (and later on API) provided each time, but for a full offline mode, we would want to store locally those chats (again securely) and just use timestamps, and specific calls to retrieve the right updates (new chats or new replies).
- Testing could also include UI and flow testing. By mixing flow testing, unit testing and snapshot testing, we could ensure consistency across flows and make sure that both UI and data are consistent as well as navigation and business logic.
- Because of the offline mode and the lack of real updates / calls, we currently have a very neat happy path, implementing error handling should be fairly easy on the choosen architecture and should be thought of.
- For the sake of time and simplicity a lot of my views are very similar or use some code that ressemble, all that could be extracted to a generic factory to reduce the number of lines and make creation of new views easier.
- The app is missing a UI library that would have, on top of components, a source of truth for paddings, colors, fonts and sizes in general.
- Localisation was not accounted for, and every string should be localised. Some extremely basic localisation was taken in account as a placeholder to iterate on it (such as the use of `leading` and `trailing` instead of right and left).
- Accessibility was also not accounted for, and though because all of it uses system fonts and methods it should not be an issue, it was not tested and refined. Dark mode would probably be very fun to try, since no color scheme were provided to account for it.
- `Marks` and `comments` were added to a minimum, but in the ideal they should be more informative and should be extractable to documentation.

## Conclusion

I've tried my best at providing an app that is scalable and innovative architecture and pattern wise while keeping good practices, though not being your full typical design.
Given how simple the app is, we could have chosen to go for a simpler architecture and design, while retaining the scalability, but because it's made in the context of a test, it was also to showcase some boldness and leads to reflect. It's not perfect, but I think and hope it shows a lot of how I like to envision and debate about my code.

## Post-Scriptum

The app uses SPMs both local and for the snapshot package. It was tested 3 times on my side by re cloning each time from scratch and running the app, and worked as expected.
