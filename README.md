# jupyter-image-stacks

## Universal Jupyterlab Image stacks

English | [中文](README_CN.md)

**THIS doc for non-CN USER**

**ghcr.io: https://github.com/eoeair/jupyter/pkgs/container/jupyter**

**Our Gitea: https://eoelab.org:1027/eoeair/jupyter**

### HOW TO USE
**Docker**
* No data is used persistently：`docker run -d -p 8888:8888 docker.io/ben0i0d/jupyter:<tag>`  
* Provide data for persistent use：`docker run -d -p 8888:8888 -v "${PWD}":/home/jovyan docker.io/ben0i0d/jupyter:<tag>`

**Jupyterhub on K8S**  
Specify the image in the profile of the singleuser
```
- description:  SCIPython, for scientific research and engineering applications.
    display_name: Scipy
    kubespawner_override:
        image: docker.io/ben0i0d/jupyter:scipy
```

**Jupyterhub on Docker**
```
c.DockerSpawner.allowed_images = {
        'Scipy': 'ben0i0d/jupyter:scipy'
}
```
### Global description
1. If you build or fork the image yourself, replace the base image in the Dockerfile with the image on DockerHub
2. For commercial software such as Mathematica, MATLAB, etc., we only provide packaging, and the specific activation method and possible consequences are borne by the user
### List of images that are currently being built
* Base: benchmarking against the jupyter official minimal-notebook image
    * Description
        1. Upstream has switched to `debian:bookworm-slim`, and GPU upstream images are also built based on `debian:bookworm`
        2. Sudo is added for passwordless use. In scenarios with high security requirements, do not allow privilege escalation
        3. Provided packages: .zip extraction
* Python: Supports Python
    * Scipy: Provides a scientific computing environment for Python
    * Scrpy: Provides a web scraping environment for Python
    * pyspark: Provides a Python-based Spark program
    * pyflink: Provides a Python-based Flink program
    * pyai (With GPU): Provides Pytorch
* Julia: Supports Julia
    * Description:
        1. Environment variable `JULIA_NUM_THREADS` in Julia image, please configure according to desired concurrency threads at startup, default is 8
* Maple: A mathematical software that provides a powerful mathematical engine through an intelligent file interface, enabling easy analysis, exploration, visualization, and solving of mathematical problems.
    * Description
        1. Upload `license.dat libmaple.so` to the main directory. Each time the environment is started, run `sudo cp license.dat /opt/maple/license && sudo cp libmaple.so /opt/maple/bin.X86_64_LINUX/` to activate before use.
* Mathematica: A scientific computing software that provides powerful and convenient features for data analysis, mathematical computation, and other fields.
    * Description
        1. Each time the environment is started, run `WolframKernel` to manually activate. View activation code at `https://mmaactivate.github.io/MMAActivate/`. If activation fails multiple times, run `rm /home/jovyan/.Mathematica/Licensing/mathpass` to delete previous license records.
        2. If you have an account, use web verification/online verification.
        3. THIS IS NOT READY NOW , kernel is stuck connecting.
* MATLAB: A programming and numerical computing platform that supports data analysis, algorithm development, and modeling.
    * Description
        1. Upload `license.lic libmwlmgrimpl.so` to the main directory. Each time the environment is started, run `sudo cp license.lic /opt/matlab/r2023b/licenses/ && sudo cp libmwlmgrimpl.so /opt/matlab/r2023b/bin/glnxa64/matlab_startup_plugins/lmgrimpl/` to activate before use.
        2. If you have an account, use web verification/online verification.
    * minimal: Contains only `Product:MATLAB`
    * mcm: Contains toolboxes required for mathematical modeling.


### List of plugins

**Global**
* jupyterlab-language-pack-zh-CN:Support for Chinese
* jupyterlab-lsp：It is used for autocompletion, parameter suggestion, function document query, and jump definition
* jupyterlab-execute-time: Displays the execution time of each cell
* jedi-language-server: Python Language server

**Part**

* R: r-languageserver: R Language server

* Julia: julia-language-server: Julia Language server

### Image dependencies
```mermaid
graph LR
Python-->P{PROGRAMLANG}
P-->PA(R)
P-->PB(Julia)
P-->PC(C)
P-->PD(Cpp)
P-->PE(Ansible)
P-->PF(Chapel)
P-->PG(Dyalog)
P-->PH(Fortran)
P-->PI(Go)
P-->PJ(Haskell)
P-->PK(Java)
P-->PL(Js)
P-->PM(Kotlin)
P-->PN(Lua)


Python-->G{GUI}-->GA(Novnc)-->GAA(Pyqt6)

Python-->S{Science-compute}-->SA(Scipy)
S-->SB(Pyai)

Python-->B{BigData}-->BA(pyspark)
B-->BB(pyflink)
B-->BC(Scrpy)
B-->BD(Sql)

Python-->M{MATH-TOOL}-->MA(Octave)
M-->MB(Maple)
M-->MC(Sagemath)
M-->MD(MATLAB-minimal)-->MDA(Matlab-mcm)
M-->ME(Mathematica)
M-->MF(Scilab)
```

## Upstream

**Package version**
* cuda 12.2.0
* Python 3.11
* Julia latest
* spark 3.5.4
* flink 1.20.0
* jupyterlab 4
* Matlab R2023b
* Mathematica 14.0
* Maple 2023

**Default Mirror source**
* pip bfsu：https://mirrors.bfsu.edu.cn/help/pypi/
* apt ustc：https://mirrors.ustc.edu.cn/help/debian.html
* apache ustc: https://mirrors.ustc.edu.cn/apache/
* julia-pkg mirrorz: https://mirrors.cernet.edu.cn/julia
* CRAN ustc：https://mirrors.ustc.edu.cn/CRAN/

***Now You can use ARG control which site you want***

### Upstream of the project
https://github.com/jupyter/docker-stacks

**However, we are quite different from the upstream in terms of sources, packages, localizations, extensions, etc., so if you have a problem with this project, please do not ask the Jupyter team questions, as it will increase their workload**

### kernel
* Python：https://ipython.org/
* Julia: https://github.com/JuliaLang/IJulia.jl
* R: http://irkernel.github.io/
* Octave: https://github.com/Calysto/octave_kernel
* MATLAB: https://github.com/mathworks/jupyter-matlab-proxy
* MMA: https://github.com/WolframResearch/WolframLanguageForJupyter

## Necessary copyright notice
For code derived from other teams, we added the original copyright notice to the file header, and we retain and support the copyrights of other development teams