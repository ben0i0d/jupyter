FROM ben0i0d/jupyter:py-c AS builder

COPY Mathematica_14.0.0_LINUX.sh .

USER root

RUN apt-get update --yes && apt-get install --yes --no-install-recommends xz-utils && apt-get clean && rm -rf /var/lib/apt/lists/* && \
    bash Mathematica_14.0.0_LINUX.sh -- -auto -targetdir=/opt/Wolfram/Mathematica/14.0 && rm Mathematica_14.0.0_LINUX.sh  

FROM ben0i0d/jupyter:py-c

ENV PATH="${PATH}:/opt/Wolfram/Mathematica/14.0/Executables/" 

COPY --chown="${NB_UID}:${NB_GID}" WolframLanguageForJupyter /opt/WolframLanguageForJupyter/
COPY --chown="${NB_UID}:${NB_GID}" kernel /opt/base/share/jupyter/kernels/wolframlanguage14/
COPY --from=builder /opt/Wolfram/ /opt/Wolfram/
