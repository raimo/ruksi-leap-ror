Logbook
=======

This is a brief logbook where I record how I'm approaching the challenge
outside a pure coding perspective i.e. setup of environment, thoughts
and whatnot. Not mandatory for the challenge, but I think you might find
this interesting.

Saturday, 10:55
- Arrived at the office.
- Started working on my Windows machine at the office as my Leap Motion and
  Oculus Rift are there.
- Searched "Leap Motion" in Thunderbird to find Leap Motion Web Engineering
  Challenge email that was sent to me on 19.2.
- Read the challenge through to get an idea what is expected of me:
  GitHub, Heroku, Rails, PostgreSQL, Leap Motion JavaScript library, Bootstrap,
  possibly Backbone/React, keep-it-simple-stupid, bug-free.
- Though what might be the target of this challenge, obviously to test me
  so I had this idea of writing a logbook to get a glimpse how I work.
  Created `LOGBOOK.md` to desktop.
- Checked if I had Ruby installed, got 2.1.5 installed, leftovers from
  Rails Girls coaching a few weeks ago. I've been involved only in a few
  RoR projects before so wasn't sure.
- Checked if I had Rails installed, got 4.2.0, that's the newest, OK, nice.
- `rails new ruksi-leap-ror`
- `git init; git add -A; git commit -m "new rails project";`
- Went to GitHub, make a private repository (shyguy, huh?), copy paste
  the two lines to setup and update the remote repo as I'm lazy.
- Downloaded and installed RubyMine, helps to grasp the correct syntax
  and catch all the newbie mistakes. I personally love IDEs by JetBrains,
  I've got license for the most of them.

Saturday, 11:14
- Opened the new rails project with RubyMine.
- As it generates `.idea` folder, added a few lines to `.gitignore`
  that shouldn't be shared between IDE installations. Copy-pasta from
  previous projects on my machine.
- Now usage of git becomes GUI based, can more easily see the
  changes that are to be committed.
- Added this `LOGBOOK.md` to git.
- Went to make coffee.

Saturday, 11:34
- Install Markdown support plugin to RubyMine to edit this logbook.
- Check that rails installation is ok, Run development in the IDE same as `rails server`.
  This generates a few IDE files to project.
- `localhost:3000` shows up, whee I'm riding Ruby on Rails now.
- I want to make the front page now, was it `rails generate controller` or something like that? Google.
- Used `rails generate controller Home index`, first parameter is controller name, second is a list of actions
  on the controller.
- Checked that `localhost:3000/home/index` works, ok.
- Wanted to make it the default page, checked `routes.rb` comment and defined the app root action.
  `http://localhost:3000/` now shows ´Home#index´, cool.
- Went to get coffee.

Saturday, 11:50
- Looked at the git log, saw that 3rd commit was wrongly named, there were 2x "add RubyMine project files",
  second was adding of this logbook.
- As I haven't pushed yet (well, none on the remote to pull this project also), I opened up git rebase tool in
  interactive mode, marked that commit as `reword` and changed to commit message to "add logbook".
- Downloaded `leapmotion/leapjs-playback` as zip.
- Friend came to office, we talked about building efficient 6-lane roads in a new game Cities: Skylines about 20min.
- Back to work, I checked how the `leapjs-playback` is used from `index.html` as instructed.
- Ok, I need to include the Leap playback library to Rails, Googled how asset pipeline works in RoR.
  Seems like I should use `app/assets`.
- Included JS, console says `Plugin "playback" already registered` but so does the given demo so I'll let it slide.
- Added newest three.js to project with cdnjs url, noticed an error about `THREE.Projector` being moved, checked
  demo project three.js version and changed from `r70` to `r65`. Got some depricated warnings, should be ok for now.
- Copy pasted code from the demo project `index.js`, commenting out the recording part as I don't have that done.
- Refreshed the page, my hand is visible when hovering over Leap.
- `.playback-move-hand` element stays on the screen, I'll just hide it for now through `home.scss`.
- Figured that there might be a Ruby gem for three.js integration, but decided not to use it for now because of
  the previous the revision hassle, at least it's working well now. Googled and found one, just in case
  I need it in the future.

Saturday, 13:18
- Decided to make it pretty next, Bootstrap integration next.
- Googled `ruby on rails bootstrap` to see how it should be done, filtered search results to past year so I don't
  get any old guides. There seems to be maintained `bootstrap-sass` gem I can use.
- `bundle install` and add start using import statements in the place of the stylesheet `require`. Required files
  cannot access SASS mixins from the Bootstrap. Require Bootstrap js files as normal.
- Added some Bootstrap markup to check that it works.

Saturday, 14:28
- Read how to integrate Backbone with Ruby on Rails, there is a maintained gem for it, I'll give it a try.
- Added `backbone-rails` gem to the project and initialized the Backbone structure.

Saturday, 15:10
- Created rails model for Recording.
- Database migration created `schema.rb`, which I Google should it go to the version control or not.
  It should be included.
- Noticed that you need to delete `/tmp/pids/server.pid` if you exit the IDE without shutting down the server
  as the Rails server daemon will be left running and will have to be killed manually.

Saturday, 17:37
- Updated forms, table and navbar more pretty, took a while to refresh my Bootstrap skills to style 'em
- Had problems with events not unsubscribing on view destruction, Googled and found out that Leap Controller
  uses node.js EventEmitter, so the unsubscribe function is `removeListener`, not `off` like Backbone expects.
  Didn't waste trying to fix it, just made a `removeAllListeners` for subscribed events for now and wrote a
  TODO comment to fix it later if it becomes an issue.
- Made recording and saving raw recording frame data to database using the app. Will see later if it makes sense
  to change the formatting or compress it.

Saturday, 23:37
- Still going strong, had some time off from computer as friends came to visit the office. They
  started working on a new Node.js project and I was helping them out a little.
- Added a lot of changes between here, noticed that 'record' event on Leap Controller is a little bit wonky,
  I guess I don't fully understand it. Couldn't Google any more information about it so checked how the demo project
  did the state changes and followed that model.
- Started to doubt some of my namings, Recordings should have been named Gestures and content should have been named
  frameData, I'll see if will change them later. Plan twice, cut once!

Sunday, 02:42
- "Uploading" files straight to client JavaScript is something that I've personally never done before but
  it was relatively easy after a good while of Googling. File input to upload and FileReader to read it.
- Starting to get a bit sleepy so I'll check how Heroku deployment goes, it has been a while since I've used Heroku,
  over 4 years I think.