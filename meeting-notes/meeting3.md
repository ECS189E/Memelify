# Sprint Planning Meeting 3 (12/2/2018)

Memelify is designed to bring the hottest trendiest memes to UC Davis students
using an easy to use interface that allows users to connect to the best memes
in social media without having to create an account anywhere. This app will
utilize different views to guide the user to the best memes UC Davis has to
offer such as hot and trending memes. With a quick tap, as soon as the app is
opened, the meme magic begins!

##### See our progress in our [Trello](https://trello.com/b/IvjtEJzZ/memelify) board.

## What we did:

- Will worked on adding the pull down to refresh feature for the home and
trending views. ([commit](https://github.com/ECS189E/Memelify/tree/f2d152e0ab75a6526767e3d2e425b1a6071a2b06))
- Will - fixed the double click to remove favorites bug on the favorites view
- Will - added a sync for the favorites across different views and the ability
to remove favorites, specifically they immediately disappear when on the
favorites view ([commit](https://github.com/ECS189E/Memelify/commit/48b0122ad6cf90b850401f4474427eb7123545ce))
- Dat created a Machine Learning model to classify whether an image is a meme
or not through “deep learning”. Why? Because when our reddit bots crawl data
from Reddit, they can not distinguish between a regular image (e.g. email,
announcement, ads) vs a funny image. Our classifier performs fairly good in
most case, we reach 93% accuracy when testing on our test data. Google Colab
- Dat improved on backend side by adding heavy tasks to run in background.
These tasks are updating “trendiness” scores, crawling new memes into database.
Dat used a redis queue for managing background tasks.
- Dat created a notification feature on frontend. The currently implementation
is a in-app notification, which does not require backend to push a message. It
acts  a scheduler that would send notify user “Meme of the Day” everyday at
7:00PM.
- Kauana worked on the Settings Controller this week. She implemented a Dark
Theme for the app.
([commit](https://github.com/ECS189E/Memelify/commit/9d95a57dc80205f385109f7a95229f72c45771cc))
- Kauana added activity indicator in the view controllers to let the user know
if the app is currently fetching some data.
([commit](https://github.com/ECS189E/Memelify/commit/094e1589de2c999b92808ee35aeb1e8edf6dd0a3))
- Kauana added the “Rate Us” feature in the Settings Controller. Now when the
user presses “Rate our app” a Survey Monkey controller shows up and the user
can give us some feedback. Then we can log into our Survey Monkey account and
analyze the data we got from users.
([commit](https://github.com/ECS189E/Memelify/commit/b3ec9f37754d1c0ec586a11a7e03a1162874a991))

## What we plan to do:

- Will add infinite scrolling for latest/trending
- Will invite friends on settings controller
- Will look into why the favorites don't appear immediately across different
controllers and doesn't sync immediately with different pictures
- Kauana will finish the Settings controller (Still need to finish the About us
controller)
- Kauana will begin testing the app for our Friday demo. We have some bugs and
we will try to improve the code and fix these bugs.
- Dat will finish push notification feature
- Dat will also look into the possibility of pushing the app to App Store by
the demo next week.

## Issues we had:
- The Survey Monkey SDK is written in Objective C, so it was a bit challenging
integrating it with Swift. It turns out that we needed to have a “bridging
header”, but it took some time to figure that out.
- The Dark Mode was a lot harder than expected. The hardest part was changing
the colors of the Settings Controller because the cells would not change colors
when the bool “DarkMode” was set to true. This problem is fixed, but Kauana
felt like she spent way too much time working on that.
- I don't know why swift treats parentheses so strangely in conditional
statements. This was the cause of the double click favorites bug. Ex: “ if fav
== true {“ is not the same as ” if(fav == true){“
- Heroku has a limit of 500MB RAM memory. When running heavy tasks, our backend
app crashed once because out of memory. We had to profile the memory usage on
each task to determine where to optimize. It turned out scikit-image, an image
processing library, has memory leaks. We had to switch to another library
(pillow) to solve this memory limit issue.
