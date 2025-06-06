# Executable Environment for OSF Project [zfqax](https://osf.io/zfqax/)

This repository was automatically generated as part of a project to test the reproducibility of open science projects hosted on the Open Science Framework (OSF).

**Project Title:** Social Ball: An immersive research paradigm to study social ostracism

**Project Description:**
> We introduce “Social Ball,” a new research paradigm to study ostracism via an online ball tossing game based on Cyberball (Williams &amp; Jarvis, 2006) designed with both researchers and participants in mind. For researchers, the game incorporates a variety of features which are easily accessible from the software’s interface. Some of these features have already been studied with Cyberball (e.g., tossing different objects) but some are novel (e.g., end-game communication or hand-waving during the game). From the participants’ perspective, the game was designed to be more visually and socially immersive to create a more video-game-like online environment. We discuss two previous implementations. Study 1 showed that Social Ball successfully induced need threat and negative affect among ostracized (vs included) participants (n = 247). Study 2 empirically demonstrated how a new feature of the game (i.e., hand-waving) can be used to answer various questions. The results suggested that people waved their hands to varying degrees yet the frequency of which was not associated with post game need satisfaction (n = 2578). Besides describing the features of the game, we also provide a configuration manual and an annotated R code (both as online supplementary materials) to make the paradigm and associated analyses more accessible, and in turn, to stimulate further research. In our discussion, we elaborate on the various ways in which Social Ball can contribute to the understanding of belonging and ostracism.

**Original OSF Page:** [https://osf.io/zfqax/](https://osf.io/zfqax/)

---

**Important Note:** The contents of the `zfqax_src` folder were cloned from the OSF project on **12-03-2025**. Any changes made to the original OSF project after this date will not be reflected in this repository.

The `DESCRIPTION` file was automatically added to make this project Binder-ready. For more information on how R-based OSF projects are containerized, please refer to the `osf-to-binder` GitHub repository: [https://github.com/Code-Inspect/osf-to-binder](https://github.com/Code-Inspect/osf-to-binder)

## flowR Integration

This version of the repository has the **[flowR Addin](https://github.com/flowr-analysis/rstudio-addin-flowr)** preinstalled. flowR allows visual design and execution of data analysis workflows within RStudio, supporting better reproducibility and modular analysis pipelines.

To use flowR, open the project in RStudio and go to `Addins` > `flowR`.

## How to Launch:

**Launch in your Browser:**

🚀 **MyBinder:** [![Binder](https://mybinder.org/badge_logo.svg)](https://mybinder.org/v2/gh/code-inspect-binder/osf_zfqax-f/HEAD?urlpath=rstudio)

   * This will launch the project in an interactive RStudio environment in your web browser.
   * Please note that Binder may take a few minutes to build the environment.

🚀 **NFDI JupyterHub:** [![NFDI](https://nfdi-jupyter.de/images/nfdi_badge.svg)](https://hub.nfdi-jupyter.de/r2d/gh/code-inspect-binder/osf_zfqax-f/HEAD?urlpath=rstudio)

   * This will launch the project in an interactive RStudio environment on the NFDI JupyterHub platform.

**Access Downloaded Data:**
The downloaded data from the OSF project is located in the `zfqax_src` folder.

## Run via Docker for Long-Term Reproducibility

In addition to launching this project using Binder or NFDI JupyterHub, you can reproduce the environment locally using Docker. This is especially useful for long-term access, offline use, or high-performance computing environments.

### Pull the Docker Image

```bash
docker pull meet261/repo2docker-zfqax-f:latest
```

### Launch RStudio Server

Run the container (with a name, e.g. `rstudio-dev`):
```bash
docker run -it --name rstudio-dev --platform linux/amd64 -p 8888:8787 --user root meet261/repo2docker-zfqax-f bash
```

Inside the container, start RStudio Server with no authentication:
```bash
/usr/lib/rstudio-server/bin/rserver --www-port 8787 --auth-none=1
```

Then, open your browser and go to: [http://localhost:8888](http://localhost:8888)

> **Note:** If you're running the container on a remote server (e.g., via SSH), replace `localhost` with your server's IP address.
> For example: `http://<your-server-ip>:8888`

## Looking for the Base Version?

For the original Binder-ready repository **without flowR**, visit:
[osf_zfqax](https://github.com/code-inspect-binder/osf_zfqax)

