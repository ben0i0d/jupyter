# jupyter-image-stacks
## 如果您通过github访问本项目，请注意
1. github上的仓库是由源仓库推送的镜像仓库，是一个镜像仓库
2. 我们的源仓库是 https://eoelab.org:1031/build-image-stacks/jupyter-image-stacks  
3. 我们的docker镜像仓库是 https://hub.docker.com/r/ben0i0d/jupyter   
4. 对于issue/PR，我们推荐在源仓库上提，这对于我们工作更方便，并且源仓库具有pipeline支持
## 项目梗概
### 目标预期
1. 完整：从基础系统开始，项目内部完成依赖，并实现一个CI文件用于自动化构建。
2. 安全：源代码与镜像构建公开化，测试与工作场景是Rancher管理的私有K8S集群下的Jupyterhub,main分支Dockerfile均是经过测试而发布的
3. 多样：从现有的仓库代码开始，从现有的kernel开始，集成进入项目统一构建，并完成汉化，扩展，配置镜像源等工作  
### 如何使用
**Docker**
* 没有数据持久化地使用：`docker run -d -p 8888:8888 ben0i0d/jupyter:<tag>`  
* 提供数据持久化地使用：`docker run -d -p 8888:8888 -v "${PWD}":/home/jovyan ben0i0d/jupyter:<tag>`

**Jupyterhub**  
在singleuser内的profile指定镜像
```
- description: 提供Python的科学计算环境，提供了丰富的数值计算、优化、信号处理、统计分析等功能，用于科学研究和工程应用。
    display_name: Scipy
    kubespawner_override:
        image: eoelab.org:1032/build-image-stacks/jupyter-image-stacks/jupyter:scipy-c
```
### 全局说明
1. 在终端下运行`pip config set global.index-url https://mirrors.bfsu.edu.cn/pypi/web/simple`完成pip换源
2. 如果您有测试或者新需求，请构建一个新分支,在源仓库工作时，请改动ci文件中tag字段避免覆盖，如果自行构建或派生，替换dockerfile中的基础镜像为dockerhub上的镜像
3. 对于例如Mathematica，MATLAB等商业软件，我们只提供打包，具体激活方式及可能带来的后果由用户承担
4. 我们默认隐藏`__pycache__`，即在文件浏览器视图中不可见
5. 对于ohmyzsh，在terminal内只需执行以下代码一次即可
```
git clone https://github.com/ohmyzsh/ohmyzsh.git ~/.oh-my-zsh
cp ~/.oh-my-zsh/templates/zshrc.zsh-template ~/.zshrc
```
6. 以下代码适用于解决matplotlib绘图缺失中文字体
```
from matplotlib.font_manager import FontProperties
# 设置中文字体路径
zh_font = FontProperties(fname="/usr/share/fonts/truetype/wqy/wqy-zenhei.ttc")
# 将中文字体设置为默认字体
plt.rcParams["font.family"] = zh_font.get_name()
```
7. 以下代码适用于增加对conda虚拟目录的支持，以实现自定义环境不丢失
    1. 数据持久化
        * docker启动时添加`-v "DATA-VOLUME":/opt/conda/envs/`
        * Jupyterhub添加额外挂载点到`/opt/conda/envs/`
    2. 虚拟环境安装内核  
        * 使用`conda create -n NAME *** ipykernel` 创建这个虚拟环境。使用`source activate NAME`切换到这个虚拟环境，并且添加一个kernel到本地的`.jupyter`目录，使用`python -m ipykernel install --user --name NAME --display-name "DISPLAY-NAME"`完成
### 当前构建镜像清单
* Upstream: 镜像上游，对标jupyter官方的minimal-notebook镜像
    * 说明
        1. 上游已经切换到`debian:trixie`，GPU上游镜像也基于`debian:trixie`二次构建了镜像
        2. 默认情况下我们添加了eoelab.org的域名证书，这不会带来安全问题
        3. 添加了sudo的无密码使用，在安全要求较高的场景中，不要允许特权提升
        4. 提供软件包：SHELL(zsh)，文件压缩/解压(.bz2|.zip|.7z)，项目管理(git|git-lfs),证书管理(ca-certificates)，编辑器（vim）,网络交互（curl|wget）,中文字体（fonts-wqy-zenhei）
