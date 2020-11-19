# mkdocs-material
Material for MkDocs is a ToIP Branded theme for [MkDocs](https://www.mkdocs.org/), a static site generator geared towards (technical) project documentation and specification development. This ToIP repo template for with ToIP Material Theme to be used as a GitHub Template Repository.

## Objective
This repo is a [GitHub Repo Template](https://docs.github.com/en/free-pro-team@latest/github/creating-cloning-and-archiving-repositories/creating-a-template-repository) for creating GitHub repositories within the ToIP GitHub Organization. Newly generated repos will contain all the necessary code for using MkDocs for the development of [ToIP Deliverables](https://github.com/trustoverip/deliverables/blob/master/_process/work_products.md).

## Requirements

### Workflow
ToIP contributors should be able to:
1. Gather: Define, Organize and Assign work towards the developement of a ToIP Deliverable based on project outline that aggregates a collection of discrete Markdown files. 
2. Author: Use any Markdown editor they desire. 
3. Produce: Configure the generation of one or two possible deliverables: General Document, Specification.

### Styling
1. Apply a Material style Theme that is ToIP specific 
2. Leverage a Color pallet derives from the ToIP Logo.
3. Provide configurable navigator with numeric outlines level 1-3: See examople Spec style: https://identity.foundation/sidetree/spec/
4. Build upon the Material Theme (not insiders) with Search Suggest and/or Highlight - void of Insider Token trequirements. 
5. One ToIP Theme with config option for header generated numbering (with or without).

### Versioning
ToIP members hsould be able to prime to repos using this repo as a GitHub Template Repository.
	
### Development and Processing
1. Command line tools (make) for generating local test content. See example Repos:
	* https://github.com/vinomaster/bbu-gf
	* https://github.com/vinomaster/mkdocs-weasyprint-template
2. Github workflow (actions) for producing GitHub-Pages
3. Layout (outline / organize) multiple markdown files (i.e.: mkdocs.yml)

### Rendering Formats
Minimally, this repo MUST allow for the configuration of generating these rendoring formats:
1. Single Markdown file (via pandoc or other plugins)
2. Single PDF (via pdf-export or other plugins)
3. Website/GitHub-Pages
