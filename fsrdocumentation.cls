% --- Dokumentenklasse für die IT-Dokumentation des FSR --- %
% Basis der Dokumentation ist die Dokumentklasse "scrreprt". Die Einstellungen in der Reihenfolge:
% fontsize: Schriftgröße
% paper: Papierformat
% pagesize: Papierformat im PDF ("auto" überträgt das Papierformat aus der Option "paper" auf diese Option).
% parskip: Setzt bei neuen Absätzen einen etwas größeren Abstand zum vorherigen Abschnitt, statt die Zeile einzurücken (ähnlich zu Microsoft Word),
% DIV: Steuert die sogenannte "Satzspiegelberechnung". Diese kontrolliert, wie groß das Verhältnis zwischen Randbereich und Textbereich ist.
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{fsrdocumentation}
\LoadClass[fontsize=11pt, parskip=half, DIV=12]{scrreprt}
\KOMAoptions{paper=a4,pagesize=auto}

% Auch \subsubsection nummerieren und ins Inhaltsverzeichnis aufnehmen (Standard bei scrreprt: nur bis \subsection),
% damit Verweise per \autoref auf Unterunterabschnitte die richtige Nummer anzeigen
\setcounter{secnumdepth}{\subsubsectionnumdepth}
\setcounter{tocdepth}{\subsubsectiontocdepth}

% --- Packages --- %
\RequirePackage{minted} % Syntax-Highlighting über Pygments (benötigt latexminted)
\RequirePackage{tcolorbox} % Erstellen von farbigen boxen mit Textinhalt
\RequirePackage{fsrbase} % Paket, welches default optionen für alle Dokumente des FSR enthält (z.B. Farben, Standard-Pakete oder ein Befehl fürs Logo)
\RequirePackage{tabularx} % Bessere Tabellen
\RequirePackage{booktabs} % Schönere horizontale Linien in Tabellen (\toprule, \midrule, \bottomrule)
\RequirePackage{awesomebox} % Hinweisboxen (\notebox, \tipbox, \warningbox, \cautionbox, \importantbox)

% -- Befehle -- %
% Definiere "maketitle" neu, um eigenes Layout zu verwenden
\renewcommand{\maketitle}{%
	\begin{titlepage}
		\centering

		\fsrlogo[6cm]
		\vspace{1em}

		\LARGE \textbf{Dokumentation zur technischen Infrastruktur des Fachschaftsrats aller Physikstudiengänge} \\
		\vfill

		\normalsize
		von Jannik Zenker

		Version: \version
	\end{titlepage}
}

% Hinweisboxen von awesomebox ragen sonst 1em in den rechten Rand: Durch "parskip=half" verlangt KOMA-Script
% in der letzten Zeile eines Absatzes 1em Freiraum. Innerhalb der Boxen wird diese Vorgabe aufgehoben.
\newcommand{\fsr@fixawesomebox}[1]{%
	\expandafter\let\csname fsr@orig@#1\expandafter\endcsname\csname #1\endcsname
	\expandafter\renewcommand\csname #1\endcsname[1]{%
		{\setlength{\parfillskip}{0pt plus 1fil}\csname fsr@orig@#1\endcsname{##1}\par}}%
}
\fsr@fixawesomebox{notebox}
\fsr@fixawesomebox{tipbox}
\fsr@fixawesomebox{warningbox}
\fsr@fixawesomebox{cautionbox}
\fsr@fixawesomebox{importantbox}

% Kommando um schöne Codeblöcke zu erzeugen
\tcbuselibrary{minted, skins, breakable}

% Umgebung für Codeblöcke mit Syntax-Highlighting
% 1. Argument = Optional: Zusätzliche tcolorbox-Optionen (z.B. title={Vorlage})
% 2. Argument: Sprache des Codes (z.B. latex, bash, python)
\newtcblisting{Codeblock}[2][]{%
	listing engine=minted,
	minted language=#2,
	minted options={fontsize=\small, breaklines, tabsize=2, autogobble},
	listing only,
	enhanced,
	breakable,
	colback=fsrgrey!5,
	colframe=fsrgrey,
	coltitle=white,
	fonttitle=\sffamily\bfseries\small,
	boxrule=0.5pt,
	arc=2pt,
	left=6pt,
	right=6pt,
	#1
}

% Neue Umgebung um Konfigurationen schöner darzustellen
\newenvironment{config}
{%
	\begin{tabularx}{\textwidth}{@{}>{\bfseries}p{0.32\textwidth}X@{}}
		}
		{%
	\end{tabularx}
}

% Spezielle Version von "\item" zur Nutzung mit dem "config" environment
% Der Konfigurationsname wird normal dargestellt, 
% während der Wert in mit Monospace-Font dargestellt wird
\newcommand{\configitem}[2]{#1 & \texttt{#2} \\[0.4em]}
