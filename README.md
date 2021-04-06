gilb(1) -- Gitlab IRC Bot
=======================

## Synopsis

`./gilb [config.yml]`

## Description

Ruby IRC bot with builtin webserver for Gitlab webhooks. Inspired by [aleks/gitlab-irc](https://github.com/aleks/gitlab-irc)

## Installation

  1. Just clone this repository wherever you want;
  2. Run `bundle install` to install dependencies.

## Usage

Create your config file `config.yml` taking as exemple the `config.yml.example` and launch it: `./gilb`.

Then you just need to add the url `http://yourserver.com:4567/commit` into you project's webhooks.

## Testing

You can test it running the script:

    ./test/test-gilb.sh

You should see this output:

    NICK gilb
    USER gilb 8 * : gilb
    JOIN #channel
    PRIVMSG #channel :[gilb/master] 4d117cf6b 'Sample commit' <Carla Souza>
    PART #channel

## Options

  * Webserver settings:

        :http:
          :host: 0.0.0.0
          :port: 4567

  * Whatever it should shorten diff link using `goo.gl`:

        :behavior:
          :shorten_url: true

  * Logging settings

        :logging:
          :level: info # Use `fatal`, `error`, `warn`, `info` or `debug`
          :output: bot-Gilb.log # Can be a file name, `STDOUT` or `STDERR`

  * IRC settings

        :irc:
          :server: localhost
          :port: 6667
          :nick: gilb
          :join_channel: true # If false, channel must not have mode +n

  * Hooks settings

        :git:
          :projects:
            project1: # Tracks events from `project1`
              :branches: # Tracks events from these branchs of `project1`. If not specified, it will track all branches
                - master
                - feature42
              :channels:
                - "#project1-channel" # Send messages to this channel
                - "someones_nick" # You can also sent to a pvt buffer
              :events: # Tracks these events. If not specified, it will track all events
                - commits # Push with commits
                - branch_created # Push of a branch created
                - branch_deleted # Push of a branch deleted
                - branch_merged # Push of a branch merged
            project2:
              :channels:
                - "#project2_channel"

## Files

### Example of config.yml

    :http:
      :host: 0.0.0.0
      :port: 4567
    :behavior:
      :shorten_url: true
    :logging:
      :level: debug
      :output: bot-Gilb.log
    :irc:
      :server: localhost
      :port: 6667
      :nick: gilb
      :join_channel: true
    :git:
      :projects:
        project1:
          :branches:
            - master
            - feature42
          :channels:
            - "#project1-channel"
          :events:
            - branch_merged
        project2:
          :channels:
            - "#project2_channel"
            - "someones_nick"
          :events:
            - commits
            - branch_created
            - branch_deleted
            - branch_merged

## Messages

One commit to master

    [gilb/master] 66013bf90 'First commit' <Carla Souza>

More than one commit to master

    [gilb/master] 3 commits (diff: http://gitlaburl/gilb/compare/5139c1705...a33c7b724 ):
      5139c1705 'Second commit' <Carla Souza>
      dd12da5bd 'Third commit' <Carla Souza>
      a33c7b724 'Fourth commit' <Carla Souza>

New branch created

    [gilb] New branch: 'gilb/feature42' <Carla Souza>

One commit to a branch

    [gilb/feature42] 60900941b 'Added logging to Gilb' <Carla Souza>

Branch was merged into master branch

    [gilb] 5139c1705 - Merged 'feature42' -> 'master' <Carla Souza>

Branch was deleted

    [gilb] Branch deleted: 'gilb/feature42' <Carla Souza>

## Copyright

Gilb is Copyright (C) 2013 Carla Souza <[carlasouza.com](http://carlasouza.com)>.
License GPLv3+: GNU GPL version 3 or later <[gnu.org/licenses/gpl.html](http://gnu.org/licenses/gpl.html)>.
This is free software: you are free to change and redistribute it. There is NO WARRANTY, to the extent permitted by law.
