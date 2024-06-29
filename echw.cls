%=====================================================================
% echw.cls
% Based on the jhwhw class.
%=====================================================================

%=====================================================================
% Identification
%=====================================================================
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{echw}[2024/06/12 Eytan Chong's Homework Class]

\LoadClass[a4paper, 12pt]{article}

\RequirePackage{fancyhdr}
\RequirePackage[a4paper,width=160mm,top=25mm,bottom=25mm]{geometry}
\RequirePackage{graphicx}
\RequirePackage{empheq}
\RequirePackage{ifthen}

%=====================================================================
% Commands
%=====================================================================

\setlength{\headheight}{15pt}
\lhead{\@author}\chead{\@title}\rhead{\@date}
\lfoot{}\cfoot{\thepage}\rfoot{}
\pagestyle{fancy}

\ifx\pdfoutput\undefined                         %LaTeX
  \RequirePackage[ps2pdf,bookmarks=true]{hyperref}
  \hypersetup{ %
    pdfauthor   = {\@author},
    pdftitle    = {\@title},
    pdfcreator  = {LaTeX with hyperref package},
    pdfproducer = {dvips + ps2pdf}
  }
\else                                            %PDFLaTeX
  \RequirePackage[pdftex,bookmarks=true]{hyperref}
  \hypersetup{ %
    pdfauthor   = {\@author},
    pdftitle    = {\@title},
    pdfcreator  = {LaTeX with hyperref package},
    pdfproducer = {dvips + ps2pdf}
  }
\pdfadjustspacing=1
\fi

\newcounter{ProblemNum}
\newcounter{PartNum}[ProblemNum]
\newcounter{SubPartNum}[PartNum]

\renewcommand{\theProblemNum}{\arabic{ProblemNum}}
\renewcommand{\thePartNum}{\alph{PartNum}}
\renewcommand{\theSubPartNum}{\roman{SubPartNum}}

\newcommand*{\problem}[1]{\stepcounter{ProblemNum}
   \newpage\section*{Problem \theProblemNum. \; #1}}

\newcommand*{\solution}{\subsection*{Solution}}

\renewcommand*{\part}{\stepcounter{PartNum}
  \subsubsection*{Part (\thePartNum)}}
  
\newcommand*{\subpart}{\stepcounter{SubPartNum}\medskip\noindent\textbf{Subpart (\theSubPartNum)}\newline\indent}

\renewcommand{\theenumi}{(\alph{enumi})}
\renewcommand{\labelenumi}{\theenumi}
\renewcommand{\theenumii}{\roman{enumii}}

\numberwithin{equation}{ProblemNum}


%=====================================================================
% Packages
%=====================================================================

\usepackage{accents}
\usepackage{amsmath}
\usepackage{amssymb}
\usepackage{amsthm}
\usepackage{bigstrut}
\usepackage{bm}
\usepackage{booktabs}
\usepackage{caption}
\usepackage{cases}
\usepackage{enumerate}
\usepackage{fbox}
\usepackage{float}
\usepackage{multirow}
\usepackage{parskip}
\usepackage{systeme}
\usepackage{tabularx}
\usepackage[most]{tcolorbox}
\usepackage{varwidth}
\usepackage{xcolor}
\usepackage{xparse}

\usepackage{tikz}
\usetikzlibrary{arrows, intersections, angles, quotes, calc, decorations.markings}

\usepackage{pgfplots}
\pgfplotsset{compat=1.18}
\usepgfplotslibrary{polar, fillbetween}

%=====================================================================
% Custom Definitions
%=====================================================================

% To n Significant Figures
\newcommand*{\tosf}[1]{
\text{ ($#1$ s.f.)}
}

% To n Decimal Places
\newcommand*{\todp}[1]{
\text{ ($#1$ d.p.)}
}

% Reject  
\newcommand*{\reject}[1]{
\qquad \text{(rej. \ensuremath{#1})}
}

% Newton-Raphson Method
\newcommand*{\nrm}[2]{
#1 - \dfrac{#2(#1)}{#2'(#1)}
}

% Inverse Function
\newcommand*{\inv}[1]{
#1^{-1}
}

% Range
\newcommand*{\ran}[1]{R_{#1}}

% Domain
\newcommand*{\dom}[1]{D_{#1}}

% Cases
\newcommand*{\case}[2]{
  \textbf{Case #1: #2}
}

% U-Substitution
\newcommand{\usub}[1]{\tag*{\colorbox{orange!20}{$\begin{aligned}#1\end{aligned}$}}}

% Evaluation of Derivative
\newcommand{\evalder}[2]{\left. #1 \right|_{#2}}

% Evaluation of Integral
\newcommand{\evalint}[3]{\left[#1\right]_{#2}^{#3}}

% Boldface Vectors
\renewcommand{\vec}[1]{\mathbf{#1}}

% Boldface Matrix
\newcommand{\matr}[1]{\bm{#1}}

% 2D Column Vectors
\newcommand*{\cvecii}[2]{\begin{pmatrix} #1 \\ #2 \end{pmatrix}}

% 3D Column Vectors
\newcommand*{\cveciii}[3]{\begin{pmatrix} #1 \\ #2 \\ #3 \end{pmatrix}}

% Dot Product
\def\dotp{\cdot}

% Cross Product
\def\crossp{\times}

% Degree Symbol
\renewcommand{\deg}{^{\circ}}

% Area Operator
\DeclareMathOperator{\area}{Area}

% Volume Operator
\DeclareMathOperator{\volume}{Volume}

% Length Operator
\DeclareMathOperator{\length}{Length}

% Dash
\newcommand*{\dash}{\begin{center}\vspace{1ex}\rule[1ex]{7em}{0.5pt}\end{center}}

% Custom Colours
\colorlet{plotRed}{red!50}
\colorlet{plotBlue}{blue!50}
\colorlet{plotGreen}{green}
\colorlet{plotBlack}{black!50}

% Box for Solutions
\newcommand*{\boxt}[1]{
\begin{center}
	\fbox{\begin{varwidth}{\dimexpr\textwidth-2\fboxsep-2\fboxrule\relax}
		#1
	\end{varwidth}}
\end{center}
}

% Graphs - Two Marks
\def\MarkLt{4pt}
\def\MarkSep{2pt}
\tikzset{
  TwoMarks/.style={
    postaction={decorate,
      decoration={
        markings,
        mark=at position #1 with
          {
              \begin{scope}[xslant=0.2]
              \draw[line width=\MarkSep,white,-] (0pt,-\MarkLt) -- (0pt,\MarkLt) ;
              \draw[-] (-0.5*\MarkSep,-\MarkLt) -- (-0.5*\MarkSep,\MarkLt) ;
              \draw[-] (0.5*\MarkSep,-\MarkLt) -- (0.5*\MarkSep,\MarkLt) ;
              \end{scope}
          }
       }
    }
  },
  TwoMarks/.default={0.5},
}

%=====================================================================
% Adapted from https://github.com/pmichaillat/latex-math/blob/main/math.sty
%=====================================================================

% --- Brackets ---

\newcommand{\bc}[1]{\left\lbrace #1 \right\rbrace} 
\newcommand{\bp}[1]{\left( #1 \right)} 
\newcommand{\bs}[1]{\left[ #1 \right]} 
\newcommand{\abs}[1]{\left\lvert #1 \right\rvert}
\newcommand{\absx}[1]{\lvert #1 \rvert}
\newcommand{\norm}[1]{\left\lVert #1 \right\rVert}
\newcommand{\normx}[1]{\lVert #1 \rVert}
\newcommand{\floor}[1]{\left\lfloor #1 \right\rfloor}
\newcommand{\ceil}[1]{\left\lceil #1 \right\rceil}
\newcommand{\floorx}[1]{\lfloor #1 \rfloor}
\newcommand{\ceilx}[1]{\lceil #1 \rceil}
\newcommand{\of}[1]{{\left( #1 \right)}}

% --- Operators ---

% Sine
\let\oldsin\sin
\RenewDocumentCommand{\sin}{o g}{%
\IfNoValueTF{#2}{\oldsin}%
{\,{\oldsin\IfValueT{#1}{^{#1}}}{\bp{#2}}}}

% Cosine
\let\oldcos\cos
\RenewDocumentCommand{\cos}{o g}{%
\IfNoValueTF{#2}{\oldcos}%
{\,{\oldcos\IfValueT{#1}{^{#1}}}{\bp{#2}}}}

% Tangent
\let\oldtan\tan
\RenewDocumentCommand{\tan}{o g}{%
\IfNoValueTF{#2}{\oldtan}%
{\,{\oldtan\IfValueT{#1}{^{#1}}}{\bp{#2}}}}

% Cosecant
\let\oldcsc\csc
\RenewDocumentCommand{\csc}{o g}{%
\IfNoValueTF{#2}{\oldcsc}%
{\,{\oldcsc\IfValueT{#1}{^{#1}}}{\bp{#2}}}}

% Secant
\let\oldsec\sec
\RenewDocumentCommand{\sec}{o g}{%
\IfNoValueTF{#2}{\oldsec}%
{\,{\oldsec\IfValueT{#1}{^{#1}}}{\bp{#2}}}}

% Cotangent
\let\oldcot\cot
\RenewDocumentCommand{\cot}{o g}{%
\IfNoValueTF{#2}{\oldcot}%
{\,{\oldcot\IfValueT{#1}{^{#1}}}{\of{#2}}}}

% Arcsine
\let\oldarcsin\arcsin
\RenewDocumentCommand{\arcsin}{o g}{%
\IfNoValueTF{#2}{\oldarcsin}%
{\,{\oldarcsin\IfValueT{#1}{^{#1}}}{\bp{#2}}}}

% Arccosine
\let\oldarccos\arccos
\RenewDocumentCommand{\arccos}{o g}{%
\IfNoValueTF{#2}{\oldarccos}%
{\,{\oldarccos\IfValueT{#1}{^{#1}}}{\bp{#2}}}}

% Arctangent
\let\oldarctan\arctan
\RenewDocumentCommand{\arctan}{o g}{%
\IfNoValueTF{#2}{\oldarctan}%
{\,{\oldarctan\IfValueT{#1}{^{#1}}}{\bp{#2}}}}

% Logarithm
\let\oldln\ln
\RenewDocumentCommand{\ln}{g}{%
\IfNoValueTF{#1}{\oldln}%
{\,{\oldln}{\bp{#1}}}}

% Exponential
\let\oldexp\exp
\RenewDocumentCommand{\exp}{g}{%
\IfNoValueTF{#1}{\oldexp}%
{\,{\oldexp}{\bp{#1}}}}

% Indicator
\NewDocumentCommand{\ind}{g}{%
\IfNoValueTF{#1}{\operatorname{\mathbb{1}}}%
{\,\mathbb{1}_{#1}}}

% Trace
\NewDocumentCommand{\tr}{g}{%
\IfNoValueTF{#1}{\operatorname{tr}}%
{\,{\operatorname{tr}}{\bp{#1}}}}

% Determinant
\let\olddet\det
\RenewDocumentCommand{\det}{g}{%
\IfNoValueTF{#1}{\olddet}%
{\,{\olddet}{\bp{#1}}}}

% Variance
\NewDocumentCommand{\var}{o g}{%
\IfNoValueTF{#2}{\operatorname{var}\IfValueT{#1}{_{#1}}}%
{\,{\operatorname{var}\IfValueT{#1}{_{#1}}}{\bp{#2}}}}

% Covariance
\NewDocumentCommand{\cov}{o g}{%
\IfNoValueTF{#2}{\operatorname{cov}\IfValueT{#1}{_{#1}}}%
{\,{\operatorname{cov}\IfValueT{#1}{_{#1}}}{\bp{#2}}}}

% Correlation
\NewDocumentCommand{\corr}{o g}{%
\IfNoValueTF{#2}{\operatorname{corr}\IfValueT{#1}{_{#1}}}%
{\,{\operatorname{corr}\IfValueT{#1}{_{#1}}}{\bp{#2}}}}

% Standard deviation
\NewDocumentCommand{\sd}{o g}{%
\IfNoValueTF{#2}{\operatorname{sd}\IfValueT{#1}{_{#1}}}%
{\,{\operatorname{sd}\IfValueT{#1}{_{#1}}}{\bp{#2}}}}

% Standard error
\NewDocumentCommand{\se}{o g}{%
\IfNoValueTF{#2}{\operatorname{se}\IfValueT{#1}{_{#1}}}%
{\,{\operatorname{se}\IfValueT{#1}{_{#1}}}{\bp{#2}}}}

% Maximum
\let\oldmax\max
\RenewDocumentCommand{\max}{o g}{%
\IfNoValueTF{#2}{\oldmax\IfValueT{#1}{_{#1}}}%
{\,{\oldmax\IfValueT{#1}{_{#1}}}{\bc{#2}}}}

% Supremum
\let\oldsup\sup
\RenewDocumentCommand{\sup}{o g}{%
\IfNoValueTF{#2}{\oldsup\IfValueT{#1}{_{#1}}}%
{\,{\oldsup\IfValueT{#1}{_{#1}}}{\bc{#2}}}}

% Argmax
\DeclareMathOperator*{\argmax}{argmax}

% Minimum
\let\oldmin\min
\RenewDocumentCommand{\min}{o g}{%
\IfNoValueTF{#2}{\oldmin\IfValueT{#1}{_{#1}}}%
{\,{\oldmin\IfValueT{#1}{_{#1}}}{\bc{#2}}}}

% Infimum
\let\oldinf\inf
\RenewDocumentCommand{\inf}{o g}{%
\IfNoValueTF{#2}{\oldinf\IfValueT{#1}{_{#1}}}%
{\,{\oldinf\IfValueT{#1}{_{#1}}}{\bc{#2}}}}

% Argmin
\DeclareMathOperator*{\argmin}{argmin}

% Expectation
\NewDocumentCommand{\E}{o g}{%
\IfNoValueTF{#2}{\operatorname{\mathbb{E}}\IfValueT{#1}{_{#1}}}%
{\,{\operatorname{\mathbb{E}}\IfValueT{#1}{_{#1}}}{\bp{#2}}}}

% Probability
\RenewDocumentCommand{\P}{o g}{%
\IfNoValueTF{#2}{\operatorname{\mathbb{P}}\IfValueT{#1}{_{#1}}}%
{\,{\operatorname{\mathbb{P}}\IfValueT{#1}{_{#1}}}{\bp{#2}}}}

% --- Derivatives ---

% Differential
\renewcommand{\d}[1]{\mathop{\mathrm{d}#1}}

% Ordinary derivative in display
\NewDocumentCommand{\der}{o g g}{%
\dfrac{\mathrm{d}\IfValueT{#1}{^{#1}} #2}{\mathrm{d} #3\IfValueT{#1}{^{#1}}}}

% Ordinary derivative in text
\NewDocumentCommand{\derx}{o g g}{%
\mathrm{d}\IfValueT{#1}{^{#1}} #2/\mathrm{d} #3\IfValueT{#1}{^{#1}}}

% Partial derivative in display
\NewDocumentCommand{\pder}{o g g g}{%
\IfNoValueTF{#4}{\dfrac{\partial\IfValueT{#1}{^{#1}} #2}{\partial #3\IfValueT{#1}{^{#1}}}}%
{\left.\dfrac{\partial\IfValueT{#1}{^{#1}} #2}{\partial #3\IfValueT{#1}{^{#1}}}\right\vert_{#4}}}

% Partial derivative in text
\NewDocumentCommand{\pderx}{o g g g}{%
\IfNoValueTF{#4}{\partial\IfValueT{#1}{^{#1}} #2/\partial #3\IfValueT{#1}{^{#1}}}%
{\left.\partial\IfValueT{#1}{^{#1}} #2/\partial #3\IfValueT{#1}{^{#1}}\right\vert_{#4}}}

% --- Blackboard letters ---

\def\R{\mathbb{R}}
\def\N{\mathbb{N}}
\def\Z{\mathbb{Z}}
\def\Q{\mathbb{Q}}
\def\C{\mathbb{C}}

% --- Caligraphic letters ---

\def\Ac{\mathcal{A}}
\def\Bc{\mathcal{B}}
\def\Cc{\mathcal{C}}
\def\Dc{\mathcal{D}}
\def\Ec{\mathcal{E}}
\def\Fc{\mathcal{F}}
\def\Gc{\mathcal{G}}
\def\Hc{\mathcal{H}}
\def\Ic{\mathcal{I}}
\def\Jc{\mathcal{J}}
\def\Kc{\mathcal{K}}
\def\Lc{\mathcal{L}}
\def\Mc{\mathcal{M}}
\def\Nc{\mathcal{N}}
\def\Oc{\mathcal{O}}
\def\Pc{\mathcal{P}}
\def\Qc{\mathcal{Q}}
\def\Rc{\mathcal{R}}
\def\Sc{\mathcal{S}}
\def\Tc{\mathcal{T}}
\def\Uc{\mathcal{U}}
\def\Vc{\mathcal{V}}
\def\Wc{\mathcal{W}}
\def\Xc{\mathcal{X}}
\def\Yc{\mathcal{Y}}
\def\Zc{\mathcal{Z}}

% --- Greek letters ---

\def\a{\alpha}
\def\b{\beta}
\def\c{\chi}
\def\de{\delta}
\def\D{\Delta}
\def\e{\epsilon}
\def\ve{\varepsilon}
\def\f{\phi}
\def\vf{\varphi}
\def\F{\Phi}
\def\g{\gamma}
\def\G{\Gamma}
\def\h{\eta}
\def\i{\iota}
\def\k{\kappa}
\def\vk{\varkappa}
\def\l{\lambda}
\def\L{\Lambda}
\def\m{\mu}
\def\n{\nu}
\def\o{\omega}
\def\O{\Omega}
\def\p{\psi}
\def\r{\rho}
\def\vr{\varrho}
\def\s{\sigma}
\def\vs{\varsigma}
\def\S{\Sigma}
\def\t{\theta}
\def\vt{\vartheta}
\def\T{\Theta}
\def\u{\upsilon}
\def\U{\Upsilon}
\def\x{\xi}
\def\X{\Xi}
\def\z{\zeta}

% --- Accents ---

\newcommand{\ol}[1]{\overline{#1}}
\newcommand{\oa}[1]{\overrightarrow{#1}}
\newcommand{\ul}[1]{\underline{#1}}
\newcommand{\wh}[1]{\widehat{#1}}
\newcommand{\wt}[1]{\widetilde{#1}}

% --- Complex numbers ---

\renewcommand{\Re}{\operatorname{Re}}
\renewcommand{\Im}{\operatorname{Im}}