# Sprint Meeting 1 (11/15/2018)

Memelify is designed to bring the hottest trendiest memes to UC Davis students
using an easy to use interface that allows users to connect to the best memes in
social media without having to create an account anywhere. This app will utilize
different views to guide the user to the best memes UC Davis has to offer such
as hot and trending memes. With a quick tap, as soon as the app is opened, the
meme magic begins!

#####See our progress in our [Trello](https://trello.com/b/IvjtEJzZ/memelify)
board.

## What we did:

- Dat submitted an application to Facebook for Developers twice (the first
  application was denied).

- While we wait for Facebook's answer, Dat also created a boilerplate GraphQL
  backend service to allow iOS app query memes. At the moment, it just returns
  dummy data in JSON.

- Kauana spent the first week exploring our solutions for frameworks, server
  support etc. and we also created a detailed document for our milestone 1
  meeting.

- Kauana and Dat went through some tutorials to learn how to use GraphQL, Heroku
  and Alamofire, etc. We were successful in deploying an application with Heroku
  using Alamofire for our networking library (commit #14d151).

- Kauana also designed our logo for our app and a launch screen image. (commit
  #ec750d & #eef881)

- William began working on our app in Xcode. This week, he focused on our main
  view controller which was the "memetiles" in which the users will be able to
  interact with memes (like, share, etc.) (He had a lot of commits, but this is
  one of the major ones #f58c2ed).


## What we plan to do:

- **Server Solution:** Kauana will continue learning how to do server support on
  your app. We learned that Heroku and Alamofire work very well on swift apps,
  so the next step is making an API call (from the Heroku VM) to Facebook/Reddit
  API and parsing the response on our app. Alamofire seems okay for JSON
  parsing, but we may need to learn SwiftyJSON to parse JSON is Alamofire is not
  enough.

- **Facebook for Developers application:** Dat will try applying to facebook one
  more time: Upload a screencast for the application that is currently under
  review “Davis memes”.
 - Screencast Idea.
 - Use the draw.io to walk through how our app works.
 - Emphasize how we are not going to access/store any user information.
 - We only need to access the photos, number of reactions on the group page.

- **Facebook API solution:** If after applying to facebook again doesn’t work.
  Kauana, William and Dat will get the meme posts from Reddit, which unlike
  Facebook has a public official API. The Reddit Forums we will use will
  probably be the [ucdavis reddit](https://www.reddit.com/r/UCDavis/) and [meme
  reddit](https://www.reddit.com/r/memes/). Therefore, this week we will have to
  explore how to use the Reddit API to get only the images from posts and
  possibly how many upvotes the post has (for the trending window) and when the
  date was posted.

- **App Design**: William will continue working on the view controllers, models
  and we hope to have our memetiles and Settings page finished by the end of
  next week. Then, we will be able to begin adding functionality to the buttons,
  text fields, etc by making API calls.

## Issues we had this week:
- **Server issues**: We were planning to use Firebase and GCP’s App Engine
  initially for our server support, but the problem is that we want to query
  third-party APIs (Facebook or Reddit APIs for example) and the free Firebase
  plan (Spark Plan) only lets us communicate with Google services only. To talk
  to the third-party APIs we would need to choose the Flame Plan which costs
  $25/month or the Blaze Plan (pay as you go). The problem with the Blaze plan
  is that since we will have real users, they may find some bug or make some
  mistakes that will cost us a lot of money.

- **Facebook API issues:** Facebook recently strengthened their authentication
  request. In order to have access to the “UC Davis Meme Group” through access
  token, we need to provide a detailed plan on how we are going to use this
  permission, on what platform, and a screencast demonstrating how our app
  works. We have applied once but got rejected due to lacking a screencast. We
  recently finished the screen cast and now need to wait a few business days to
  hear back from them. If it does not work out, we would proceed to our backup
  plan which is to use Reddit to query the memes from /r/ucdavis subreddit page.

- **Analytics**: Because we will no longer use Firebase, we will not have a tool
  to gather app analytics for us. After doing some reading, we saw that if we
  publish this app to the Apple Store (have an Apple Developer account), we have
  access to the Apple Analytics tool which gives us a lot of information about
  our app performance. We are not sure if we will be able to publish the app to
  the Apple Store yet, so we need to start thinking about any other possible
  tools we could use for that.


