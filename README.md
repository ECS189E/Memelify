![pic](https://github.com/ECS189E/Memelify/blob/master/images/Memelify-transparent.png)

### Proposal:

**The Memelify app is designed to bring the hottest memes to users by providing
an easy to use interface that allows users to connect to a subreddit. No signup
required.
By analyzing images with a powerful machine learning model, Memelify
selects only the coolest memes from posts. That is why that with a quick tap,
as soon as Memelify is opened, the meme magic begins!**

### App Features:
- Share memes and Memelify with friends.
- Get notified about the hottest memes and the "Meme of the day"
- Don't like white and bright apps? Switch to our amazing Dark Mode!
- Save your favorite memes to your phone.
- Choose between a list of trending or the latest memes.

# App Design:

### Frontend Diagram

<img src="./images/frontend_diagram.svg">

### Backend Diagram

<img src="./backend/backend_diagram.svg">


### 3rd party libraries:

- Reddit API
- Alamofire
- Survey Monkey SDK
- DZNEmptyDataSet

### Server Support:

The app uses Heroku to host the Reddit API calls and Alamofire for the
networking library to make HTTP requests, wait for response and parse JSON.

### App Models:

##### Memetile (UI components in the stack view):

- **UIImageView meme**: the actual image of the meme
- **Int karma**: this just keeps track of the karma number for posts
- **bool favorite**: whether or not the user has marked the meme as a favorite meme
- **UIButtons**: favorite (heart icon) and share (square with arrow icon)
- **UILabel**: up arrow to indicate karma count.

##### MemeObject (Meme information parsed from Reddit API call)
- **id**: post id
- **date**: "created_at" date
- **title**: post title
- **likes**: post likes
- **image**: post image

##### Dark Mode (controls how the app's appearance if DarkMode is enabled or not):

- **navigationController**: UINavigationController allows navigation modifications
  for DarkMode
- **tabBarController**: UITabBarController allows tabBar modifications for DarkMode

##### MLabel:
- Used to implement the Dark Model feature. It allows app to know what to do
  with labels when Dark Mode is enabled or not.

### Listing of all View Controllers:

1. **Home (Latest)**: Shows a list of memes that have the most karma on Reddit
   during the week.
2. **Trending**: Shows the latest memes that were posted.
3. **Favorites**: Shows the user's favorite memes (user default).
4. **Settings**: Allows the user to change Display, Notifications, and General
   settings.
5. **About Us**: Contains some information about Memelify. Accessed through the
   Settings controller.

### User Feedback:

Users have the option of rating Memelify by going to Settings and clicking on
"Rate our App". Another view controller will show up containing a Survey Monkey
survey that asks users general questions about their experience and feedback.
Once the user clicks on "done" the information is sent to our API where we can
examine the results gathered.

### Our Team:

![pic](https://github.com/ECS189E/Memelify/blob/master/images/team.png)
