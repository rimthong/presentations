presentations
=============

Just a little server/build platform for my reveal.js presentations, because I'm a lazy bum who prefers to write html in jade.

getting started
=============

    npm install
    grunt
    grunt serve

structure
========

different presentations are subdirs in `src/projectname/index.jade` and they need to be added to the gruntfile. Compiled presentations end up in a `dist` directory and are served via connect.

other stuff
==========

If you just want to rebuild stuff without pulling bower sources:

    grunt build

There's also a watcher that makes sure to rebuild when there's any changes to your jade or styl files.
