# Summary

## All have been completed according to the homework requirements

👉 Must compile (No Errors or warnings)

👉 Swift (No Objective-C)

👉 Layout is done programmatically (No storyboards or nibs)

👉 Use MVVM architecture

👉 Light & dark mode compatible

👉 No third party libraries

👉 Support all iPhones with a screen size greater than or equal to 4.7 inches (Support for iPad is not required)

👉 The UI should not be hardcoded (Use packages.json to simulate an API call and populate the UI)


## Small summary of the reasoning behind the technical decisions

* A simple TableView is used as a container to show packages, in which collectionView is used in the small thumbnail area to realize horizontal sliding, and the page structure is concise and clear.

* The UI and Model are completely separated. The data needed on the View must be provided by the viewModel. The View does not hold the Model data directly.

* Use the system serialization method directly to convert the local Json data into a Model object for subsequent view padding. For simplicity, the method is directly encapsulated in the JsonTool class. Use more sophisticated encapsulation for formal projects or use a full-fledged tripartite library such as SwiftyJson.

* The network image download function uses the contentsOf method of Data class, which downloads the original Data to the local through the URL and converts it into image. It uses asynchronous download and adds the image to the cache. When the image is reused later, it can be directly read from the local cache. Use more sophisticated packaging for formal projects or use a full-fledged three-party library such as Kingfisher.

## Other information

* The image resource size is too large, which will take up too much memory and affect the user experience. The official project recommends reducing the image size scale and using different sizes for the main thumbnail and small thumbnail to optimize memory footprint.

* The number of small thumbnails is not specified, such as how to display when the number is less than 4 or greater than 4, which affects the dynamic calculation of the size of the small thumbnail. Of course, there is no ambiguity about the fixed use of four small thumbnails in this project.

## Thanks

* Thank you very much for providing me with this opportunity. I may not be the best, but I will be very serious and active to complete everything, and always maintain a high degree of enthusiasm for work.

* I really hope that I can join the big family like NuraLogix and make my own contribution to the application of artificial intelligence technology.

* Looking forward to your feedback, thanks again! 😊

