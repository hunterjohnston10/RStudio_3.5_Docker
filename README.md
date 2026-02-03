# RStudio 3.5 Docker

This is a package that allows you to run R 3.5 in a Docker container with RStudio. 

# Installation and Useage

1) Clone the repo
2) Configure the .env file by editing PASSWORD and USER from .env_examlpe and saving as .env. Additionally, specify a directory you would like to access with the VOLUME variable.
3) Run `run.sh` to build the container and automatically open RStudio in the browser when it is finished building. Alternatively, you can build it yourself and run it with `docker compose up -d --build`.
4) Access RStudio at http://localhost:8787 
