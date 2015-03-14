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