FROM geodels/geodels-libs:latest

RUN find /live/lib/LavaVu/notebooks -name \*.ipynb  -print0 | xargs -0 jupyter trust

# install FILLIT
WORKDIR /live/lib
RUN git clone https://github.com/Geodels/fillit.git && \
    cd fillit && \
    export F90=gfortran && \
    cd src && \
    make all  && \
    cd .. && \
    python setup.py install && \
    cd .. && \
    rm -rf fillit

# install eSCAPE 
WORKDIR /live/lib
RUN git clone https://github.com/Geodels/eSCAPE.git && \
    cd eSCAPE && \
    export F90=gfortran && \
    export PETSC_DIR=/live/lib/petsc && \
    export PETSC_ARCH=arch-linux2-c-opt && \
    python setup.py install && \
    cd .. && \
    rm -rf eSCAPE

# install eSCAPE-demo
WORKDIR /live
RUN git clone https://github.com/Geodels/eSCAPE-demo.git && \
    mv /live/eSCAPE-demo /live/notebooks


# note we also use xvfb which is required for viz
ENTRYPOINT ["/usr/local/bin/tini", "--", "xvfbrun.sh"]

# setup space for working in
VOLUME /live/share

WORKDIR /live
# expose notebook port
EXPOSE 8888

# expose LavaVu port
EXPOSE 9999

ENV LD_LIBRARY_PATH=/live/lib/:/live/share
ENV PETSC_DIR /live/lib/petsc
ENV PETSC_ARCH arch-linux2-c-opt

# launch notebook
CMD ["jupyter", "notebook", " --no-browser", "--allow-root", "--ip=0.0.0.0", "--NotebookApp.iopub_data_rate_limit=1.0e10"]
