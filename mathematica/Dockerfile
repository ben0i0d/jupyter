# FROM eoalab.org:1027/ben0i0d/jupyter:py-c AS builder

# COPY Mathematica_14.0.0_LINUX.sh .

# USER root
# # Two RUN layer to use cache
# RUN apt-get update --yes && apt-get install --yes --no-install-recommends xz-utils && apt-get clean && rm -rf /var/lib/apt/lists/* && \
#     bash Mathematica_14.0.0_LINUX.sh -- -auto -targetdir=/opt/Wolfram/Mathematica/14.0 && rm Mathematica_14.0.0_LINUX.sh 

# RUN git clone --depth 1 https://github.com/WolframResearch/WolframLanguageForJupyter.git && mv WolframLanguageForJupyter /opt 

FROM eoalab.org:1027/ben0i0d/jupyter:mma AS builder

FROM eoalab.org:1027/ben0i0d/jupyter:py-c

ENV PATH="${PATH}:/opt/Wolfram/Mathematica/14.0/Executables/" 

COPY --from=builder /opt/Wolfram/  /opt/Wolfram/
COPY --from=builder --chown="${NB_UID}:${NB_GID}" /opt/WolframLanguageForJupyter/ /opt/WolframLanguageForJupyter/
COPY --chown="${NB_UID}:${NB_GID}" kernel /opt/base/share/jupyter/kernels/wolframlanguage14/