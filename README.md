robustness-drupal-docker 
========================

This repo contains a recipe for making a [Docker](http://docker.io) container for Drupal, with the Internet Robustness plugin installed.

To build, make sure you have Docker [installed](http://www.docker.io/gettingstarted/).

## kill any running docker daemon
```
sudo killall docker
```
## Install docker:
```
curl get.docker.io | sudo sh -x
```

## Clone this repo somewhere, 
```
git clone https://github.com/berkmancenter/robustness-drupal-docker.git
cd robustness-drupal-docker
```
and then build it:
```
sudo docker build -t <yourname>/robustness-drupal .
```

this can take a while but should eventually return a command prompt. It's done when it says "Successfully built {hash}"

## And run the container, connecting port 80:
```
sudo docker run -d -t -p 80:80 <yourname>/robustness-drupal
```
That's it!
Visit http://localhost/ in your webrowser. 

Note: you cannot have port 80 already used or the container will not start.
In that case you can start by setting: `-p 8080:80`


### Credentials

* ROOT   MYSQL_PASSWORD will be on /mysql-root-pw.txt
* DRUPAL MYSQL PASSWORD will be on /drupal-db-pw.txt
* Drupal account-name=admin & account-pass=admin


## Authors

Based on docker-drupal, created and maintained by [Ricardo Amaro][author] (<mail@ricardoamaro.com>)

## License
GPL v3

[author]:                 https://github.com/ricardoamaro
[docker_upstart_issue]:   https://github.com/dotcloud/docker/issues/223
[docker_index]:           https://index.docker.io/

