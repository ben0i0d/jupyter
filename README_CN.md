# jupyter-image-stacks

## 通用的Jupyterlab镜像组 

English | [中文](README_CN.md)

**为中国用户的文档**

**我们的docker镜像仓库是 https://hub.docker.com/r/ben0i0d/jupyter**
**我们的Gitea镜像仓库是 https://eoelab.org:1027/ben0i0d/jupyter**

### 如何使用
**Docker**
* 没有数据持久化地使用：`docker run -d -p 8888:8888 docker.io/ben0i0d/jupyter:<tag>`  
* 提供数据持久化地使用：`docker run -d -p 8888:8888 -v "${PWD}":/home/jovyan docker.io/ben0i0d/jupyter:<tag>`

**Jupyterhub on K8S**  
在singleuser内的profile指定镜像
```
- description: 提供Python的科学计算环境，提供了丰富的数值计算、优化、信号处理、统计分析等功能，用于科学研究和工程应用。
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
### 全局说明
1. 如果自行构建或派生，替换dockerfile中的基础镜像为dockerhub上的镜像
2. 对于例如Mathematica，MATLAB等商业软件，我们只提供打包，具体激活方式及可能带来的后果由用户承担
3. 以下代码适用于解决matplotlib绘图缺失中文字体(使用前需要先安装wqy-zenhei字体)
```
from matplotlib.font_manager import FontProperties
# 设置中文字体路径
zh_font = FontProperties(fname="/usr/share/fonts/truetype/wqy/wqy-zenhei.ttc")
# 将中文字体设置为默认字体
plt.rcParams["font.family"] = zh_font.get_name()
```
### 需要额外说明的镜像
* Base：基础镜像，包含jupyterhub，jupyterlab，相当于jupyter官方的minimal-notebook镜像
    * 说明
        1. 上游已经切换到`debian:bookworm-slim`
        2. 添加了sudo的无密码使用，在安全要求较高的场景中，不要允许特权提升
        3. 提供软件包：.zip文件解压(.zip)
* Python：支持Python。
    * Scipy：提供Python的科学计算环境
    * Scrpy: 提供Python的网页采取环境，适用于数据挖掘、网络爬虫
    * pyspark: 提供基于Python的Spark编程接口
    * pyflink: 提供基于Python的Flink编程接口
    * pyai（With GPU）：提供Pytorch。
* Julia：支持Julia
    * 说明：
        1. Julia镜像中的环境变量`JULIA_NUM_THREADS`，请在启动时根据理想的并发线程数进行配置，默认为8
* Maple: 一个数学软件，透过智能文件界面提供强大数学引擎，可以轻松分析、探索、可视化和求解数学问题
    * 说明
        1. 将`license.dat libmaple.so`上传至主目录，每一次启动环境时，运行`sudo cp license.dat /opt/maple/license && sudo cp libmaple.so /opt/maple/bin.X86_64_LINUX/`完成激活再使用
* Mathematica:一个科学计算软件，在数据分析、数学计算等领域提供了强大方便的使用功能。
    * 说明
        1. 每一次启动环境时，运行`WolframKernel`完成手动激活，激活码查看`https://mmaactivate.github.io/MMAActivate/`，如果多次激活不成功，请运行`rm /home/jovyan/.Mathematica/Licensing/mathpass`删除之前的许可记录
        2. 如果你有账户，使用WEB验证/在线验证
        3. 该镜像存在问题, kernel 卡在 connecting.
* MATLAB：一种支持数据分析、算法开发和建模的编程和数值计算平台。
    * 说明
        1. 将`license.lic libmwlmgrimpl.so`上传至主目录，每一次启动环境时，运行`sudo cp license.lic /opt/matlab/r2023b/licenses/ && sudo cp libmwlmgrimpl.so /opt/matlab/r2023b/bin/glnxa64/matlab_startup_plugins/lmgrimpl/`完成激活再使用
        2. 如果你有账户，使用WEB验证/在线验证
    * minimal:仅仅包含`Product:MATLAB`
    * mcm:包含数学建模所需要的工具箱

### 插件清单

**全局**
* jupyterlab-language-pack-zh-CN:对中文的支持
* jupyterlab_tabnine：用于自动补全、参数建议、函数文档查询、跳转定义

**局部**

### 镜像依赖关系
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

## 上游

**软件包版本**
* cuda 12.2.0
* Python 3.11
* Julia latest
* spark 3.5.4
* flink 1.20.0
* jupyterlab 4
* Matlab R2023b
* Mathematica 13.3.1
* Maple 2023

**镜像源**
* pip bfsu：https://mirrors.bfsu.edu.cn/help/pypi/
* apt ustc：https://mirrors.ustc.edu.cn/help/debian.html
* apache ustc: https://mirrors.ustc.edu.cn/apache/
* julia-pkg ustc: https://mirrors.ustc.edu.cn/julia/
* CRAN ustc：https://mirrors.ustc.edu.cn/CRAN/

### 项目上游
jupyter团队项目 https://github.com/jupyter/docker-stacks

**但是我们与上游差别较大，包括源，软件包，本地化与扩展等，因此如果您从本项目派生遇到问题，请不要到jupyter团队提问，这会加大他们的工作量**

### kernel
* Python：https://ipython.org/
* Julia: https://github.com/JuliaLang/IJulia.jl
* R: http://irkernel.github.io/
* Octave: https://github.com/Calysto/octave_kernel
* MATLAB: https://github.com/mathworks/jupyter-matlab-proxy
* MMA: https://github.com/WolframResearch/WolframLanguageForJupyter

## 必要的版权说明
对于派生自其他团队的代码，我们在文件头添加了原版版权声明，我们保留并且支持其他开发团队版权

