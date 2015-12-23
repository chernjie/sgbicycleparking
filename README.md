SG Bike Parking
===============

Map of publicly accessible bicycle racks/parking facilities in Singapore. Short URL to this map: http://bit.ly/sgbikeparking or https://goo.gl/5Kb3DC

Green icons: photo(s) attached
Red icons: unverified/no photos

Note: Although not necessarily listed here, most HDB void decks have several racks installed.

Mail varfie@gmail.com if interested to contribute!

*** this repository serves as a backup for the data and images

## Steps to run backup

1. Open [Google Map](http://bit.ly/sgbikeparking) on your browser
2. Then run the following to download KML file
```bash
$ make download
```
3. Some post download actions
```bash
$ make extract
```

Note: Step 2 and 3 can be combined with one command `make all`
