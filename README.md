![pic](https://github.com/ECS189E/Memelify/blob/master/images/Memelify-transparent.png)

### Proposal:

**Our Memelify app is designed to bring the hottest trendiest memes to UC
Davis students using an easy to use interface that allows users to connect to the UC Davis subreddit without needing to have a Reddit account. User will not have to worry about other general posts either because Memelify selects only the Meme posts from that subreddit.
This app will utilize many different views to guide the user to the best memes UC Davis has to offer and with a quick tap as soon as the app is opened the meme magic will begin!**

### Features:
- Share memes and Memelify with friends.
- Get notified about the hottest memes and the "Meme of the day"
- Don't like white and bright apps? Switch to our amazing Dark Mode!
- Save your favorite memes to your phone.
- Choose between a list of trending or the latest memes.

# Milestone 1 - Design:

### 3rd party libraries:
- Reddit API
- Alamofire
- Survey Monkey SDK

### Server Support for the app:
We are going to use Heroku to host our own API and Alamofire for out
networking library to make HTTP requests, wait for response and parse JSON.
The API will be hosted on Heroku and it will make API calls to the Reddit API.

### Listing of all of the models (data structures):
For our app we will need possibly two data structures for all of the information we need to store.
The first would be the object that represents a meme to the user, called
Memetile and it includes all of the relevant information pertaining to the meme
inside so that it can be easily put together detailed below.

Memetile:

- UIImageView meme: the actual image of the meme
- Int karma: this just keeps track of the karma number for posts
- bool favorite: whether or not the user has marked the meme as a favorite meme
- UIButtons: favorite and share

We also need an array of memetiles to store all of the information we get
back from the json response plus we will be able to sort this in different ways
to obtain “new” and “trending” view.

### Listing of all View Controllers (protocols, delegates, variables):

Our home view controller will contain a stack view with only one column, and
multiple rows which show the memes parsed from Reddit. Each meme object (aka
memeTile) will have below it two buttons (share & favorite) and a label (karma).
When the user clicks the share button (the arrow), a pop up window appears
asking user how he/she wants to share the meme (similar to iOS sharing feature).

When the user clicks on favorite button (heart icon), we add the meme to a list
of Favorite memes (this share & favorite feature is similar to what Instagram
uses) and if they click on it again, we remove the meme from the list. The likes
label will show the karma number of a Reddit post and this value will be used to
display the “Hot” memes.

At the bottom of the home view controller, we will have 3 buttons:
1. **Hot**: Shows a list of memes that have the most karma on Reddit during the
week.
2. **Home (New)**: Shows the latest memes that were posted.
3. **Favorites**: Shows the user's favorite memes (user default).

At the top of the home view controller, we will have our logo centered and
to the right we will have a Settings button that will take the user to the
General Settings view controller.

The general settings controller will have toggles controlling app notifications
such as if they want to receive a notification reminding them to see the “Meme
of the day” (meme with most likes of the day) and if they want to receive
notifications about hottest memes (memes that reach a certain threshold).  Then,
in Display the user will be able to select if they want to use Dark Mode or not.

Next, the invite friends option will open a pop up window where user will be
able to share how they want to send their friends our app's link (Email,
message, etc.). The sharing will be pretty similar to iOS's sharing
feature.

They will a be able to rate the app. If the user clicks on “Rate our app” a pop
up window appears asking the user to enter 0 - 5 starts and a comment (optional)
OR if the app is in the Apple Store, this button will take the user to the App
Store to rate us there.  Lastly, the “About Us” will contain some information
about us and how we developed the app. It will also contain our Github usernames
so users can find us on Github. We will also post the app's repo so users can
contribute to our app (open source, yay!) or they can submit issues/PRs.

### A testing plan:

Users have the option of rating Memelify by going to Settings and clicking on
"Rate our app". Another view controller will show up containing a Survey Monkey
survey that asks the users general questions about the user's experience and
feedback. Once the user clicks on "done" the information is sent to our API
where we can examine the results gathered.

### Our Team

![pic](https://github.com/ECS189E/Memelify/blob/master/images/team.png)
