# SPDX-License-Identifier: GPL-3.0-or-later
FROM linuxmintd/mint20.2-amd64

ARG github_pat
ENV GITHUB_PAT :$github_pat

ARG user=testuser
RUN useradd -mG sudo $user
RUN printf "1234\n1234\n" | passwd $user

USER $user
ENV USER $user
WORKDIR /home/$user

COPY mockup_bin mockup_bin
ENV PATH /home/$user/mockup_bin:$PATH

RUN echo "printf '1234\n1234\n' | sudo -Sp '' true" >> .bashrc
RUN echo "alias i='/install/install.sh'" >> .bashrc
RUN echo "alias ri='wget -O- rb.gy/g7akux|sh -s'" >> .bashrc
