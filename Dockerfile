# build me as fredhutch/ichorcna:3.6.2
FROM r-base:3.6.2

RUN apt-get update -y && apt-get install -y git libcurl4-openssl-dev

RUN R -q -e 'install.packages(c("BiocManager", "plyr"), repos="https://cran.r-project.org")'
RUN R -q -e 'BiocManager::install(c("HMMcopy", "GenomicRanges", "GenomeInfoDb"))'


RUN git clone https://github.com/broadinstitute/ichorCNA.git

RUN R CMD INSTALL ichorCNA

RUN rm -rf ichorCNA/
