
<!-- README.md is generated from README.Rmd. Please edit that file -->

## SOCIOL 232 / Visualizing Social Data / Spring 2023

## Kieran Healy, Duke University

This repo contains Course materials and website for [Visualizing Social
Data](https://visualizingsociety.com), which
[I](https://kieranhealy.org/about) am teaching at Duke University in the
Spring of 2023.

### Acknowledgements

Many thanks to the frighteningly energetic and exceedingly helpful
[Andrew Heiss](https://www.andrewheiss.com) for, as usual, being ahead
of the adoption curve with these tools and making several of his own
courses [publicly available](https://www.andrewheiss.com/teaching/).
Much of the back-end code and the `targets` pipeline used here has been
lightly-adapted from Andrew’s work.

### Dependency graph

Everything is a
[DAG](https://en.wikipedia.org/wiki/Directed_acyclic_graph) now. The
overall structure of the site is a bit messy in part because it does a
bunch of work to produce the slides, convert them to PDF with
`decktape`, zips up assignments and projects, and other things.

``` mermaid
graph LR
  subgraph Graph
    direction LR
    xdf832f8e1f99baf2(["schedule_file"]):::queued --> x35552a73efe9c59f(["schedule_ical_data"]):::queued
    x4a210bdf90796bca(["xaringan_files_files"]):::queued --> xf4774655f169db90["xaringan_files"]:::queued
    xf4774655f169db90["xaringan_files"]:::queued --> x60c212b45249134a["xaringan_slides"]:::queued
    x4d31f5a49d5ae49f(["schedule_ical_file"]):::queued --> x7aa56383a054e8ba(["site"]):::queued
    x063edd335cc1b36f(["schedule_page_data"]):::queued --> x7aa56383a054e8ba(["site"]):::queued
    x35552a73efe9c59f(["schedule_ical_data"]):::queued --> x4d31f5a49d5ae49f(["schedule_ical_file"]):::queued
    xa48826fcb4dc2e34(["project_paths_change"]):::queued --> xb4844be3dca7f02b(["project_paths"]):::queued
    xa3d8306cecf136f4(["data_penguins"]):::queued --> x2a5bb41380dcc5b0(["copy_penguins"]):::queued
    x60c212b45249134a["xaringan_slides"]:::queued --> x7a0d40becb063bda(["xaringan_html_files_files"]):::queued
    xb453b5ae08dcaee7(["build_data"]):::queued --> x1917c787a0a4a0fd["project_zips"]:::queued
    x41092a7251862a9e(["copy_data"]):::queued --> x1917c787a0a4a0fd["project_zips"]:::queued
    x7a8b235bff1bfb75["project_files"]:::queued --> x1917c787a0a4a0fd["project_zips"]:::queued
    x0751853b619def05["xaringan_html_files"]:::queued --> xccbb2c85646c611a["xaringan_pdfs"]:::queued
    x8288901d8e9e8d55(["data_gapminder"]):::queued --> xb453b5ae08dcaee7(["build_data"]):::queued
    x182180f03bcfc8dc(["data_mpg"]):::queued --> xb453b5ae08dcaee7(["build_data"]):::queued
    xa3d8306cecf136f4(["data_penguins"]):::queued --> xb453b5ae08dcaee7(["build_data"]):::queued
    x9c20b8c56debbe9a(["deploy_script"]):::queued --> x78f3e0b711425f1c(["deploy_site"]):::queued
    x7aa56383a054e8ba(["site"]):::queued --> x78f3e0b711425f1c(["deploy_site"]):::queued
    xb4844be3dca7f02b(["project_paths"]):::queued --> x7a8b235bff1bfb75["project_files"]:::queued
    x2a5bb41380dcc5b0(["copy_penguins"]):::queued --> x41092a7251862a9e(["copy_data"]):::queued
    x7a0d40becb063bda(["xaringan_html_files_files"]):::queued --> x0751853b619def05["xaringan_html_files"]:::queued
    xdf832f8e1f99baf2(["schedule_file"]):::queued --> x063edd335cc1b36f(["schedule_page_data"]):::queued
    x6e52cb0f1668cc22(["readme"]):::queued --> x6e52cb0f1668cc22(["readme"]):::queued
    xf38d3f5e6365ad72(["workflow_graph"]):::started --> xf38d3f5e6365ad72(["workflow_graph"]):::started
  end
```
