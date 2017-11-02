                                        ; package --- Summary

;;; Commentary:
;;; latex classes

;;; Code:

(add-to-list 'org-latex-classes
             '("handout"
               "\\documentclass{tufte-handout}
  \\usepackage{color}
  \\usepackage{amssymb}
  \\usepackage{amsmath}
  \\usepackage{gensymb}
  \\usepackage{nicefrac}
  \\usepackage{units}"
               ("\\section{%s}" . "\\section*{%s}")
               ("\\subsection{%s}" . "\\subsection*{%s}")
               ("\\paragraph{%s}" . "\\paragraph*{%s}")
               ("\\subparagraph{%s}" . "\\subparagraph*{%s}")))

(add-to-list 'org-latex-classes
             '("tuftebook"
               "\\documentclass{tufte-book}\n
  \\usepackage{color}
  \\usepackage{amssymb}
  \\usepackage{gensymb}
  \\usepackage{nicefrac}
  \\usepackage{units}"
               ("\\section{%s}" . "\\section*{%s}")
               ("\\subsection{%s}" . "\\subsection*{%s}")
               ("\\paragraph{%s}" . "\\paragraph*{%s}")
               ("\\subparagraph{%s}" . "\\subparagraph*{%s}")))




(add-to-list 'org-latex-classes
             '("my-letter"
               "\\documentclass[a4paper,10pt,DIV=9]\{scrlttr2\}
  \\usepackage[english]{babel}
  \[DEFAULT-PACKAGES]
  \[PACKAGES]
  \[EXTRA]"))

(setq org-koma-letter-default-class "my-letter")




(provide 'org_latex_classes)
;;; org_latex_classes.el ends here
