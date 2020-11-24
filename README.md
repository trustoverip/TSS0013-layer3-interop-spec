#  Trust over IP - Documentation and Specification Template

This template repository provides a ready-to-use setup for a ToIP branded theme
for [MkDocs][1], a static site generator geared towards (technical) project 
documentation and specification development. The theme is a customized version
of [Material for MkDocs][2].

  [1]: https://www.mkdocs.org/
  [2]: https://squidfunk.github.io/mkdocs-material/

## Setup

1. Generate a new repository from this template repository (see [GitHub docs][3])
2. Clone the new repository (see [GitHub docs][4])
3. Open the repository in an editor (i.e. [Visual Studio Code][5]):

   1. If you want to create _general documentation_, you can just delete the
      `mkdocs.spec.yml` file, which is located at the root of the project.
   2. If you want to create a _specification_, delete the `mkdocs.yml` file,
      and rename `mkdocs.spec.yml` to `mkdocs.yml`

4. Ensure that you have `python`, `make` and [`pandoc`][6] installed, the latter
   of which is necessary to create a combined Markdown file. If you don't need
   to do that, you don't need to install `pandoc`.

5. Bootstrap the local environment, which will automatically install and setup
   [`virtualenv`][7], a tool to create isolated Python environments:

   ```
   make setup
   ```

   After the command finished, your terminal should now show `(venv)` before the
   prompt, to indicate you're inside a virtual environment. If you want to leave
   the environment, just close the terminal, or enter:

   ```
   deactivate
   ```

## Usage

### Preview server

Ensure that you're inside the virtual environment, i.e. repeat step 5 from the
setup if you're unsure. Now, in order to preview your documentation project,
enter:

```
make serve
```

This will start MkDocs and spin up a development server at http://localhost:8000.
After [making yourself familiar with MkDocs][8], create a Markdown file in the
`docs` folder, and add it to the `nav` section in `mkdocs.yml`. The development
server will reload every time you save your document, or make a change in
`mkdocs.yml`.

### Combined Markdown file

If you want to create a combined Markdown file, this repository contains some
scripts which will preprocess and concatenate all Markdown files in the order
specified in `mkdocs.yml`. The scripts will ensure that internal links to
pages and anchors are correct. The combined file can be created with:

```
make combine
```

The resulting Markdown file will be located at `dist/index.md`, alongside with
the contents of the `assets` folder. The reason for that is that you probably
want to include all assets (i.e. images) when distributing yout documentation.

## Deployment

This repository contains a GitHub Action workflow that will automatically
deploy your project documentation when you commit your changes to:

```
https://<username>.github.io/<repository>
```

When you're forking this repository, you may need to activate GitHub Actions
for your fork, as GitHub disables them by default. This is as easy as clicking
on __Actions__ in the top bar of your repository and clicking the button that
is shown. If no button is shown, you're good to go.

  [3]: https://docs.github.com/en/free-pro-team@latest/github/creating-cloning-and-archiving-repositories/creating-a-repository-from-a-template
  [4]: https://docs.github.com/en/free-pro-team@latest/github/creating-cloning-and-archiving-repositories/cloning-a-repository
  [5]: https://code.visualstudio.com/
  [6]: https://pandoc.org/installing.html
  [7]: https://virtualenv.pypa.io/en/latest/
  [8]: https://www.mkdocs.org/#getting-started
