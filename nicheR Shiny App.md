## Background

This project is motivated by the need for better tools to test ecological and biological theory through code. The field of distributional ecology is evolving rapidly, with new algorithms, parameterization strategies, and hypotheses emerging at a fast pace. Evaluating these ideas requires software that can isolate mechanisms, account for bias, and clearly link ecological theory to model behavior.

Virtual niche simulations help researchers test ideas by creating controlled datasets that make model behavior easier to interpret and understand. In practice, building ellipsoid-based virtual niches in R often requires combining several different packages to define niches, map them to geography, and visualize results, which makes analyses harder to reproduce and build on.

`nicheR` addresses this gap by offering an integrated, R-native framework for ellipsoid-based virtual niches. It streamlines niche construction, simulation, visualization, and evaluation into a single, reproducible workflow, enabling researchers to develop, test, and compare ecological hypotheses more efficiently through code.

## Related work

Three primary tools have shaped the development of virtual species and virtual niche simulations in ENM and SDMs:

  - `NicheA` is a Java-based software that pioneered the integration of visualization into niche construction and explicitly linked niche theory with simulation-based tools. It was among the first platforms to emphasize environmental space representations of niches and has played an important conceptual role in the field. 

  - The [`virtualspecies`](https://github.com/Farewe/virtualspecies) R package, which has been widely adopted and cited (over 200 citations to date), provides a flexible framework for simulating virtual species and testing ENMs and SDMs within R. It enables users to generate virtual distributions under different assumptions and has become a standard tool for benchmarking species distribution models.

  - Finally, [`evniche`](https://github.com/marlonecobos/evniche/) is a lesser-known but theoretically rigorous non-CRAN R package designed to create, modify, and explore virtual niches, with a stronger emphasis on environmental space representations and ellipsoid-based niche concepts.

Building on these contributions, there is an opportunity to bring their strengths together into a single, cohesive, and fully reproducible workflow. In particular, integrating ellipsoid-based niche theory with sampling bias, geographic projection, and multidimensional visualization can further support theory-driven model evaluation and methodological development.

`nicheR` is designed to build directly on these existing approaches by unifying ellipsoidal niche construction, simulation, visualization, and evaluation in a well-documented R package with an optional R Shiny graphical user interface (GUI). The GUI will offer an accessible entry point for users who prefer interactive exploration, while still producing transparent, exportable objects and scripts that integrate seamlessly with fully scripted, reproducible analyses.


## Details of your coding project

The goal of this GSOC project is to build the R Shiny GUI for the `nicheR` package. 

### Core Shiny app features include:

  
**1. Data Preparation**

- **Goal:** Standardize data for later steps  
- **Elements:** Working with data frames and raster data  
  - **Loading data:** CSV files and spatial raster and vector formats  
  - **Processing data:** Limit layers to the area of interest  
  - **Defining dimensions:** Restrict to up to six dimensions  
  - **Export / load:** Save and reload prepared data  

**2. Designing the Niche**

- **Goal:** Define the virtual niche using an ellipsoid and compute its features  
- **Elements:**  
  - **Niche characteristics:** Range (breadth and position) and covariance (rotation)  
  - **Visual exploration:** Interactive plots updated after each definition step  
  - **Niche features:** Live summaries of the virtual niche (e.g., center, limits, niche volume)  
  - **Export / load:** Save niche features and export plots  

**3. Prediction and Virtual Data**

- **Goal:** Perform calculations for visualization and data generation  
- **Elements:**  
  - Predict what falls inside and outside the virtual niche  
  - Predict levels of suitability  
  - Generate data based on the virtual niche  
  - Generate data constrained by available environmental conditions  
  - Generate data under different sources of bias  
  - Export generated products  

**4. Reproducibility**

- **Goal:** Support fully reproducible workflows  
- **Elements:**  
  - Generate code from the interactive session  
  - Visualize the generated code  
  - Export code for scripted use  

      

### Basic documentation

  - A “Getting started” vignette demonstrating how to use the GUI for the package.
  - An additional vignette for advance use of the GUI. 

## Expected impact

This project will deliver an R-native, interactive tool for ellipsoid-based virtual niches, combining intuitive visualization with reproducible workflows. By lowering technical barriers while preserving methodological rigor, `nicheR` will expand access to advanced methods for researchers, instructors, and students across the R community.

## Mentors

**EVALUATING MENTOR: [Marlon E. Cobos](https://github.com/marlonecobos)**, manubio13@gmail.com, is an ecological modeler and biogeographer who has been a GSoC student and mentor since 2018 with the R Project Organization. Marlon is the author and maintainer of R packages like mop and kuenm, and has contributed to several packages on CRAN.

[**Vijay Barve**](https://github.com/vijaybarve), vijay.barve@gmail.com, is a biodiversity data scientist who has been a GSoC student and mentor since 2012 with the R Project Organization. Vijay is the author and maintainer of `bdvis` and has contributed to several packages on CRAN.

[**Luis Osorio-Olvera**](https://github.com/luismurao), luismurao@gmail.com, is a scientist focused on distributional ecology and has participated as a GSoC student in 2016 and mentor since 2019 with the R project organization. Luis has contributed to various R packages related to biodiversity analysis and visualizations, including [`ntbox`](LINK + descritpion clear that is shiny).



## Tests

Please complete one or more of the following tests before contacting the mentors above. Completing additional tests is encouraged. Please post your solutions under the next section, including code, figures, and a brief explanation.

**Easy**

- Install and load the packages terra and geodata.
- Download WorldClim bioclimatic variables at 10 arc minute resolution.
- Extract BIO1 (Annual Mean Temperature) from the dataset.
- Crop or mask BIO1 to an extent covering South America (polygon or bounding box acceptable).
- Plot the final processed raster.

**Medium**

- Install and load shiny along with terra and geodata.
- Build a Shiny interface that performs the workflow from the Easy test.
- Include:
  - A button that runs the workflow
  - A plot panel displaying BIO1 after each step:
    - Downloaded global raster
    - Extracted BIO1 layer
    - Cropped extent
    - Masked final result

**Hard**

- Create an R package that deploys the Shiny app developed above.
- Include:
  - A function (for example run_app()) to launch the interface
  - Helper functions for downloading and processing bioclim data
  - Documentation using roxygen2
  - A DESCRIPTION file and license
  - A README with installation and usage instructions
  - Configure GitHub Actions to run R CMD check with no errors, warnings, or notes.


## Solutions of tests

- **Contributor:** Mariana Castaneda-Guzman
- **Github username:** [castanedaM](https://github.com/castanedaM)
- **Test Solutions:** [Easy](https://github.com/castanedaM/nicheR_GSoC_2026_test_solutions/easy_test_solution.R), [Medium](https://github.com/castanedaM/nicheR_GSoC_2026_test_solutions/medium_test_solution.R), Hard
