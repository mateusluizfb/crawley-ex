[![CircleCI](https://circleci.com/gh/mateusluizfb/crawley-ex/tree/master.svg?style=svg)](https://circleci.com/gh/mateusluizfb/crawley-ex/tree/master)

---

# Crawley

Crawley is an elixir package that mine the Github API searching for repos to download and then zip and upload them to a S3 bucket.

Before you run anything, remember to create an `.env` file like this:

```
export GITHUB_TOKEN=""
export AWS_ACCESS_KEY_ID=""
export AWS_SECRET_ACCESS_KEY=""
```

The `GITHUB_TOKEN` var is your github token.

### To contribute:

1.  Fork the project
2.  Make that changes you want
3.  Create the PR to the repo
4.  Await the review :)
