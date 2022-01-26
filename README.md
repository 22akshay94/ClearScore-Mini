# ClearScore-Mini
A mock app for ClearScore coding challenge

## How to run the app:
  1. Clone the project from the main branch into an empty folder
  2. Install the requisite pods using ```pod install``` command. If cocoapods are not install in the system please install cocoapods first using the ```sudo gem install cocoapods``` command
  3. After successfully installing the pods, open the app in Xcode using the ```ClearScore-Mini.xcworkspace``` file.
  4. Select a simulator and click ```Run``` to run the app.
  
## App design:
Since **_Test Driven Development_** is an important part of **_Agile_** development process, **_MVVM-C_** design pattern has been chosen to structure the app. This design pattern also helped to make the code more loosely coupled and modular.

The app consists of one main model, the **_CreditReport_** model, which houses the **_CreditReportInfo_** sub-model.

All the business logic in the app is contained in the **_CreditViewModel_**, which utilises the **_CreditReport_**. This view model is injected into the first view controller of the ap flow, i.e. **_HomeViewController_** using **_Method Injection_** since most of the UI is created using storyboards. Protocols and generics have been used wherever it was deemed to be necessary since in a product grade code base, reusability of code should be of the essence.

## Assumptions:
The **_Decodable_** protocol was chosen instead of **_Codable_** since the only API being consumed in this mock app is a **_GET_** request. If required, this protocol could easily be refactored throughout the app to re-use the models for other CRUD requests as well.

## Things I did differently:
I added a 2 second delay in the completion block after the API call in HomeViewController to show the shimmer animation before the data loads in the donut view (I really like to play with animations :sweat_smile:)

## Things I could have done if I had more time:

  1. Initialiser Injection: The first thing I would've done different is implementing **_Initialiser Injection_**. This would require creating the UI programmatically. Using Method Injection led to comparitively less mutablility but I was able to finish the task faster.
  2. Another thing which I probably would've done is using View Model Binding to update the UI more dynamically.
  3. I could've written more and better test cases where more funtionality would be present in the app (this is more about this being a mock app rather than a time constraint issue).
  4. Better naming conventions: The naming conventions might seem a little haphazard (e.g. names of a couple of protocols). I would defnitely take care of this if I had more time.
  5. The shimmer animation could probably use a little improvement as well.
  
