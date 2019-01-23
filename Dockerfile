FROM fedora:latest 

# install git and some build dependencies
RUN dnf -y install git pam-devel gcc kernel-devel

# need zfs source for includes & libs
RUN git clone https://github.com/zfsonlinux/zfs.git

# the project to build
RUN git clone https://github.com/snehring/pam_researchit.git	

WORKDIR pam_researchit
RUN gcc -shared -fPIC -lpam -l/zfs/lib -I/zfs/include/spl -I/zfs/include -std=c18 pam_researchit.c -o pam_researchit

