# SSH Configuration
This is my ssh config.

Most of the settings are in separate files in config.d/, sourced by the Include directive. Most of them are in my secrets repository though.

Every host that has no period in their name will have his/her connection saved in a socket file.
This makes it possible to reuse connections in scripts or over the command line and get a tremendous speedup.

## github.conf
Since the User for ssh connections to GitHub needs to be git, there is no other way for GitHub to decern their users but by the ssh-key they are using. Thus, if you have multiple accounts, you should configure multiple aliases which reference the different ssh-keys, just like I did.
