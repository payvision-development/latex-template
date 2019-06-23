# Technical Documentation

LaTeX is a great tool to create documents. It's based on the 'WYSIWYM' (what you see is what you mean) idea, meaning you only have to focus on the contents of your document and the computer will take care of the formatting.

<p align="center">
  <img src="https://raw.githubusercontent.com/payvision-development/latex-template/master/pictures/example.png" alt="PDF example"  width="700">
</p>

## Prerequisites

If you’re new to TeX and LaTeX or just want an easy installation, get a full TeX distribution.

- [LaTeX](https://www.latex-project.org/get/)
- [Pygments](http://pygments.org/)

# Compile

Once you have prepared and saved the .tex file, it still must be compiled before it can be turned into a readable document. 

`pdflatex [filename].tex` will compile `[filename].tex` and output the file `[filename].pdf`

```shell
pdflatex --shell-escape [filename].tex
```

*`minted` package uses Pygments of Python for the coloring schemes. You need to invoke the `--shell-escape` option in order for LaTeX to allow Pygments to be used.

# TeX editors

If you prefer compose your documents in an integrated writing environment you can choose from an extensive variety of TeX editors, the most complete are:

- [TeXstudio](https://www.texstudio.org/)
- [Texmaker](http://www.xm1math.net/texmaker/)
- [Visual Studio Code](https://code.visualstudio.com/)

# Docker image

To avoid install a complete TeX distribution in our system we can run it form a Docker image. It consists in a Debian based image with a TeX Live distribution and some extra packages.

Build the image: `docker build . -t latex` and invoke `pdflatex` form the container:

```shell
docker run -i --rm -w /data -v ${pwd}:/data latex pdflatex [filename].tex
```

## Visual Studio Code LaTeX Workshop extension

[LaTeX Workshop](https://marketplace.visualstudio.com/items?itemName=James-Yu.latex-workshop) is an extension for Visual Studio Code, aiming to provide all-in-one features and utilities for LaTeX typesetting with Visual Studio Code.

In order to compile documents using a Docker image you have to enable this feature and define the image you want to use to compile your document.

The following settings should be applied in the `settings.json` file order to compile our documents with our custom Docker image:

```json
{
   "latex-workshop.docker.enabled": true,
   "latex-workshop.docker.image.latex": "latex",
   "latex-workshop.latex.tools": [
      {
         "name": "latexmk",
         "command": "latexmk",
         "args": [
         "-synctex=1",
         "-interaction=nonstopmode",
         "-file-line-error",
         "--shell-escape",
         "-pdf",
         "-outdir=%OUTDIR%",
         "%DOC%"
         ],
         "env": {}
      },
      {
         "name": "pdflatex",
         "command": "pdflatex",
         "args": [
         "-synctex=1",
         "-interaction=nonstopmode",
         "-file-line-error",
         "--shell-escape",
         "%DOC%"
         ],
         "env": {}
      },
      {
         "name": "bibtex",
         "command": "bibtex",
         "args": [
         "%DOCFILE%"
         ],
         "env": {}
      }
   ]
}
```

# Typesetting and code examples

## Figures 

The figure environment takes care of the numbering and positioning of the image within the document. In order to include a figure, you must use the \includegraphics command. 

### Example

Images usually will be centered and optionally resized to a percentage of the column width.

```latex
\begin{figure}[hbt!]
   \centering
   \includegraphics[width=0.8\textwidth]{figure.png}
   \caption{My figure}
   \label{fig:my_figure}
\end{figure}
```

## Code snippets

Minted is a pack­age that fa­cil­i­tates ex­pres­sive syn­tax high­light­ing in LaTeX us­ing the pow­er­ful Pyg­ments li­brary. The pack­age also pro­vides op­tions to cus­tomize the high­lighted source code out­put us­ing `fan­cyvrb`.

### Configuration

```latex
% Set 'Code' prefix for all code snippets caption
\newenvironment{codesnippet}{\captionsetup{type=listing}}{}
\SetupFloatingEnvironment{listing}{name=Code}
\captionsetup[listing]{position=below,skip=0pt}

% Set font size to small
\setminted{fontsize=\small,baselinestretch=1}
```

### Example

```latex
\begin{codesnippet}
\begin{minted}[frame=single,breaklines]{c}
int main()
{
   printf("Hello, World!");
   return 0;
}
\end{minted}
\caption{My func}\label{lst:my_func}
\end{codesnippet}
```

## Tables 

For the creation of tables it is recommended to use the pack­age `ltablex`, it mod­i­fies the tab­u­larx en­vi­ron­ment to com­bine the fea­tures of the tab­u­larx pack­age (auto-sized columns in a fixed width ta­ble) with those of the longtable pack­age (multi-page ta­bles)

### Example

```latex
\begin{tabularx}{\textwidth}{|l|X|l|} \hline
\textbf{label 2} & \textbf{label 2} & \textbf{label 3} \\ \hline
item 1           & item 2           & item 3           \\ \hline  
item 1           & item 2           & item 3           \\ \hline  
\caption{My table}\label{tbl:my_table}
\end{tabularx}
```

## Referencing

BibLATEX is a com­plete reim­ple­men­ta­tion of the bib­li­o­graphic fa­cil­i­ties pro­vided by LaTeX. For­mat­ting of the bib­li­og­ra­phy is en­tirely con­trolled by LaTeX macros, and a work­ing knowl­edge of LaTeX should be suf­fi­cient to de­sign new bib­li­og­ra­phy and ci­ta­tion styles.

A .bib file will contain the bibliographic information of our document.

### Configuration

```latex
% Use BibTeX instead of Biber and set verbose-trad2 style for references 
\usepackage[backend=bibtex,style=verbose-trad2]{biblatex}
```

### BibTeX format example

```latex
@techreport{techreport,
  author       = {Peter Lambert}, 
  title        = {The title of the work},
  institution  = {The institution that published},
  year         = 1993
}
```

Run BibTeX when compile your document.

```
bibtex [filename]
```