* Llinux（With Desktop-GUI）：在无特权的情况下学习Linux系统，提供Xfce桌面支持   
* Pyjo：支持Python与Mojo，通过将python语法与生态系统相结合进行生产与研究，mojo具备元编程特性。我们期待这一环境带来的改进
    * 说明
        1. Mojo被合并进Python,由于网络原因需要手动执行`modular install mojo && python /opt/modular/pkg/packages.modular.com_mojo/jupyter/manage_kernel.py install `完成添加kernel
    * Scipyjo：提供Python的科学计算环境，提供了丰富的数值计算、优化、信号处理、统计分析等功能，用于科学研究和工程应用。
    * Scrpyjo: 提供Python的网页采取环境，用于提取互联网上的数据，实现自动化的信息收集和分析任务，适用于数据挖掘、网络爬虫以及业务情报收集等应用场景。
    * Pyjospark: 提供基于Python的Spark编程接口，用于大规模数据处理和分析，提供了强大的并行计算能力和丰富的数据操作函数，适合在分布式环境中进行高效的数据处理和机器学习任务。
    * Pyjoflink: 提供基于Python的Flink编程接口，用于对无边界和有边界的数据流进行有状态的计算,也提供了批处理API，用于基于流式计算引擎处理批量数据的计算能力。
    * Pyjoai（With GPU）：提供常用AI工具链，提供了丰富的深度学习框架和NLP模型库，使开发人员能够轻松构建和训练各种人工智能模型，并应用于图像识别、自然语言处理等领域。
* C: 支持C(versions ≥ C89)，通用的编程语言，底层和高效，广泛应用于系统级开发和嵌入式设备。
* CPP：支持CPP（11,14,17），多范式的编程语言，是C语言的扩展，具备面向对象和泛型编程能力，广泛应用于系统级开发和大规模软件项目。
* Cadabra: 支持Cadabra（Cadabra2），一种基于符号计算的软件系统，专门用于进行复杂代数计算和张量分析，适合在理论物理学和相对论研究中使用。
* Julia：支持Julia，高性能、动态的编程语言，设计用于科学计算和数据分析，具备类似Python的易读性和类似C的执行速度。
    * 说明：
        1. Julia镜像中的环境变量`JULIA_NUM_THREADS`，请在启动时根据理想的并发线程数进行配置
* SciR：支持R的科学计算环境，面向统计分析和数据可视化的编程语言，拥有丰富的数据处理库和强大的统计功能，广泛应用于数据科学和研究领域。
  * Rspark: 提供基于R的Spark编程接口，用于在Spark上运行R代码。提供了R语言在大数据处理和分布式环境中的能力，可以进行高效的数据操作、机器学习和统计分析，适用于大规模数据处理和分析任务。
