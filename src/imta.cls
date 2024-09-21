\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{imta}[2014/08/16 IMTA Beamer class based on Metropolis]

\RequirePackage{etoolbox}

% Give some space 
\newtoggle{imta@defense}
\togglefalse{imta@defense}
\DeclareOption{defense}{\toggletrue{imta@defense}}

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{beamer}}

\ProcessOptions\relax
\LoadClass{beamer}

\usetheme{metropolis}

% Metropolis theme customization %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\setbeamercolor{normal text}{bg=white}% Change background color to white to match figures

\metroset{
  numbering=fraction, % Display frame number as a fraction
  progressbar=frametitle, % Adds progress bar below each frame title
  progressbar=foot, % Adds progress bar at the bottom of each frame
  block=fill, % Fill block environments with color
  titleformat frame=smallcaps, % Frame titles in small caps
  sectionpage=none, % Removes section slides
} 


% Packages %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%https://tex.stackexchange.com/a/165016/38244
\hypersetup{
  colorlinks,
  citecolor=imta-blue,
  linkcolor=.,
}

% Turns off slide numbering and progress bars for slides in the appendix
\RequirePackage{appendixnumberbeamer}

% Fix warning added by appendixnumberbeamer:
% Token not allowed in a PDF string (Unicode):
% (hyperref)	removing `\translate'.
\renewcommand{\appendixname}{\texorpdfstring{\translate{Appendix}}{Appendix}}

% Subfigures
\RequirePackage{subcaption}

% Path to figures
\graphicspath{{figures/}}

\RequirePackage[export]{adjustbox}

% Tables
\RequirePackage{booktabs} % Fancy tables
\RequirePackage{adjustbox} % Resizing tables

% Font size
\RequirePackage{relsize}

% Template customization %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Sections
\setbeamertemplate{section in toc}[sections numbered]

% Not currently working due to the patching of \beamer@section below; todo.
\setbeamercolor{section number projected}{fg=imta-blue}

% \setbeamertemplate{subsection in toc}[subsections numbered]

\makeatletter
\setbeamertemplate{section page}{%
  \centering
  \begin{minipage}{30em}
    \raggedright
    \usebeamercolor[fg]{section title}
    \usebeamerfont{section title}
    \insertsectionhead\\[-1ex]
    \usebeamertemplate*{progress bar in section page}
    \par
    \ifx\insertsubsectionhead\@empty\else%
      \usebeamercolor[fg]{subsection title}%
      \usebeamerfont{subsection title}%
      \insertsubsectionhead
    \fi
  \end{minipage}
  \par
  \vspace{\baselineskip}
}
\makeatother


\newcounter{sectionpage}

\makeatletter
\patchcmd{\beamer@section}
    {\addtocontents{toc}{\protect\beamer@sectionintoc{\the\c@section}{#2}{\the\c@page}{\the\c@part}{\the\beamer@tocsectionnumber}}}
    {\setcounter{sectionpage}{\insertframenumber}\stepcounter{sectionpage}%
     \addtocontents{toc}{\bfseries\protect\beamer@sectionintoc{\the\c@section}{#2\normalfont\smaller\dotfill\thesectionpage}{\the\c@page}{\the\c@part}{\the\beamer@tocsectionnumber}}}
    {}{}
\makeatother

% Remove 'Figure x' from captions
\setbeamertemplate{caption}{\raggedright\insertcaption\par}

% Show citation numbers inside bibliography
\setbeamertemplate{bibliography item}[text]

% Scriptsize text in footnotes, footcites and bibliography
\renewcommand{\footnotesize}{\scriptsize}

% Colors IMTA
\definecolor{imta-blue}{HTML}{00B8DE}
\definecolor{imta-green}{HTML}{99CC33}
\definecolor{imta-gray}{HTML}{f4f6f5}
\definecolor{imta-darkblue}{HTML}{14223C}

% Draw.io colors
\definecolor{drawio-grey}{HTML}{666666}
\definecolor{drawio-blue}{HTML}{6C8EBF}
\definecolor{drawio-green}{HTML}{82B366}
\definecolor{drawio-orange}{HTML}{D79B00}
\definecolor{drawio-yellow}{HTML}{D6B656}
\definecolor{drawio-red}{HTML}{B85450}
\definecolor{drawio-purple}{HTML}{9673A6}

\colorlet{emph-color}{imta-blue}

\setbeamercolor{alerted text}{fg=imta-blue}
\setbeamercolor{example text}{fg=imta-green}
\setbeamercolor{palette primary}{fg=imta-darkblue,bg=imta-gray}




% Alerted text
\setbeamerfont{alerted text}{series=\bfseries}

% Progress Bar
\makeatletter
\setlength{\metropolis@titleseparator@linewidth}{1pt}
\setlength{\metropolis@progressonsectionpage@linewidth}{1pt}
\setlength{\metropolis@progressinheadfoot@linewidth}{1pt}
\makeatother

% Lists

\setbeamertemplate{itemize item}{\raisebox{0.4\height}{%
  \smaller\color{imta-green}$\blacktriangleright$%
}}
\setbeamertemplate{itemize subitem}{\raisebox{0.4\height}{%
  \smaller\color{imta-green}$\bullet$%
}}
\RequirePackage{fontspec}
\newfontfamily\archer{ArcherLightPro}[
    Path        =   ./Archer-Font/  ,
    Extension   =   .otf            ,
]
\DeclareTextFontCommand{\textnicemono}{\archer}
\setbeamertemplate{enumerate items}{\archer\large\bfseries\color{imta-darkblue}\insertenumlabel.}

% Footnote without a marker
% --------------------------
% https://tex.stackexchange.com/a/30726 
\makeatletter
\def\foottext{\xdef\@thefnmark{}\@footnotetext}
\makeatother

\let\oldfootnoterule\footnoterule
\renewcommand\footnoterule{}



% Title page
% -----------------------------
\setbeamerfont{author}{size=\normalsize}

\setbeamertemplate{institute}{
  \vspace{.5em}
  \insertinstitute%
  \par%
}

\setbeamertemplate{date}{
  \vspace{.75em}
  \insertdate%
  \par%
}

% Logos at bottom of title page
\RequirePackage{calc}
\newlength{\logosize}
\setlength{\logosize}{1.5cm} % default size
\setbeamertemplate{title graphic}{
  \vbox to 0pt {
      \vspace*{\paperheight-\logosize-2em}
      \hfill%
      \inserttitlegraphic%
    }%
  \nointerlineskip%
}




\def\insertjury{}
\newcommand{\jury}[1]{\def\insertjury{%
  \hspace{-2pt}\footnotesize\noindent#1\vspace*{0pt}%
}}


\setbeamertemplate{title page}{
  \begin{minipage}[b][\textheight]{\textwidth}
    \ifx\inserttitlegraphic\@empty\else\usebeamertemplate*{title graphic}\fi
    \vfill%
    \ifx\inserttitle\@empty\else\usebeamertemplate*{title}\fi
    \ifx\insertsubtitle\@empty\else\usebeamertemplate*{subtitle}\fi
    \usebeamertemplate*{title separator}
    \ifx\beamer@shortauthor\@empty\else\usebeamertemplate*{author}\fi
    \ifx\insertinstitute\@empty\else\usebeamertemplate*{institute}\fi
    \ifx\insertdate\@empty\else\usebeamertemplate*{date}\fi
    \vfill%
    \vspace*{1.5em}% Changed from 1mm to 1em
    \ifx\insertjury\@empty\else\insertjury\fi
  \end{minipage}
}

% Bibliography
% -----------------------------
\RequirePackage[
  style=numeric,
  citecounter=true,
  citetracker=true,
  sorting=none,
]{biblatex}

% Clear bibliography fields I do not want to display
\AtEveryCitekey{%
  \clearfield{pages}%
  \clearlist{organization}%
}

\renewcommand*{\bibfont}{\scriptsize}


% https://tex.stackexchange.com/a/386708 (see the edit)
\let\svthefootnote\thefootnote

\DeclareCiteCommand{\cite}
  {\usebibmacro{prenote}}%
  {%  
      \ifciteseen{}{%
          \usebibmacro{citeindex}%
          \let\thefootnote\relax%
          \footnotetext{%
              \mkbibbrackets{\usebibmacro{cite}}%
              \setunit{\addnbspace}
              \printnames{labelname}%
              \setunit{\labelnamepunct}
              \printfield[citetitle]{title}%
              \newunit%
              % ---
              % Prioritize venue fields: shortjournaltitle > journaltitle > series > booktitle
                \ifboolexpr{
                    test {\iffieldundef{shortjournaltitle}}
                }
                {
                    \ifboolexpr{
                        test {\iffieldundef{journaltitle}}
                    }
                    {
                        \ifboolexpr{
                            test {\iffieldundef{series}}
                        }
                        {\printfield{booktitle}}% Fall back to booktitle if no other field is available
                        {\printfield{series}}% Print series if defined
                    }
                    {\printfield{journaltitle}}% Print journaltitle if defined
                }
                {\printfield{shortjournaltitle}}% Print shortjournaltitle if defined
            %}%
              %---
              \newunit%
              \printfield[]{year}%
          }%
          \let\thefootnote\svthefootnote%
      }%
      \autocite{\thefield{entrykey}}%
    }
  {\addsemicolon\space}
  {\usebibmacro{postnote}}

\DeclareCiteCommand{\fcitefootnote}
  {\usebibmacro{prenote}}
  {\usebibmacro{citeindex}%
    \let\thefootnote\relax\footnotetext{%
      \mkbibbrackets{\usebibmacro{cite}}%
      \setunit{\addnbspace}
      \printnames{labelname}%
      \setunit{\labelnamepunct}
      \printfield[citetitle]{title}%
      \newunit%
      % ---
              % Prioritize venue fields: shortjournaltitle > journaltitle > series > booktitle
              \ifboolexpr{
                test {\iffieldundef{shortjournaltitle}}
            }
            {
                \ifboolexpr{
                    test {\iffieldundef{journaltitle}}
                }
                {
                    \ifboolexpr{
                        test {\iffieldundef{series}}
                    }
                    {\printfield{booktitle}}% Fall back to booktitle if no other field is available
                    {\printfield{series}}% Print series if defined
                }
                {\printfield{journaltitle}}% Print journaltitle if defined
            }
            {\printfield{shortjournaltitle}}% Print shortjournaltitle if defined
        %}%
          %---
      \newunit%
      \printfield[]{year}}%
    \let\thefootnote\svthefootnote}
  {\multicitedelim}
  {\usebibmacro{postnote}}

% Properly spaced abbreviations
% -----------------------------
\RequirePackage{xspace}

% Taken from the CVPR's style package (https://stackoverflow.com/a/39363004)

% Add a period to the end of an abbreviation unless there's one
% already, then \xspace.
\makeatletter
\DeclareRobustCommand\onedot{\futurelet\@let@token\@onedot}
\def\@onedot{\ifx\@let@token.\else.\null\fi\xspace}
%
\def\eg{\textit{e.g}\onedot} \def\Eg{\textit{E.g}\onedot}
\def\ie{\textit{i.e}\onedot} \def\Ie{\textit{I.e}\onedot}
\def\cf{\textit{c.f}\onedot} \def\Cf{\textit{C.f}\onedot}
\def\etc{\textit{etc}\onedot} \def\vs{\textit{vs}\onedot}
\def\wrt{w.r.t\onedot} \def\dof{d.o.f\onedot}
\def\etal{\textit{et al}\onedot}
\makeatother