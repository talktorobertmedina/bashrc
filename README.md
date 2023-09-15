# bashrc
Configuration settings for my personal linux development environment

## Installation
The install script, install_bashrc.sh, will copy the bashrc file to the path provided.
If it finds another file called, .bashrc, then it will rename it to .bashrc.bak, and
then copy over the bashrc that it is trying to install.

## Usage
Run source /path/installed/.bashrc to use it

## Project Structure
* bash_aliases - Store all aliases
* bash_envs - Store all environment variables
* bash_functions - Store all bash functions
* bashrc - main script that loads each subscript
* git_functions - Store all git functions

## License
[GPL 3.0](https://choosealicense.com/licenses/gpl-3.0/)
