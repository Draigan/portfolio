# Draegan's portfolio

## Setup

Install rbenv and ruby-build:
```
git clone https://github.com/rbenv/rbenv.git ~/.rbenv
echo 'eval "$(~/.rbenv/bin/rbenv init - bash)"' >> ~/.bashrc
git clone https://github.com/rbenv/ruby-build.git "$(rbenv root)"/plugins/ruby-build
apt-get install autoconf bison patch build-essential rustc libssl-dev libyaml-dev libreadline6-dev zlib1g-dev libgmp-dev libncurses5-dev libffi-dev libgdbm6 libgdbm-dev libdb-dev uuid-dev
```


Install Ruby (the version is determined by the file .ruby-version):
```
rbenv install
```


Install bundler:
```
gem install bundler
```


Install Gem dependencies (the gems and their versions are determinded by the files Gemfile and Gemfile.lock):
```
bundle
```


## Developing and building

Development server (reachable via localhost:4567):
```
bundle exec middleman --watcher-force-polling --watcher-latency=3
```


Local production build:
```
bundle exec middlemand build
rm -rf <path-to-repo>/build/assets
cp <path-to-repo>/source/assets <path-to-repo>/build/assets
```
