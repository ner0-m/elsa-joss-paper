---
title: '**elsa**: an elegeant framework for tomographic reconstruction'
tags:
  - Computed Tomography
  - X-ray Computed Tomography
  - Tomography
  - Tomographic Reconstruction
  - Inverse Problems
  - Software Framework
  - C++
  - Python
authors:
  - name: David Frank
    affiliation: "1, 2"
  - name: Jonas Jelten
    affiliation: "1, 2"
  - name: Tobias Lasser
    affiliation: "1, 2"
affiliations:
 - name: Department of Computer Science, TUM School of Computation, Information and Technology, Technical University of Munich, Munich, Germany
   index: 1
 - name: Munich Institute of Biomedical Engineering, Technical University of Munich, Munich, Germany
   index: 2
date: 5 September 2023
bibliography: paper.bib

# Optional fields if submitting to a AAS journal too, see this blog post:
# https://blog.joss.theoj.org/2018/12/a-new-collaboration-with-aas-publishing
# aas-doi: 10.3847/xxxxx <- update this with the DOI from AAS once you know it.
# aas-journal: Astrophysical Journal <- The name of the AAS journal.
---

# Summary

elsa is as a versatile framework in the landscape of X-ray tomography, offering
a powerful toolkit for the development of iterative reconstruction algorithms.
Primarily designed for challenging applications in classical attenuation X-ray
computed tomography (CT) and advanced modalities like Phase-Contrast X-ray CT
or Anisotropic Dark-field tomography (AXDT), elsa stands out with its expansive
set of building blocks and a unified abstraction, providing the means for
high-quality reconstructions across a spectrum of imaging scenarios.

Designed as an operator- and optimisation-based framework, elsa takes a
mathematical approach to model the reconstruction pipeline of imaging
modalities. Through the formulation of optimisation problems and a suite of
solvers, elsa addresses challenges in attenuation X-ray CT, Phase-Contrast CT,
and AXDT.

The core of elsa, developed in modern C++ with GPU acceleration, ensures
efficiency, while its Python interface enhances accessibility for both students
and researchers.

Distinctively, elsa positions itself as a unique solution by supporting
iterative reconstruction techniques for novel X-ray CT imaging modalities. The
framework addresses challenges associated with X-ray CT with arbitrary
trajectories, Phase-Contrast X-ray CT, and Anisotropic X-ray Dark-Field
Tomography, offering a simple abstraction for implementing tailored
reconstruction methods.

# Statement of need

The introduction of X-ray Computed Tomography (CT) in the 1970s revolutionized
medical diagnostics, offering unprecedented insights into the human body's
internal structures. Unlike traditional radiography, CT generates
reconstructions through computation, which introduced the need for software
frameworks. Popular frameworks include ASTRA [@vanAarle2016], scico
[@balke2022], and the Core Imaging Library [@Jrgensen2021;@Papoutsellis2021],
or ODL [@Adler2017]. \autoref{fig:seashell_walnut} shows slices from two
example reconstruction using elsa.

![Example reconstruction of two different attenuation X-ray CT datasets. Left:
Axial center slice of the walnut provided in @meaney2022. Right: Lateral
center slice of the seashell of the dataset provided by
@kamutta2022.\label{fig:seashell_walnut}](imgs/seashell_walnut.png)

In recent years, one of the major challenges tackled by research is the
reduction of X-ray dose. As X-ray dose can be harmful to humans, it is vital to
reduce it as much as possible. However, a reduction of the X-ray dose usually
results in worse reconstruction quality. Many reconstruction techniques have
been developed to maintain a high reconstruction quality with a reduced X-ray
dosage. However, till today this remains an open problem. \autoref{fig:2detect}
illustrates the differences of a high-dose and 3 different low-dose
reconstruction. The low-dose reconstruction use different optimisation problems
to better model the noise characteristics found in low-dose X-ray CT.