* Haskell: 支持Haskell，纯函数式编程语言，强调表达力和静态类型检查，提供强大的模式匹配和高阶函数支持，适用于函数式编程爱好者和学术研究。
* Java: 支持Java，面向对象的通用编程语言，跨平台特性和庞大的生态系统，广泛应用于企业级开发、移动应用程序和大型软件项目。
* Kotlin: 支持Kotlin，现代、静态类型的编程语言，与Java互操作性良好，提供更简洁、安全和高效的语法，用于Android开发和跨平台应用程序。
* JavaSript: 支持JavaSript，一种广泛应用于网页开发的脚本语言，用于实现交互性和动态效果，也适用于服务器端开发和移动应用程序。
* Go: 支持Go，简洁、高效的编程语言，注重并发和性能，适用于构建可扩展的网络服务，被广泛应用于云计算、分布式系统和网络编程领域。
* Rust: 支持Rust，安全、并发和高性能的系统级编程语言，强调内存安全和线程安全，适合开发高效且可靠的系统软件，如操作系统、网络服务和嵌入式设备。
* Fortran：支持Fortran，最早的高级编程语言之一，用于科学计算和数值分析，特别擅长处理大规模、复杂的数值计算问题，在科学领域仍广泛使用。
* Ansible: 支持Ansible，开源的自动化工具，用于配置管理、部署和编排任务，在服务器管理和系统自动化方面广泛应用，简化了复杂的IT操作流程。
* Agda: 支持Agda，依赖类型的函数式编程语言和交互式证明工具，强调形式化验证和程序正确性，在形式化方法和类型理论研究中广受欢迎。
* APL (Dyalog): 支持APL (Dyalog)，一种符号化的数组编程语言，极具表达力和紧凑性，适用于高维数据处理、数学建模和算法开发，Dyalog是其中一种流行的实现版本。
* Chapel: 支持Chapel，用于高性能并行编程的并发编程语言，旨在简化分布式计算和大规模数据处理，具备易用性和可移植性，适用于科学计算、并行算法和并行任务调度。
* Lua: 支持Lua，轻量级、嵌入式的脚本语言，具有简洁的语法和快速的执行速度，广泛应用于游戏开发、嵌入式系统和脚本扩展。
* SQL: 支持SQL，是一种用于管理和处理关系型数据库的语言。它是一个标准化的语言，通常用于执行各种操作，例如创建、修改和删除数据库中的表格，以及检索、插入、更新和删除表格中的数据。在环境中提供duckdb数据库
* Sagemath：一个开源的数学计算系统，结合了多个数学软件包，提供了广泛的数学功能，如数值计算、符号计算、离散数学和统计分析。它也是一个交互式计算环境，方便进行数学建模、算法设计和学术研究。  
* Dotnet: 一个跨平台的开发框架，支持C#、F#、PW，用于构建各种类型的应用程序，包括Web应用、桌面应用和移动应用。它提供了丰富的类库和工具，简化了开发过程，并具有高性能和可扩展性。
* Scilab（With Desktop-GUI）: 开源的数值计算软件，适用于科学和工程领域中的数值分析、数据可视化、模拟和建模。它提供了丰富的数学函数和工具箱，支持矩阵计算、符号计算和绘图功能，是一个强大的数学工具，尤其适用于教育和研究领域，提供Xfce桌面支持，包含APT可获取的全部插件。
* Octave: 开源的数值计算软件，类似于Matlab，用于科学计算、数据分析和数值模拟。它提供了强大的矩阵运算、绘图功能以及丰富的数值分析函数，是一个免费且便捷的工具，适合进行数学建模、算法开发和教学任务，包含APT可获取的全部插件。
* Maple: 一个数学软件，透过智能文件界面提供强大数学引擎，可以轻松分析、探索、可视化和求解数学问题
    * 说明
        1. 将`license.dat libmaple.so`上传至主目录，每一次启动环境时，运行`cp license.dat /opt/maple/license && cp libmaple.so /opt/maple/bin.X86_64_LINUX/`完成激活再使用
* Mathematica:一个科学计算软件，在数据分析、数学计算等领域提供了强大方便的使用功能。
    * 说明
        1. 每一次启动环境时，运行`WolframKernel`完成手动激活，激活码查看`https://ibug.io/blog/2019/05/mathematica-keygen/`，如果多次激活不成功，请运行`rm /home/jovyan/.Mathematica/Licensing/mathpass`删除之前的许可记录
