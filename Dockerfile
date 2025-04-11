FROM docker.io/library/archlinux:base-devel

RUN pacman -Syu --needed --noconfirm \
    && pacman -S --noconfirm --needed git sudo \
    && groupadd --gid 118 github_ci_group \
    && useradd --uid 1001 --gid 118 -m builder \
    && printf 'builder ALL=(ALL:ALL) NOPASSWD: ALL\n' > /etc/sudoers.d/10-arch

WORKDIR /home/builder
USER builder

RUN git clone https://aur.archlinux.org/paru-bin.git \
    && cd paru-bin \
    && makepkg -si --noconfirm \
    && cd .. \
    && rm -rf paru-bin

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
