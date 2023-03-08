
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
bunch of work to produce the slides, convert them to PDFs with
`decktape`, zips up assignments and projects, and other things.

``` mermaid
graph LR
  subgraph Graph
    direction LR
    xdf832f8e1f99baf2(["schedule_file"]):::built --> x35552a73efe9c59f(["schedule_ical_data"]):::queued
    x9c20b8c56debbe9a(["deploy_script"]):::built --> x78f3e0b711425f1c(["deploy_site"]):::queued
    x7aa56383a054e8ba(["site"]):::queued --> x78f3e0b711425f1c(["deploy_site"]):::queued
    x8f8d91dfd2b7ce09(["copy_apple"]):::built --> x41092a7251862a9e(["copy_data"]):::queued
    xa4a8dd78d5a40779(["copy_gapminder_1"]):::queued --> x41092a7251862a9e(["copy_data"]):::queued
    xd72dc1eb9f3c29fa(["copy_gapminder_2"]):::queued --> x41092a7251862a9e(["copy_data"]):::queued
    xd7b98308373143d5(["copy_penguins_1"]):::queued --> x41092a7251862a9e(["copy_data"]):::queued
    xda4c206f717d9055(["copy_penguins_2"]):::queued --> x41092a7251862a9e(["copy_data"]):::queued
    x9cc68041722e9d3c(["copy_ukelection"]):::queued --> x41092a7251862a9e(["copy_data"]):::queued
    xd8c4ca61f745e89a(["copy_uscenpops"]):::queued --> x41092a7251862a9e(["copy_data"]):::queued
    x2eefacb16aa347d9(["data_ukelection"]):::built --> x9cc68041722e9d3c(["copy_ukelection"]):::queued
    x0751853b619def05["xaringan_html_files"]:::queued --> xccbb2c85646c611a["xaringan_pdfs"]:::queued
    xb4844be3dca7f02b(["project_paths"]):::queued --> x7a8b235bff1bfb75["project_files"]:::queued
    x7a0d40becb063bda(["xaringan_html_files_files"]):::queued --> x0751853b619def05["xaringan_html_files"]:::queued
    xeaf4f7bf10c16d9f(["data_uscenpops"]):::queued --> xd8c4ca61f745e89a(["copy_uscenpops"]):::queued
    x1917c787a0a4a0fd["project_zips"]:::queued --> x7aa56383a054e8ba(["site"]):::queued
    x4d31f5a49d5ae49f(["schedule_ical_file"]):::queued --> x7aa56383a054e8ba(["site"]):::queued
    x063edd335cc1b36f(["schedule_page_data"]):::queued --> x7aa56383a054e8ba(["site"]):::queued
    xccbb2c85646c611a["xaringan_pdfs"]:::queued --> x7aa56383a054e8ba(["site"]):::queued
    x60c212b45249134a["xaringan_slides"]:::queued --> x7aa56383a054e8ba(["site"]):::queued
    x4a210bdf90796bca(["xaringan_files_files"]):::built --> xf4774655f169db90["xaringan_files"]:::queued
    x8288901d8e9e8d55(["data_gapminder"]):::queued --> xb453b5ae08dcaee7(["build_data"]):::queued
    x182180f03bcfc8dc(["data_mpg"]):::built --> xb453b5ae08dcaee7(["build_data"]):::queued
    xa3d8306cecf136f4(["data_penguins"]):::queued --> xb453b5ae08dcaee7(["build_data"]):::queued
    x2eefacb16aa347d9(["data_ukelection"]):::built --> xb453b5ae08dcaee7(["build_data"]):::queued
    xeaf4f7bf10c16d9f(["data_uscenpops"]):::queued --> xb453b5ae08dcaee7(["build_data"]):::queued
    xa48826fcb4dc2e34(["project_paths_change"]):::queued --> xb4844be3dca7f02b(["project_paths"]):::queued
    xb453b5ae08dcaee7(["build_data"]):::queued --> x1917c787a0a4a0fd["project_zips"]:::queued
    x41092a7251862a9e(["copy_data"]):::queued --> x1917c787a0a4a0fd["project_zips"]:::queued
    x7a8b235bff1bfb75["project_files"]:::queued --> x1917c787a0a4a0fd["project_zips"]:::queued
    xf4774655f169db90["xaringan_files"]:::queued --> x60c212b45249134a["xaringan_slides"]:::queued
    x8288901d8e9e8d55(["data_gapminder"]):::queued --> xa4a8dd78d5a40779(["copy_gapminder_1"]):::queued
    x8288901d8e9e8d55(["data_gapminder"]):::queued --> xd72dc1eb9f3c29fa(["copy_gapminder_2"]):::queued
    x60c212b45249134a["xaringan_slides"]:::queued --> x7a0d40becb063bda(["xaringan_html_files_files"]):::queued
    xdf832f8e1f99baf2(["schedule_file"]):::built --> x063edd335cc1b36f(["schedule_page_data"]):::queued
    xf38d3f5e6365ad72(["workflow_graph"]):::started --> x6e52cb0f1668cc22(["readme"]):::queued
    xa3d8306cecf136f4(["data_penguins"]):::queued --> xd7b98308373143d5(["copy_penguins_1"]):::queued
    xa3d8306cecf136f4(["data_penguins"]):::queued --> xda4c206f717d9055(["copy_penguins_2"]):::queued
    x35552a73efe9c59f(["schedule_ical_data"]):::queued --> x4d31f5a49d5ae49f(["schedule_ical_file"]):::queued
  end
```