* MATLAB：一种支持数据分析、算法开发和建模的编程和数值计算平台。
    * 说明
        1. 将`license.lic libmwlmgrimpl.so`上传至主目录，每一次启动环境时，运行`cp license.lic /opt/matlab/r2023b/licenses/ && cp libmwlmgrimpl.so /opt/matlab/r2023b/bin/glnxa64/matlab_startup_plugins/lmgrimpl/`完成激活再使用
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
BASE-->ENV{ENVIRONMENT}-->EA(Dotnet)
ENV-->EB(Llinux)
BASE-->PROGRAM{PROGRAMLANG}
PROGRAM-->PA(C)
PROGRAM-->PB(CPP)
PROGRAM-->PC(Julia)
PROGRAM-->PD(SciR)-->PDA(Rspark)
PROGRAM-->PE(Go)
PROGRAM-->PF(Rust)
PROGRAM-->PG(Java)
PROGRAM-->PH(Kotlin)
PROGRAM-->PI(JavaSript)
PROGRAM-->PJ(Raku:Perl6)
PROGRAM-->PK(Lua)
PROGRAM-->PL(Fortran)
PROGRAM-->PM(Ansible)
PROGRAM-->PN(Agda)
PROGRAM-->PO(APL:Dyalog)
PROGRAM-->PP(Cadabra)
PROGRAM-->PQ(Haskell)
PROGRAM-->PR(Pyjo)
PROGRAM-->PS(Q#)
PROGRAM-->PT(SQL)
PR-->PRA(Scipyjo)
PR-->PRB(Scrpyjo)
PRA-->PRAA(Pyjoai)  
PRA-->PRAB(Pyjospark)  
PRA-->PRAC(Pyjoflink)  
BASE-->MATH{MATH-TOOL}-->MA(Octave)
MATH-->MB(Scilab)
MATH-->MC(Sagemath)
MATH-->ME(Mathematica)
MATH-->MD(MATLAB)-->MDA(minimal)-->MDAA(mcm)
```

## 上游

**软件包版本**
* cuda 12.2.0
* Python 3.11
* Julia 1.9.4
* Java openjdk-17
* kotlin(jre) openjdk-17-jre
* Dotnet 7.0
* spark 3.5.0
* jupyterlab 4
* Matlab R2023b
* Mathematica 13.3.1
* Maple 2023
* Flink 

**镜像源**
* conda bfsu：https://mirrors.bfsu.edu.cn/help/anaconda/
* pip bfsu：https://mirrors.bfsu.edu.cn/help/pypi/
* apt ustc：https://mirrors.ustc.edu.cn/help/debian.html
* npm npmmirror(AliYun): https://registry.npmmirror.com/
* apache tuna: https://mirrors.tuna.tsinghua.edu.cn/apache/
* julia-pkg ustc: https://mirrors.ustc.edu.cn/julia/
* hackage ustc: https://mirrors.ustc.edu.cn/hackage/
* Stackage ustc: https://mirrors.ustc.edu.cn/stackage/
* GO AliYun: https://mirrors.aliyun.com/goproxy/
* cargo ustc: git://mirrors.ustc.edu.cn/crates.io-index

### 项目上游
jupyter团队项目 https://github.com/jupyter/docker-stacks

**但是我们与上游差别较大，包括源，软件包，本地化与扩展等，因此如果您从本项目派生遇到问题，请不要到jupyter团队提问，这会加大他们的工作量**

### kernel
* C: https://github.com/XaverKlemenschits/jupyter-c-kernel
* Cpp: https://github.com/jupyter-xeus/xeus-cling
* Python：https://ipython.org/
* Go: https://github.com/gopherdata/gophernotes
* Haskell: https://github.com/gibiansky/IHaskell
* Java: https://github.com/SpencerPark/IJava
* JavaScript: https://github.com/n-riesco/ijavascript
* Julia: https://github.com/JuliaLang/IJulia.jl
* R: http://irkernel.github.io/
* Rust: https://github.com/evcxr/evcxr
* agda: https://github.com/lclem/agda-kernel
* ansible: https://github.com/ansible/ansible-jupyter-kernel
* Octave: https://github.com/Calysto/octave_kernel
* Dotnet(C#,F#,Powershell)： https://github.com/dotnet/interactive
* Kotlin: https://github.com/Kotlin/kotlin-jupyter
* Fortran: https://github.com/lfortran/lfortran
* APL (Dyalog): https://github.com/Dyalog/dyalog-jupyter-kernel
* Raku(Perl6): https://github.com/bduggan/raku-jupyter-kernel
* Lua: https://github.com/guysv/ilua
* Cadabra: https://github.com/kpeeters/cadabra2
* Chapel: http://github.com/krishnadey30/jupyter_kernel_chapel
* SQL: https://github.com/suyin1203/duckdb_kernel
* NoVNC: https://github.com/jupyterhub/jupyter-remote-desktop-proxy
* MATLAB: https://github.com/mathworks/jupyter-matlab-proxy
## 必要的版权说明
对于派生自其他团队的代码，我们在文件头添加了原版版权声明，我们保留并且支持其他开发团队版权

