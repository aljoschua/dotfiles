# SPDX-License-Identifier: GPL-3.0-or-later
FROM linuxmintd/mint20.2-amd64

ARG user=testuser

RUN useradd -mG sudo $user
RUN printf "1234\n1234\n" | passwd $user
USER $user
WORKDIR /home/$user
RUN echo "printf '1234\n1234\n' | sudo -S chown -R $user:$user ~" >> .bashrc
RUN echo "alias i=.config/install/install.sh" >> .bashrc
RUN echo "alias ri='wget -Of git.io/JqcSG;sh f'" >> .bashrc

# cd ~/.config/install
# docker build -t testinstall .
# docker run -itv $PWD:/home/testuser/.config/install testinstall
