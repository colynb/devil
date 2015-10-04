# devil
DEVIL installs a docker based local environment that includes nginx, php, and mysql. Host as many web sites you want using a single web container.

## What It Includes

 * PHP Composer
 * Docker
 * Docker Machine
 * Docker Compose

## What It DOES NOT Include

 * VirtualBox. Docker Machine boots up a VM using VirtualBox, so be sure to install that first.

## Basic Installation

DEVIL is installed by running a shell script via curl:

```
sh -c "$(curl -fsSL https://raw.githubusercontent.com/colynb/devil/master/tools/install-zsh.sh)"
```

## Container Setup

Once you've installed the DEVIL cli, you can use it to install all the docker dev tools:

```
> devil install
```

With those installed, you can start up your development containers:

```
> devil up
```
