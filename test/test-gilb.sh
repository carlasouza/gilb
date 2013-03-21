#!/bin/bash
# Gilb

URL='http://localhost:1234/commit'

./gilb 'test/config-test.yml' > /dev/null 2>&1 &
GILB_PID=$!

nc -l 6667 &

sleep 2

curl -H "Content-Type: application/json" -X POST -d "{\"before\":\"75ca1deae94447d3afc20818877b187978098a5e\", \"after\":\"5e4e8a07bd89e67c428c539ddfe7128d6cdb435a\", \"ref\":\"refs/heads/master\", \"user_id\":1, \"user_name\":\"Gilb\", \"repository\":{\"name\":\"gilb\", \"url\":\"git@git.gitlabserver:gilb.git\", \"description\":\"Gilb bot\", \"homepage\":\"http://gitlabserver/gilb\"}, \"commits\":[{\"id\":\"4d117cf6ba7b7055c8a3f3d1e5bf128b958c1a0e\", \"message\":\"Sample commit\", \"timestamp\":\"2013-03-21T15:57:11+00:00\", \"url\":\"http://gitlabserver/gilb/commit/4d117cf6ba7b7055c8a3f3d1e5bf128b958c1a0e\", \"author\":{\"name\":\"Carla Souza\", \"email\":\"contact@carlasouza.com\"}}], \"total_commits_count\":2}" $URL

sleep 5

kill $GILB_PID
