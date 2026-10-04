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
\RequirePackage{fsrbase} % Paket, welches default optionen für alle Dokumente des FSR enthält (z.B. Farben, Standard-Pakete oder ein Befehl fürs Logo)

% -- Befehle -- %
% Definiere "maketitle" neu, um eigenes Layout zu verwenden

% Hilfskommando, welches eine Variable nimmt und einen Fehler in den Logs ausgibt, wenn diese vom Protokollanten nicht gesetzt wurde
\newcommand{\Checkrequiredmacro}[1]{%
  \@ifundefined{#1}{
    \ClassError{fsrprotocol}{Makro \expandafter\string\csname#1\endcsname\space ist nicht definiert}{Bitte definiere \expandafter\string\csname#1\endcsname\space vor \string\begin{document}.}
}{}
}

\renewcommand{\maketitle}{%
	\begin{titlepage}
		\centering

		\fsrlogo[6cm]
		\vspace{1em}

		\LARGE \textbf{Dokumentation zur technischen Infrastruktur des Fachschaftsrats aller Physikstudiengänge} \\
		\vfill

		\normalsize
		von Jannik Zenker
	\end{titlepage}
}
