FROM fedora:latest
LABEL maintainer="Ankit Pati <contact@ankitpati.in>"

RUN sed -z 's/\ntsflags=nodocs\n/\n/' -i /etc/dnf/dnf.conf
RUN echo 'fastestmirror=true' >> /etc/dnf/dnf.conf
RUN echo 'deltarpm=true' >> /etc/dnf/dnf.conf

RUN dnf update -y

RUN dnf install -y perl
RUN dnf install -y perl'(App::cpanminus)'

ENV PERL_CPANM_OPT="--mirror https://cpan.metacpan.org/"
RUN cpanm App::cpanminus
RUN cpanm App::cpanoutdated
RUN cpan-outdated -p | xargs cpanm
RUN cpanm Cpanel::JSON::XS
RUN cpanm EV
RUN cpanm IO::Socket::Socks
RUN cpanm IO::Socket::SSL
RUN cpanm Net::DNS::Native
RUN cpanm Role::Tiny
RUN cpanm Test::Pod
RUN cpanm Test::Pod::Coverage
RUN cpanm IO::Compress::Brotli

RUN dnf install -y man-db
RUN dnf install -y bash-completion
RUN dnf install -y vim-enhanced
RUN dnf install -y git

RUN git clone https://github.com/rtomayko/git-sh.git
WORKDIR git-sh
RUN make
RUN make install
RUN rm -rf git-sh/

ENV MOJOUSER="mojo"

RUN groupadd "$MOJOUSER"
RUN useradd -g "$MOJOUSER" "$MOJOUSER"
RUN echo "$MOJOUSER ALL=(ALL) NOPASSWD: ALL" > "/etc/sudoers.d/$MOJOUSER"

USER $MOJOUSER:$MOJOUSER

WORKDIR /opt/mojo
RUN sudo chown "$MOJOUSER:$MOJOUSER" -hR ./

ENV TEST_TLS="1"
ENV TEST_UNIX="1"
ENV TEST_ONLINE="1"
ENV TEST_SOCKS="1"
ENV TEST_SUBPROCESS="1"
ENV TEST_EV="1"
ENV TEST_PREFORK="1"
ENV TEST_MORBO="1"
ENV TEST_IPV6="1"
ENV TEST_HYPNOTOAD="1"
ENV TEST_POD="1"

ENTRYPOINT ["bash"]
CMD ["-l"]
