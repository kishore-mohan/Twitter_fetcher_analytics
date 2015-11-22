## Referral Link Tracking on Twitter

### Setup
```
bin/setup
```

### Assignment
One of the ways in which online retailers encourage referrals is by giving each advocate a unique referral link to share with their friends.

A referral link may look like this: http://retailer1.refr.cc/CBD3EC
where `CBD3EC` is a unique code mapped to a specific advocate
and `retailer1` is a unique short name of the retailer, or more concisely, the retailer code.

Nowadays, people are increasingly using Twitter to share their referral links.

We need you to expand on this proof-of-concept system to track the sharing of these referral links on Twitter. So far, only the retailer codes are collected and stored. This happens by running:
```
bundle exec rake migration:retrieve_tweets
```
To retrieve only data from a specific date (format: `YYYY-MM-DD`) and limit result up to 20:
```
  from_date=2015-05-13 limit=20 bundle exec rake migration:retrieve_tweets
```
The data is then viewable at `/retailers`

We want more information to be viewable on the right about the tweets found for that retailer, but the stakeholders don't know what kind of data is available from the API.

Considering the general use case of wanting an overview on how wide the sharing reach of the retailer is and what is causing it to do so well, decide on and implement the storage of additional data from Twitter and then display it for each retailer.

