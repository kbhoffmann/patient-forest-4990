# Movie Tracker

This repository requires and has been tested on Ruby v2.7.2 and is based on Rails 5.2.6.

RSpec and Shoulda-Matchers have been installed and set up.

## Setup

1. fork this repo
2. clone your fork
3. `git clone <paste_repo>`
4. `cd <repo_name>`
5. `bundle install`

When you run `bundle exec rspec` you should have 2 passing tests.

## Instructions

* Spend up to 3 hours total working on this challenge.
* Commit frequently, about every 15-30 minutes, in addition to committing each time you start and stop working on the challenge.
* Push up your code at 6:00 PM (Mountain Time) on Tuesday, December 14
* Work on this assessment independently. DO NOT discuss with anyone.
* You are allowed to use any references including notes, Google, lesson plans, etc.
* Read each story carefully before you start working.


## Submission

Once the time for the assessment is up, push your code to your fork and create a pull request to the `turingschool-examples` repository. Include the following:

* Your Name
* A reflection on how you felt you did with this challenge and what story you got through

## Requirements

* TDD all new work
* model methods and relationships must be fully tested.

## Not Required

* No visual styling is required or expected
* You do not need to test for or create any model validations.

## Overview
We are creating an application to track studios, movies, and actors

* Studios have a name and location
  * ex. name: ‘Universal Studios’, location: ‘Hollywood’
* Movies have a title, creation year, and genre
  * ex. title: ‘Raiders of the Lost Ark’, creation_year: 1981, genre: ‘Action/Adventure’
* Actors have a name and age
  * name: ‘Harrison Ford’, age: 78
* Studios have many Movies
* Movies belong to a Studio
* Movies have many Actors
* Actors can be in many Movies

Some of the initial migrations and model set up has been done for you.

## User Stories

```
[x]
Story 1
Studio Index

As a user,
When I visit the studio index page
I see a each studio's name and location
And underneath each studio, I see the titles of all of its movies.
```

```
[x]
Story 2
Movie Show

As a user,
When I visit a movie's show page.
I see the movie's title, creation year, and genre,
and a list of all its actors from youngest to oldest.
And I see the average age of all of the movie's actors
```

```
Story 3
[ ]
Add an Actor to a Movie

As a user,
When I visit a movie show page,
I do not see any actors listed that are not part of the movie
And I see a form to add an actor to this movie
When I fill in the form with the name of an actor that exists in the database
And I click submit
Then I am redirected back to that movie's show page
And I see the actor's name is now listed
(You do not have to test for a sad path, for example if the name submitted is not an existing actor)
```

## Extension

```
Coactors

As a user,
When I visit an actor's show page
I see that actors name and age
And I see a unique list of all of the actors this particular actor has worked with.
```
