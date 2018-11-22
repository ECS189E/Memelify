# Memelify Backend Service

This directory contains code for Memelify API service

##  Usage

| API               |  Return                            |
|:------------------|:-----------------------------------|
|`/api/meme/latest`| list of latest memes (default=10)   |
| `/api/meme/hot`  | list of trending memes (default=10) |

* Extra parameters

| Parameter  |  Detail                                 |
|:------x-----|:----------------------------------------|
|`offset`    |  Integer - offset index starting from 0 |
| `limit`    |  Integer - number of items to return    |


For example, I would like to make an API call to returns a list of 2 latest memes starting from index 3.
```
http://206.189.218.125/api/memes/latest?offset=3&limit=5
```
The response is a json object.

```javascript
{
    has_more: true,
    memes: [
        {
            created: "2018-11-20 09:46:06",
            id: "9yqr2o",
            likes: 188,
            title: "The L is upon me",
            url: "https://i.redd.it/op70k6pvigz11.png"
        },
        {
            created: "2018-11-19 22:56:02",
            id: "9ylzlk",
            likes: 147,
            title: "I see your Gucci n95 and I raise you my own fancy mask.",
            url: "https://i.redd.it/lca2e9jyadz11.jpg"
        }],
    offset: 3,
    size: 142
}
```

* The JSON object has following skeleton:
```s
{
    has_more: bool  --- if we still have more items to scroll down
    offset:   int   --- current offset index
    size:     int   --- size of the whole list
    memes:    []    --- collection of memes object
}
```

### Limitations

* No HTTPS.
* The current implementation does not know if there is a new meme appeared.
Therefore, we need to manually restart docker container to reload the bot.
