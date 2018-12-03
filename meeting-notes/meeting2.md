# Sprint Planning Meeting 2 (11/25/2018)

Memelify is designed to bring the hottest trendiest memes to UC Davis students
using an easy to use interface that allows users to connect to the best memes in
social media without having to create an account anywhere. This app will utilize
different views to guide the user to the best memes UC Davis has to offer such
as hot and trending memes. With a quick tap, as soon as the app is opened, the
meme magic begins!

##### See our progress in our [Trello](https://trello.com/b/IvjtEJzZ/memelify)
board.

## What we did:

- Kauana worked on the on the UI with William. We implemented the tab bar with
  three items “Trending”, “Home”, “Favorites”. We also finished working on the
  “main” view controller, a.k.a meme table and meme tiles (See branch
  [kau-changes](https://github.com/ECS189E/Memelify/tree/kau-changes) on
  Github).
- Kauana began working on the app functionality. The home controller (latest
  memes published) is done and it is correctly pulling memes using the Reddit
  API bot Dat designed (These commits are also under the branch
  [kau-changes](https://github.com/ECS189E/Memelify/tree/kau-changes) as we are
  waiting for Will to implement his part of the functionality so we can safely
  merge our branches).
- Will merged the changes from the kau-changes branch into master. This work is
  done on the [Will-views](https://github.com/ECS189E/Memelify/tree/Will-views)
  branch and adds functionality to the home view. Before we were simply using
  the api call to get the images from the json response whereas now we store all
  of the information into an object that corresponds to each MemeTile.
- Will also added the favorites view controller functionality. Now when the user
  presses the favorite button beneath the meme, that meme object is saved to the
  device and is available to the user in the favorites view.
- Dat created a webcast to Facebook describing how Memelify App would not use /
  access any user information but only memes on [Webcast
  link](https://www.youtube.com/watch?v=ILzd69UccAg&feature=youtu.be).
- Dat also worked on the backend service to load memes from Reddit Public API
  (Example: [here](https://memelify.herokuapp.com/api/memes/latest). We created
  a “meme-filter” to load only image submissions, which contain URLs ending in
  image extension (jpg, png) to our Heroku app (branch:
  [Dat-backend](https://github.com/ECS189E/Memelify/tree/Dat-backend)).
  Potentially, we can create a “meme image binary classifier” to create better
  data-driven meme filter. The reason is that not all images on a subreddit are
  memes.
- Dat began working on Sharing feature so users can share their favorite memes
  to other social apps.

## What we plan to do:

- Kauana will add a testing feature to the app. We will allow users to rate our
  app (then make an API call and send info to our server and possibly store it
  somewhere (so maybe we need a database?)). The testing will probably be based
  on survey data (how easy it is to use to app, overall satisfaction, meme
  loading times) because we didn’t come up with a good metrics API yet.
- Kauana will add the settings controller also needs to be finished, but we
  expect it to be pretty straightforward. All the settings information will be
  stored in the phone.
- Will - work on moving the offset when reaching the bottom of the page.
- Will - Clean up functionality around the favorites button ( click again to
  remove from favorites, also sync up favorites across views)
- Will - work on refresh when scrolling down on a view
- Dat will implement the Meme Sharing feature.
- Dat will also continue working backend part.
- Dat  will Implement Meme Notifications (when a meme becomes really popular)
  HTTP/2.
- Will - Need to update how we save our memes so that we are not using
  deprecated methods and can compile without warnings.
- Kauana will add a banner on home view of which memes are trending.

## Issues we had this week:

- Implementing the tab bar controller was a bit harder than previously expected
  so it delayed things a little. We were able to implement is successfully
  though.
- Saving custom objects to the device storage was more complicated than
  previously thought. It now works but with custom objects they must be encoded
  and decoded before they can be cast to their original types.
- Refresh feature requires architectural change in the backend server.
- Facebook initially blocked our request due to not having a clear detail on how
  we are going to handle user data. It turned out that Memelify is a
  [“server-to-server”](https://developers.facebook.com/docs/apps/review/server-to-server-apps/)
  service which does not require any user information. We have clarified that
  through our webcast. Unfortunately, we might not be able to use Facebook API
  for our project.
