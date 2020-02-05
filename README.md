[![Hex pm](https://img.shields.io/hexpm/v/crawley_ex.svg)](https://hex.pm/packages/crawley_ex)
[![CircleCI](https://circleci.com/gh/mateusluizfb/crawley-ex/tree/master.svg?style=svg)](https://circleci.com/gh/mateusluizfb/crawley-ex/tree/master)

---

# Crawley

Crawley is an elixir package that scrap the Github API searching for repos to download and then zip and upload them to a S3 bucket.

Before you run anything, remember to create an `.env` file like this:

```
export GITHUB_TOKEN=""
export AWS_ACCESS_KEY_ID=""
export AWS_SECRET_ACCESS_KEY=""
export USE_LOCAL_STORAGE=true/false
```

The `GITHUB_TOKEN` var is your github token.

---
To run:
1. `iex -S mix`
2. `Crawley.run(%{lang: lang, per_page: per_page, page: page})`
---

### To contribute:

1.  Fork the project
2.  Make that changes you want
3.  Create the PR to the repo
4.  Await the review :)
