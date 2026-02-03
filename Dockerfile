ARG VERSION=3.5.3
FROM rocker/verse:$VERSION
ENV CRAN=https://cloud-rproject.org

# replace standard mirrors with archive mirrors
RUN sed -i 's/deb http:\/\/deb.debian.org\/debian stretch main/deb http:\/\/archive.debian.org\/debian stretch main/g' /etc/apt/sources.list && \
    sed -i 's/deb http:\/\/security.debian.org\/debian-security stretch\/updates main/deb http:\/\/archive.debian.org\/debian-security stretch\/updates main/g' /etc/apt/sources.list && \
    # Optional: comment out the stretch-updates line if it causes issues
    sed -i '/stretch-updates/d' /etc/apt/sources.list

# install general packages
RUN apt-get update \
    && apt-get install -y --no-install-recommends --allow-unauthenticated \
    curl \
    unzip \
    gzip \
    bzip2 \
    ca-certificates \
    build-essential \
    gfortran \
    libgfortran-6-dev \
    libgomp1 \
    r-base-dev \
    libcurl4-openssl-dev \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /var/log/dpkg.log

# install gsl packages
RUN apt-get update \
    && apt-get install -y --no-install-recommends --allow-unauthenticated \
    libgsl-dev libgsl2 libatlas3-base liblapack-dev \
    && apt-get clean

# replace cran with build date mirror
ARG ${BUILD_DATE}
ARG RPROFILE_LOC="usr/local/lib/R/etc/Rprofile.site"
RUN echo "options(repos = c(CRAN = 'https://packagemanager.posit.co/cran/${BUILD_DATE}'))" >> $RPROFILE_LOC

# set working directory to user directory
ARG ${USER}
RUN echo "setwd('~/$USER/')" >> $RPROFILE_LOC

# install requested packages
ARG GITHUB_INSTALL_PACKAGES
ARG CRAN_INSTALL_PACKAGES
RUN echo "Packages to install: $CRAN_INSTALL_PACKAGES $GITHUB_INSTALL_PACKAGES"
COPY "install_script.r" "install_script.r" 
RUN Rscript "install_script.r" "$CRAN_INSTALL_PACKAGES" "$GITHUB_INSTALL_PACKAGES"

