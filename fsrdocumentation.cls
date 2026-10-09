% --- Dokumentenklasse für die IT-Dokumentation des FSR --- %
% Basis der Fachschaftsprotokolle ist die Die Dokumentklasse "scrareprt". Die Einstellungen in der Reihnefolge:
% fontsize: Schriftgröße
% paper: Papierformat
% pagesize: Papierformat im PDF ("auto" überträgt das Papierformat aus der Option "paper" auf diese Option).
% parskip: Setzt bei neuen Absätzen einen etwas größeren Abstand zum vorherigen Abschnitt, statt die Zeile einzurücken (ähnlich zu Microsoft Word),
% DIV: Steuert die sogenannte "Satzspiegelberechnung". Diese kontrolliert, wie groß das Verhältnis zwischen Randbereich und Textbereich ist.
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{fsrdocumentation}
\LoadClass[fontsize=11pt, parskip=half, DIV=12]{scrreprt}
\KOMAoptions{paper=a4,pagesize=auto}

% --- Packages --- %
\RequirePackage{minted} % Syntax-Highlighting über Pygments (benötigt latexminted)
\RequirePackage{tcolorbox}
\RequirePackage{fsrbase} % Paket, welches default optionen für alle Dokumente des FSR enthält (z.B. Farben, Standard-Pakete oder ein Befehl fürs Logo)

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
