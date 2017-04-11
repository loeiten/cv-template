% Provides the nicecv class by Loeiten
%
% Loosely based on Nicola Fontana's tccv
% https://www.sharelatex.com/templates/cv-or-resume/two-column-cv
%
% This program can be redistributed and/or modified under
% the terms of the LaTeX Project Public License, either
% version 1.3 of this license or (at your option) any later
% version. The latest version of this license is in
%   http://www.latex-project.org/lppl.txt
% and version 1.3 or later is part of all LaTeX distributions
% version 2005/12/01 or later.
%

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{nicecv}
              [2017/04/11 v1.0
               Nice Curriculum Vitae]

% Loads coma article class
\LoadClass[10pt]{scrartcl}

% Ignore section numbering
\setcounter{secnumdepth}{-1}

% These packages are needed
% =============================================================================
\RequirePackage{tabularx,graphicx,xcolor,multirow,array,hyperref}
% Needed for ifstrempty
\RequirePackage{etoolbox}
% Set the page geometry
\RequirePackage[hmargin=1.25cm,vmargin=1.25cm]{geometry}
% =============================================================================


% No page numbering
\pagestyle{empty}
% No paragraph indentation
\setlength\parindent{0pt}
% Set fontstyle
\setkomafont{section}{\scshape\Large\mdseries\color[HTML]{801010}}
% Hyperlinks
\definecolor{link}{HTML}{002fff}
\hypersetup{colorlinks,breaklinks,urlcolor=link,linkcolor=link}


% topinfo environment
%
% \begin{topinfo}[profile.jpg]
%     \name{name}
%     \facts{date}
%           {phone}
%           {mail}
%           {address1}
%           {address2}
%     \online{https://github.com/user}
%            {https://linkedin.com/in/user}
% \end{topinfo}
%
% =============================================================================
\newenvironment{topinfo}[1][]
{
    \ifstrempty{#1}
    {
        % Don nothing if empty
    }
    {
    \begin{minipage}{0.15\textwidth}
        \begin{center}
            \includegraphics[width=\linewidth]{#1}
        \end{center}
    \end{minipage}
    }
    %
    \ifstrempty{#1}
    {
        \minipage{\textwidth}
    }
    {
        \minipage{0.8\textwidth}
    }
    \newcommand{\name}[1]{
        \begin{center}
            {\usekomafont{part} ##1}
        \end{center}
    }
    \newcommand{\facts}[5]{
        \begin{center}
            \begin{tabular}{c|c|c|c}
                F{\o}dt &
                \multirow{2}{*}{##2} &
                \multirow{2}{*}{\href{mailto:##3}{##3}} &
                ##4
                \\
                ##1 &
                &
                &
                ##5
            \end{tabular}
        \end{center}
    }
    \newcommand{\online}[2]{
        \begin{center}
            \begin{minipage}{0.40\textwidth}
                \begin{minipage}{0.15\textwidth}
                    \begin{center}
                        \includegraphics[width=\linewidth]{fig/github}
                    \end{center}
                \end{minipage}
                \begin{minipage}{0.60\textwidth}
                    \href{##1}{##1}
                \end{minipage}
            \end{minipage}
            \begin{minipage}{0.40\textwidth}
                \begin{minipage}{0.15\textwidth}
                    \begin{center}
                        \includegraphics[width=\linewidth]{fig/linkedin}
                    \end{center}
                \end{minipage}
                \begin{minipage}{0.60\textwidth}
                    \href{##2}{##2}
                \end{minipage}
            \end{minipage}
        \end{center}
    }
}
{
    \endminipage
    \\
    \vspace{0.2in}
}
% =============================================================================


% Redefine sections
% Draws a line under the section
% =============================================================================
% Difference let and def
% http://tex.stackexchange.com/questions/258/what-is-the-difference-between-let-and-def
\let\oldSection\section
\renewcommand{\section}[2][]{
    \oldSection[#1]{#2}
    \newdimen\raising
    \raising=\dimexpr-0.7\baselineskip\relax
    \vskip\raising\hrule height 0.4pt\vskip-\raising
}
% =============================================================================


% education environment
%
% \begin{education}
%   \entry{year}{degree}{title}{location}{description}
% \end{education}
%
% =============================================================================
\newenvironment{education}[1]
{
    \section{#1}
    % NOTE: Double hash as command is only defined within this environment
    \newcommand{\entry}[5]{
        \begin{tabular}{m{0.25\textwidth}m{0.75\textwidth}}
            \large ##1 & \large {\bfseries ##2}
        \end{tabular}
        \begin{tabular}{m{0.05\textwidth}m{0.95\textwidth}}
            & \textit{{\scshape ##3}} \\
            & \textit{ ##4 } \\
            & \vspace{0.1in} ##5
        \end{tabular}
    }
}
{
    % This is done when the environment closes
    \vspace{0.1in}
    \\
}
% =============================================================================


% work environment
%
% \begin{work}
%   \entry{year}{position}{company}{description}
% \end{work}
%
% =============================================================================
\newenvironment{work}[1]
{
    \section{#1}
    % NOTE: Double hash as command is only defined within this environment
    \newcommand{\entry}[3]{
        \begin{tabular}{m{0.225\textwidth}m{0.75\textwidth}}
            ##1 & {\bfseries ##2 }
        \end{tabular}
        \begin{tabular}{m{0.05\textwidth}m{0.95\textwidth}}
            & \textit{{\scshape ##3}}
        \end{tabular}
    }
}
{
    % Do nothing at the end of this environment
}
% =============================================================================


% awards environment
%
% \begin{awards}
%   \entry{award}{description}
% \end{awards}
%
% =============================================================================
\newenvironment{awards}[1]
{
    \section{#1}
    \newdimen\unbaseline
    \unbaseline=\dimexpr-\baselinestretch\baselineskip\relax
    % NOTE: Double hash as command is only defined within this environment
    \newcommand\entry[2]{
	\textsc{##1} & {\raggedright ##2\medskip\\}\\[\unbaseline]}
    \tabularx{\linewidth}{lX}
}
{
    % End environment by ending the tabular
    \endtabularx
}
% =============================================================================


% others environment
%
% \begin{others}
%   \entry{what}{description}
% \end{others}
%
% =============================================================================
\newenvironment{others}[1]
{
    \section{#1}
    % NOTE: Double hash as command is only defined within this environment
    \newcommand\entry[2]{
	\textsc{##1} &  ##2\\}
    \tabularx{\textwidth}{lX}
}
{
    % End environment by ending the tabular
    \endtabularx
}
% =============================================================================
