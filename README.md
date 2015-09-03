## Referral Link Tracking on Twitter

### Setup
```
bundle install
bundle exec rake db:create:all db:migrate db:test:prepare
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

Even though it's a proof-of-concept, try to leave the code in a better state than you found it as you add to it as if you were trying to make things easier for a hypothetical coworker who would be next to work on it.

It's expected that about two hours should be set aside to work on the assignment, it's OK to spend more but you won't be penalized for only spending two. The goal is to get a sample of your work, not to waste your time.

###Submission
Please include a brief write up to explain the system architecture and your important design decisions. In addition, you should also mention what are the issues / considerations we should think about when implementing the system in production.

Consider committing your code often and including the `.git` files with the zipped up submission so we can see the commits.

Do not post this anywhere public or share it with anyone as we will continue to use the exercise for future evaluations.
