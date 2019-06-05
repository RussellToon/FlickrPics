We've built a simple app based on Apple's XCode template to show the most recent images available from Flickr's API.

We want to add 2 features to the `DetailsViewController` taking a test driven development approach.

# Add tests to `DetailViewController`

* Ensure creation from storyboard creates views.
* Ensure setting `detailItem` updates `detailDescriptionLabel`.
* Ensure setting `detailItem` initiates a download.
* Ensure successful image download updates `imageView`.

To achieve these goals you may wish to:

* Modify `DetailViewController` so it's `imageFetcher` is injected. 
* Provide a protocol for `ImageFetching` to which `ImageFetcher` conforms.
* Implement a test mock for `ImageFetching`

# Feature 1 – Show failure message

Users would like to know when detail image download has failed. 

Our design team have provided an image asset to be shown in the image view when an image download fails.

Using TDD…

* Add test coverage that unsuccessful image download shows the failed download image.
* Fix the tests.

# Feature 2 – Add retry support

Users would like to be able to retry a failed image download in the detail view.

Using TDD…

* Discuss a simple design for this feature – simple is good.
* Add test coverage for the new feature.
* Implement the new feature.

# Discussion

How would you improve the architecture of this application so to better support ongoing:

* Testing
* Reuse of components
* Decoupling

