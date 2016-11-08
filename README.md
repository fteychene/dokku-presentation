# Dokku presentation

This codebase is for the presentation : A PaaS in 20 min

It's a tmuxinator / tmux based presentation that will :
 - Create a server on scaleway
 - Install dokku on it and show the installation page
 - Launch the deployment of the node app based on hello-nodeèbuildpack
 - Launch the deployment of the node angular app base on todo-rethink

All theses steps will be running in background unless some points where console activations are required for the demo.

Var are defined in a local .env in the root of the project.

## Backup strat
In the case you can't have internet connection during your presentation, you can create a VM with Vagrant and preinstall the app on the VM by surcharging your `/etc/hosts`.

```
192.168.0.42    {BASE_DOMAIN}
192.168.0.42    hello.{BASE_DOMAIN}
192.168.0.42    todo.{BASE_DOMAIN}
```

Warning : You can't either build buildpack app with no connection.
Only redeploy Dockerfile one without whanges (use docker build cache)

## Scripts
TODO
