# build me as fredhutch/ichorcna:3.6.2
FROM r-base:3.6.2

RUN apt-get update -y && apt-get install -y git libcurl4-openssl-dev cmake

RUN R -q -e 'install.packages(c("BiocManager", "plyr"), repos="https://cran.r-project.org")'
RUN R -q -e 'BiocManager::install(c("HMMcopy", "GenomicRanges", "GenomeInfoDb"))'


RUN git clone https://github.com/broadinstitute/ichorCNA.git

RUN R CMD INSTALL ichorCNA

RUN rm -rf ichorCNA/

RUN git clone https://github.com/shahcompbio/hmmcopy_utils.git

WORKDIR hmmcopy_utils

RUN cmake . && make && cp bin/* /usr/local/bin/

RUN find util/ -type f -exec cp {} /usr/local/bin \;

WORKDIR /

RUN rm -rf hmmcopy_utils

