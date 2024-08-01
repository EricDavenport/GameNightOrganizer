# Family Game Night

Family Game Night is an app designed to simplify the planning and coordination of game nights with friends. The app allowsusers to manage events, suggest games and food, and invite friends to join the fun. Built with SwiftUI and Firebase, it offers a seamless and intuitive user experience.

## Features
* User Authentication
  * SIgn in, sign up, and persistent login states using Firebase Auth
  * Secure profile management and authentication
* User Profiles
  * Create and update personal profiles
  * View and manage friends list
* Event Management
  * Create, update and view game night events
  * Add and remove games for events, with option for participant suggestions
  * Include details like event name, date, location and more
* Game and Food Suggestions
  * Suggest games with details such as name, number of players and adult-only status
  * Add and suggest food items for the event
* Dynamic Feed
  * Display a feed of upcoming game nights with summaries of participants, games and food
  
  
## Technologies Used
* [SwiftUI](https://developer.apple.com/xcode/swiftui/) - For the user interface and front-end logic
* [Firebase](https://firebase.google.com/) - For backend services including Authentication, Firestore for real-time database amd Storage

## To Do List
- [X] Event view list
- [X] Add new event
- [X] Event detail view
- [X] Ability to add food
- [X] Ability to suggest food
- [X] Suggesst games
- [X] Add games
- [X] User Profiles
- [x] Friends list
- [X] Add participants from friends list
- [X] Add new game view
- [X] Connect Firebase
    - [X] Auth
    - [ ] Storage
    - [X] DB Manager
        - [ ] Game database manager
        - [X] User profile database manager
        - [ ] Event database manager
        - [ ] Upadted view with managers
- [ ] Add food view
- [X] Profile view
- [ ] Manage event
    - [ ] Edit event
    - [ ] Edit button on even
    - [ ] Add and remove games
    - [ ] Add and remove food
    - [ ] Add and remove participants
- [ ] Persist user across app

- [ ] Polish the app
    - [ ] Funtions
        - [ ] Database managers
    - [ ] MVVM
    - [ ] Move functions from views
- [ ] Make it look pretty
 

### *Crud Actions*
- [X] (C)reation
    - [ ] User profile
    - [ ] New events
    - [ ] New food
    - [ ] New games
    - [ ] Add friends
- [X] (R)ead
    - [X] Events
    - [X] Games
    - [X] Food
    - [X] Friends
    - [ ] Users
- [X] (U)pdate
    - [X] Profile
    - [ ] Events
    - [ ] Food
    - [ ] Games
- [ ] (D)estroy
    - [X] Events
    - [ ] Remove friends
    - [X] Remove/Delete food
    - [X] Remove/Delete games

### Clean up Read me
