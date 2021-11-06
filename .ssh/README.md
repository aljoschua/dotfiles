# SSH Configuration
This is my ssh config.

Most of the settings are in separate files in config.d/, sourced by the Include directive.

Every host that has no period in their name will have his/her connection saved in a socket file.
This makes it possible to reuse connections in scripts or over the command line and get a tremendous speedup.

## tub.conf
Configuration for the Technical University of Berlin.

Using the ProxyJump directive, one can use the TUB servers without connecting to the VPN.
If there is already VPN connection to the TUB (assumed to be equivalent with having a tun0 network interface),
this ProxyJump will not be used.

You can also something like invoke `ssh furor-ubu` to directly connect to one of the ubuntu machines.

Requires that you have a live ticket granting ticket if you don't want to enter your password upon connection establishment (`kinit -f aljoschafrey@TU-BERLIN.DE`).

## github.conf
Since the User for ssh connections to GitHub needs to be git, there is no other way for GitHub to decern their users but by the ssh-key they are using. Thus, if you have multiple accounts, you should configure multiple aliases which reference the different ssh-keys, just like I did.
