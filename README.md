
<!-- README.md is generated from README.qmd. Please edit that file -->

## SOCIOL 232 / Visualizing Social Data / Spring 2024

## Kieran Healy, Duke University

This repo contains Course materials and website for [Visualizing Social
Data](https://visualizingsociety.com), which
[I](https://kieranhealy.org/about) am teaching at Duke University in the
Spring of 2024.

### Acknowledgements

Many thanks to [Andrew Heiss](https://www.andrewheiss.com) for, as
usual, being ahead of the adoption curve with these tools and making
several of his own courses [publicly
available](https://www.andrewheiss.com/teaching/). Much of the back-end
code and the `targets` pipeline used here has been adapted from Andrew’s
work.

### Everything is a DAG now

This is the dependency graph for the site.

``` mermaid
graph LR
  style Graph fill:#FFFFFF00,stroke:#000000;
  subgraph Graph
    direction LR
    xa3d8306cecf136f4(["data_penguins"]):::skipped --> xda4c206f717d9055(["copy_penguins_2"]):::skipped
    x8288901d8e9e8d55(["data_gapminder"]):::skipped --> xa4a8dd78d5a40779(["copy_gapminder_1"]):::skipped
    x8288901d8e9e8d55(["data_gapminder"]):::skipped --> xd72dc1eb9f3c29fa(["copy_gapminder_2"]):::skipped
    xb941f25d1f6cbb8b(["flipbookr_orphans_files"]):::built --> x166c32f35f62fc2a["flipbookr_orphans"]:::skipped
    x7aa56383a054e8ba(["site"]):::built --> x0d47bc58bf5ef066(["rendered_slides_files"]):::built
    xb453b5ae08dcaee7(["build_data"]):::skipped --> x1917c787a0a4a0fd["project_zips"]:::skipped
    x41092a7251862a9e(["copy_data"]):::skipped --> x1917c787a0a4a0fd["project_zips"]:::skipped
    x7a8b235bff1bfb75["project_files"]:::skipped --> x1917c787a0a4a0fd["project_zips"]:::skipped
    x2eefacb16aa347d9(["data_ukelection"]):::skipped --> x9cc68041722e9d3c(["copy_ukelection"]):::skipped
    xf88b542822cde7c4["rendered_slides"]:::skipped --> x6e713768fe05f8d1["quarto_pdfs"]:::built
    xdf832f8e1f99baf2(["schedule_file"]):::skipped --> x35552a73efe9c59f(["schedule_ical_data"]):::skipped
    xeaf4f7bf10c16d9f(["data_uscenpops"]):::skipped --> xd8c4ca61f745e89a(["copy_uscenpops"]):::skipped
    x9c20b8c56debbe9a(["deploy_script"]):::skipped --> x78f3e0b711425f1c(["deploy_site"]):::built
    x6e713768fe05f8d1["quarto_pdfs"]:::built --> x78f3e0b711425f1c(["deploy_site"]):::built
    x166c32f35f62fc2a["flipbookr_orphans"]:::skipped --> x288604413713fa92["move_orphans"]:::built
    x8f8d91dfd2b7ce09(["copy_apple"]):::skipped --> x41092a7251862a9e(["copy_data"]):::skipped
    xa4a8dd78d5a40779(["copy_gapminder_1"]):::skipped --> x41092a7251862a9e(["copy_data"]):::skipped
    xd72dc1eb9f3c29fa(["copy_gapminder_2"]):::skipped --> x41092a7251862a9e(["copy_data"]):::skipped
    xd7b98308373143d5(["copy_penguins_1"]):::skipped --> x41092a7251862a9e(["copy_data"]):::skipped
    xda4c206f717d9055(["copy_penguins_2"]):::skipped --> x41092a7251862a9e(["copy_data"]):::skipped
    x9cc68041722e9d3c(["copy_ukelection"]):::skipped --> x41092a7251862a9e(["copy_data"]):::skipped
    xd8c4ca61f745e89a(["copy_uscenpops"]):::skipped --> x41092a7251862a9e(["copy_data"]):::skipped
    x0d47bc58bf5ef066(["rendered_slides_files"]):::built --> xf88b542822cde7c4["rendered_slides"]:::skipped
    xb4844be3dca7f02b(["project_paths"]):::built --> x7a8b235bff1bfb75["project_files"]:::skipped
    xdf832f8e1f99baf2(["schedule_file"]):::skipped --> x063edd335cc1b36f(["schedule_page_data"]):::skipped
    x1917c787a0a4a0fd["project_zips"]:::skipped --> x7aa56383a054e8ba(["site"]):::built
    x4d31f5a49d5ae49f(["schedule_ical_file"]):::skipped --> x7aa56383a054e8ba(["site"]):::built
    x063edd335cc1b36f(["schedule_page_data"]):::skipped --> x7aa56383a054e8ba(["site"]):::built
    xa48826fcb4dc2e34(["project_paths_change"]):::built --> xb4844be3dca7f02b(["project_paths"]):::built
    x35552a73efe9c59f(["schedule_ical_data"]):::skipped --> x4d31f5a49d5ae49f(["schedule_ical_file"]):::skipped
    xf88b542822cde7c4["rendered_slides"]:::skipped --> xb941f25d1f6cbb8b(["flipbookr_orphans_files"]):::built
    x8288901d8e9e8d55(["data_gapminder"]):::skipped --> xb453b5ae08dcaee7(["build_data"]):::skipped
    x182180f03bcfc8dc(["data_mpg"]):::skipped --> xb453b5ae08dcaee7(["build_data"]):::skipped
    xa3d8306cecf136f4(["data_penguins"]):::skipped --> xb453b5ae08dcaee7(["build_data"]):::skipped
    x2eefacb16aa347d9(["data_ukelection"]):::skipped --> xb453b5ae08dcaee7(["build_data"]):::skipped
    xeaf4f7bf10c16d9f(["data_uscenpops"]):::skipped --> xb453b5ae08dcaee7(["build_data"]):::skipped
    xa3d8306cecf136f4(["data_penguins"]):::skipped --> xd7b98308373143d5(["copy_penguins_1"]):::skipped
  end
```
