FROM fedora:latest 

# install git and some build dependencies
RUN dnf -y install git pam-devel gcc kernel-devel gnupg

# need zfs source for includes & libs
RUN dnf -y install http://download.zfsonlinux.org/fedora/zfs-release$(rpm -E %dist).noarch.rpm
RUN gpg --quiet --with-fingerprint /etc/pki/rpm-gpg/RPM-GPG-KEY-zfsonlinux
RUN dnf -y install zfs

# the project to build
RUN git clone https://github.com/snehring/pam_researchit.git	

WORKDIR pam_researchit
RUN gcc -shared -fPIC -lpam -I/usr/src/zfs-0.7.12/include -I/usr/src/zfs-0.7.12/lib/libspl/include pam_researchit.c /usr/lib64/libzfs_core.so.1.0.0 -o pam_researchit

