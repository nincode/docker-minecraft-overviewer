The container spins up on demand, generates htmls, then exits
A crontab job is needed to run it periodically


Install [TS|https://ostechnix.com/moreutils-collection-useful-unix-utilities/]
```
sudo apt install moreutils
```

Set up crontab (current user is fine as long as they have docker access)

```
12 4 * * * sh /home/relja/docker/docker-minecraft-overviewer/runOverviewerGen.sh
# An empty line is required at the end of this file for a valid cron file.
```