![Reconstruction of slice 29 of the 2DeteCT dataset [@kiss2023]. Left most
image is a reconstruction of high-dose data, the left three images are using
the low-dose measurements. The three low-dose reconstruction differ in the
noise assumption (Gaussian, an approximation of Poisson and a Poisson assumption)
\label{fig:2detect}](imgs/2detect.png)

Classical X-ray CT, reliant on X-ray attenuation, faces limitations in soft
tissue contrast and spatial resolution. The advent of modern imaging
modalities, considering additional physical effects such as phase, refraction,
and scatter, introduces both opportunities and challenges.

![Some image of AXDT\label{fig:axdt}](imgs/axdt.png)

In this landscape, elsa emerges as a distinctive framework focusing on
iterative reconstruction techniques for modern X-ray CT imaging modalities.
Offering a rich set of tools, elsa addresses challenges in fields like X-ray CT
with arbitrary trajectories, Phase-Contrast X-ray CT, and Anisotropic X-ray
Dark-Field Tomography. Its unique contribution lies in supporting novel
X-ray-based modalities while providing a versatile platform for tailored
reconstruction methods.

elsa has been integral to our group's research, playing a vital role in
scientific publications. Noteworthy applications include robotic X-ray CT and
trajectory optimization [@pekel2022a;@pekel2022b;@pekel2023a;@pekel2023b], as
well as successful integration with deep learning approaches
[@cheslerean2023wnet;@cheslerean2023transformer]. Recognised in scientific
conferences [@Lasser19;@frank2023], elsa proves to be an indispensable tool,
contributing significantly to advancing the field of X-ray tomography.

# Model-based reconstruction

The basic premise of model-based reconstruction is to formulate the image
reconstruction process as a mathematical optimisation problem. The goal is to
minimise a data fidelity term, representing the proximity of the reconstructed
image to the actual measurements, augmented by regularisation terms to
incorporate prior knowledge. The basic mathematical formulation used is the
following:

$$ \underset{x}{\operatorname{argmin}} D(A, x) + \sum_{i=1}^n R_i(x) $$

For X-ray CT, elsa supports various data fidelity terms, including (Weighted)
Least Squares and Poisson log likelihood, addressing different noise
characteristics. Moreover, it provides a range of regularization techniques
such as L2, sparsity-inducing L1, total variation, and Plug-and-Play (PnP)
priors, allowing users to tailor reconstructions to specific needs. elsa's
adaptability to different imaging scenarios makes it an invaluable asset in
advancing the field of model-based reconstruction.

# Advanced Imaging Modalities

Grating-based phase-contrast CT introduces a paradigm shift in X-ray imaging by
exploiting the phase information of X-rays. While traditional X-ray CT relies
on attenuation, phase-contrast imaging allows for enhanced visualisation of
soft tissues due to variations in refractive indices. One of the biggest
challenges is the forward model for this modality. As only a difference in
phase can be measured, one needs a differentiable basis functions (e.g. so
called blobs, or B-Splines) instead of pixel or voxels, as the basis of the
projection operations. elsa has support for such a forward model. This is a
unique feature for an open-source framework.

Anisotropic X-ray Dark-Field Tomography (AXDT) is at the forefront of advancing
X-ray imaging modalities, providing unique insights into structural and
compositional information through the detection of small-angle X-ray
scattering. The upsides of AXDT include its ability to visualise structural
information in materials. However, challenges arise in handling the anisotropic
nature of the scattering process and optimising reconstructions accordingly.
elsa plays a crucial role in addressing these challenges by offering a suite of
tools tailored for AXDT. These tools first and foremost include again the
support for the forward model, but it also includes different noise models for
the reconstruction process, which have a tremendous influence on the
reconstruction quality.

# Acknowledgements

We want to acknowledge the work by Shen Hu and Matthias Wieczorek for their
work on the AXDT support. Matthias Wieczorek has originally developed much
during his PhD, and Shen Hu ported a lot of Matthias' effort to the currently
open source version of elsa.

Further, we want to thank Noah Dormann for the initial support of
Phase-Contrast CT.

Finally, we want to thank all of our past contributors and students that made
elsa to what is is today!

# References
