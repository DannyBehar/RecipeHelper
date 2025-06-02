### **Summary: Include screen shots or a video of your app highlighting its features**
https://github.com/user-attachments/assets/4765d2dd-9f13-46bc-bd61-a828c2eff253

### **Focus Areas: What specific areas of the project did you prioritize? Why did you choose to focus on these areas?**
I focused on the following core features:
- Fetching and caching the recipes metadata and images
- Searching and filtering by cuisine
- Quick links for youtube and web recipe if available
- Share sheet for web and youtube links
- Accessibility (VoiceOver, DynamicType, Dark Mode)

And the technical stack overview:
- Unit Tests with Swift Testing
- Fetching and caching with Swift Concurrency, URLSession, and URLCache
- SwiftUI with ObservableObject
- Full support for SwiftUI previews
- Utilizes assets in the Preview folder for previews and unit tests which is set to be a developer resource and therefore won't ship to the IPA!

These are the core set of features that I'd want as a user of the app. I wanted to concentrate on this core set of features in order to deliver a high quality, accessible, and flexible experience. 


### **Time Spent: Approximately how long did you spend working on this project? How did you allocate your time?**
I started working on the project Wednesday evening on May 28th 2025 and added the finishing touches on Monday morning June 2, 2025. I Worked on the project off and on in 1-2 hour work sessions while balancing other work and responsibilities.

### **Trade-offs and Decisions: Did you make any significant trade-offs in your approach?**

#### **Regarding my decision to use SwiftUI List rather than a lazy Container view**
I used a SwifUI list because it lazily loads and reuses the cells. I did think about using a LazyVGrid wrapped in a ScrollView but there doesn't appear to be any layout container in SwiftUI from Apple that reuses cells other than the list component. List therefore appears to be the more performant option and also looks nice!

#### **Regarding my decision to target iOS 16 minimum version** 
- iOS 16 provides enough base SwiftUI funcitonality while supporting a currentRelease - 2 version compatibility
- While using the Observation framework available in iOS 17 would have been more performant and nice to have, I'm not so sure I would have seen as much gains for the app in it's current state. This is something I expect to start to see more of a difference once the app begins to scale.

### Weakest Part of the Project: What do you think is the weakest part of your project?
I don't have unit tests specifically for the data service implementation specifically targeting the caching functionality. With more time, I'd definitely take a closer look into understanding how I could organize my code to be able to accomplish this. This was my first time working with URLCache and it was very much a guess and test approach while working with the Charles application for Mac. I also went back and forth over whether I should create an actor specifically to protect the cache data with thread safety. Based on what I've gleaned from Apple's documentation, URLCache appears to be thread safe but I've also read some conflicting information on the internet regarding use of storedCachedResponse functions and whether my use of those functions warrants protecting it with actor isolation.

I also appear to be having issues controlling exactly when URLCache decides to cache or not. I'm currently using a combination of setting the cache policy on the URLRequest and using cache.cachedResponse() and cache.storeCachedResponse to manually get and set the cache. I noticed that the image requests do need me to manually get and set the cache whereas the recipe data appears to rely more on the cache policy set on the request. I suspect this has something to do with the response headers and other metadata coming back on the response.

I wanted to make it so that the cache would be thrown out if a request yielded a response with a decoding error; Reason being, I don't want the UI to be reflect a stale and invalid response. I found this to be a difficult thing to accomplish for the recipe metadata response.


### **Additional Information: Is there anything else we should know? Feel free to share any insights or constraints you encountered.**
I did try to prototype different ways to make use of the the data provided. I wanted to see if I could provide an in app video watching experience using AVPlayerViewController. Unfortunately, when I prototyped this, I wasn't able to get the video to play from youtube link. I think the problem is that the AVPlayer wants to play a video file directly from a URL and the youtube link doesn't link to the video file itself. I think it's possible I could find a way to parse out the video id and then use a youtube api to get a direct link to the video.

I also tried to see if there was a way I could have some sort of web view that opened directly into the reader mode using the web link. This would have made for a more enjoyable in-app recipe reading experience. The ultimate experience would probably be some sort of view that parses ingredients and recipe information from the url html and passes it to the app view. I didn't have time to implement this of course and didn't see any first party packages from Apple that would have been able to speed up the development process of a feature like this. I also tried wrapping SFSafariViewController in a UIViewControllerRepresentable and setting entersReaderIfAvailable on initialization but this didn't work. I think this initializer was deprecated at some point and I didn't see any obvious replcement for this functionality.

I also had to make compromises on the cuisine picker on the list view. On iOS 18 I was able to use a newer Picker initializer that gives me the globe icons within the Menu. But on iOS 17 or 16 the user only currently sees the text labels for the menu picker options.

I encountered a very interesting bug while building a custom animating redacted loading view for the recipe list view. I was seeing a strange effect where the second rectange with a maxWidth of .infinity was literally animating it's width like a progress bar rather than producing more of a shimmering effect. The issue ended up being one of timing. The issue occured when the app had just loaded and the loading view started to animate before SwiftUI was ready to accurately calculate what kind of width the redacted rectangle should be. I was able to solve this issue by adding in a slight 0.1 second delay on the loading view.

Speaking of delays, I also decided to add a slight loading delay to the loading phase on app startup. These recipes load extremely quickly so adding a minimum loading duration felt like a better transition. Without this delay, the loading screen looks a bit glitchy which is not the effect we are going for!


