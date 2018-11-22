![pic](https://github.com/ECS189E/Memelify/blob/master/images/Memelify-transparent.png)

### Proposal:

**Our Memelify app is designed to bring the hottest trendiest memes to UC
Davis students using an easy to use interface that allows users to connect to
the “UC Davis Memes for Egghead Teens” Facebook group and even create new memes
and potentially upload them. This app will utilize many different views to guide
the user to the best memes UC davis has to offer and with a quick tap as soon as
the app is opened the meme magic will begin!**

### Features:
- Share feature
- Notifications

# Milestone 1 - Design:

### 3rd party libraries:
- Graph QL or Reddit API
- Alamofire
- Possibly Apple's App Analytics

### Server Support for the app: 
We are going to use Heroku for our Platform as a Service and Alamofire for out 
networking library. The API will be hosted on Heroku and it will make API 
calls to either Facebook or Reddit API. We will use Alamofire will make 
requests, wait for response, and parse JSON.

### Listing of all of the models (data structures): 
For our app we will need possibly two data structures for all of the information we need to store.
The first would be the object that represents a meme to the user, called
Memetile and it includes all of the relevant information pertaining to the meme
inside so that it can be easily put together detailed below.  

Memetile:
- UIImage meme: the actual image of the meme
- Int likes: this just keeps track of the number of likes
- Date timePosted: when the meme was posted
- bool favorite: whether or not the user has marked the meme as a favorite meme

We also need an array of memetiles to store all of the information we get
back from the json response plus we will be able to sort this in different ways
to obtain “new” and “trending” view.

### Listing of all ViewControllers (protocols, delegates, variables):
Our home view controller will contain a table view with only one column,
which will show the memes gotten from the Facebook API. Each meme “object” will
have below it two buttons (share & favorite) and a label (likes): share and
favorite. When the user clicks the share button (right arrow), a pop up window
appears asking user where he/she wants to share this meme.

When the user clicks
on favorite button (heart icon), we add the meme to a list of Favorite memes
(this share & favorite feature is similar to what Instagram uses) and if they
click on it again we remove the meme from the list. The likes label will show
how many likes the meme had on Facebook and this value will be used to display
the “Hot” memes.

At the bottom of the home view controller, we will have 3 buttons:
1. **Hot**: Shows a list of memes that have the most likes on Facebook during the
week.
2. **Home (New)**: Shows the latest memes that were posted
3. **Favorites**: Shows the user’s favorite memes

At the top of the home view controller, we will have our logo centered and
to the right we will have a Settings button that will take the user to the
General Settings view controller.

The general settings controller will have toggles controlling app
notifications such as if they want to receive a notification reminding them to
see the “Meme of the day” (meme with most likes of the day” and if they want to
receive notifications about hottest memes (memes the reach a certain threshold).
Then, in Display the user will be able to select the “Default home”.
Initially the app sets latest memes as default, but the user can choose to see
hottest memes as the default when they open the app. Next, invite friends
will create a popup where user will be able to enter their friends’ email
account so they can receive an email from our app telling them to download the
app.
They will a be able to rate the app. If the user clicks on “Rate our
app” a pop up window appears asking the user to enter 0 - 5 starts and a comment
(optional) OR if the app is in the Apple Store, this button will take the user to
the App Store to rate us there. 
Lastly, the “About Us” will contain some
information about us and how we developed the app. It will also contain our
Github usernames so users can find us on github. We will also post the app’s
repo so users can contribute to our app (open source, yay!) or they can submit
issues/PRs.

### List of approximately week long tasks and a timeline: 
https://trello.com/b/IvjtEJzZ/memelify

### A trello board that includes all of the tasks and their state:
https://trello.com/b/IvjtEJzZ/memelify


### A testing plan:

For user testing, we plan on asking friends and other
UC Davis students to download our app and use it as a normal user. We will ask
them to look at latest memes, select their favorites, switch to trending memes
and share their favorite memes with their friends, then we will gather their
feedback. In addition, we will have a “Rate it” option on our Settings
controller so the user can rate us on the App Store using the 0 to 5 star system
(and potentially they will also leave a review), or if the app is not on the App
store, they will be able to send us the reviews so we can analyze it (this is
the plan B).
- If we publish the app to the Apple Store, we will plan to use Apple Analytics
  to monitor our app. If we don't, then we plan on using a third party tool to
  do so. We are planning on monitoring the following:
- How long it takes the user to see all the Memes displayed on the screen
- How much time users spend on the app
- Which feature the user prefers (which features they spend more time on)

### Our Team Dat Nguyen - datlife
![pic](https://github.com/ECS189E/Memelify/blob/master/images/dat.jpg)

Kauana dos Santos - kauana
![pic](https://github.com/ECS189E/Memelify/blob/master/images/kau.jpg)

William Jackson - wjjackson7
![pic](https://github.com/ECS189E/Memelify/blob/master/images/will.jpg)
