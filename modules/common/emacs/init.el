;;; -*- lexical-binding: t; -*-

(defun mqnr/apply-theme (theme)
  "Disable active themes and load THEME (a symbol).
When called interactively, prompt for THEME with completion."
  (interactive
   (list (intern (completing-read "Apply custom theme: "
                                  (mapcar #'symbol-name
                                          (custom-available-themes))))))
  (mapc #'disable-theme custom-enabled-themes)
  (load-theme theme t))

(defun mqnr/reload-theme-from-default-json ()
  (interactive
   (mqnr/load-theme-from-json (expand-file-name "theme.json" user-emacs-directory))))

(defun mqnr/load-theme-from-json (file)
  "Read JSON FILE and apply settings. Do nothing if FILE does not exist."
  (when (file-exists-p file)
    (require 'json)
    (let* ((json-object-type 'alist)
           (settings (with-temp-buffer
                       (insert-file-contents file)
                       (json-read-from-string (buffer-string)))))
      (dolist (pair settings)
        (let ((key (car pair))
              (value (cdr pair)))
          (pcase key
            ('theme
             (mqnr/apply-theme (intern value)))
            (_
             (set-frame-parameter nil key value)
             (assq-delete-all key default-frame-alist)
             (add-to-list 'default-frame-alist (cons key value)))))))))

;; UI
(use-package emacs
  :config
  (menu-bar-mode -1)
  (tool-bar-mode -1)
  (scroll-bar-mode -1)
  (column-number-mode 1)
  (global-display-line-numbers-mode 1)
  (setq display-line-numbers-type 'relative
        display-line-numbers-width-start t
        display-line-numbers-grow-only t)
  (global-hl-line-mode 1)
  (setq inhibit-startup-screen t
        initial-scratch-message nil)
  (pixel-scroll-precision-mode t)
  (mqnr/load-theme-from-json (expand-file-name "theme.json" user-emacs-directory)))

;; Editing
(use-package emacs
  :config
  (electric-pair-mode 1)
  (show-paren-mode 1)
  (setq show-paren-delay 0)
  (global-auto-revert-mode 1)
  (delete-selection-mode 1)
  (setq-default indent-tabs-mode nil)
  (setq backup-directory-alist '((".*" . "~/.emacs.d/backups")
	auto-save-file-name-transforms `((".*" "~/.emacs.d/auto-saves/" t)))))

;; Other
(use-package emacs
  :config
  ;; Use 'y' or 'n' instead of typing 'yes' or 'no'
  (defalias 'yes-or-no-p 'y-or-n-p))

(use-package indent-bars
  :ensure t
  :hook (prog-mode . indent-bars-mode)
  :custom
  (setq
   indent-bars-color '(highlight :face-bg t :blend 0.6)
   indent-bars-ts-color '(inherit unspecified :blend 0.2)
   indent-bars-pattern "."
   indent-bars-width-frac 0.1
   indent-bars-pad-frac 0.1
   indent-bars-zigzag nil
   indent-bars-color-by-depth nil
   indent-bars-highlight-current-depth nil
   indent-bars-starting-column 0
   indent-bars-display-on-blank-lines 'least
   )
  (indent-bars-treesit-support t)
  (indent-bars-no-descend-lists t)
  (indent-bars-treesit-scope '((python function_definition class_definition for_statement
				       if_statement with_statement while_statement)))
  (indent-bars-treesit-ignore-blank-lines-types '("module")))

(use-package magit
  :ensure t)

(use-package ef-themes
  :ensure t)

(use-package doom-themes
  :ensure t)

(use-package vertico
  :ensure t
  :custom
  (vertico-cycle t)
  :init
  (vertico-mode)
  :config
  (when (< emacs-major-version 31)
    (advice-add #'completing-read-multiple :filter-args
                (lambda (args)
                  (cons (format "[CRM%s] %s"
                                (string-replace "[ \t]*" "" crm-separator)
                                (car args))
                        (cdr args))))))

(use-package savehist
  :init
  (savehist-mode))

(use-package corfu
  :ensure t
  :custom
  ;; Enable cycling for `corfu-next/previous'
  (corfu-cycle t)
  :config
  (setq corfu-auto t
        corfu-quit-no-match 'separator)
  :init
  (global-corfu-mode))

;; [Corfu] A few more useful configurations...
(use-package emacs
  :custom
  ;; Enable indentation+completion using the TAB key.
  ;; `completion-at-point' is often bound to M-TAB.
  (tab-always-indent 'complete)

  ;; Emacs 30 and newer: Disable Ispell completion function.
  ;; Try `cape-dict' as an alternative.
  (text-mode-ispell-word-completion nil))

(use-package orderless
  :ensure t
  :custom
  (completion-styles '(orderless basic))
  (completion-category-overrides '((file (styles basic partial-completion)))))

;; Keybindings
(use-package emacs
  :bind
  ("C-=" . text-scale-increase)
  ("C-+" . text-scale-increase)
  ("C--" . text-scale-decrease)
  ("C-0" . text-scale-adjust)
  ([(control mouse-wheel-up)] . text-scale-increase)
  ([(control mouse-wheel-down)] . text-scale-decrease))

;; Minibuffer configurations
(use-package emacs
  :custom
  ;; Enable context menu. `vertico-multiform-mode' adds a menu in the minibuffer
  ;; to switch display modes.
  (context-menu-mode t)
  ;; Support opening new minibuffers from inside existing minibuffers.
  (enable-recursive-minibuffers t)
  ;; Hide commands in M-x which do not work in the current mode. Vertico
  ;; commands are hidden in normal buffers. This setting is useful beyond
  ;; Vertico.
  (read-extended-command-predicate #'command-completion-default-include-p)
  ;; Do not allow the cursor in the minibuffer prompt
  (minibuffer-prompt-properties
   '(read-only t cursor-intangible t face minibuffer-prompt)))

;; Enable rich annotations using the Marginalia package
(use-package marginalia
  :ensure t
  :bind (:map minibuffer-local-map
         ("M-A" . marginalia-cycle))
  :init
  (marginalia-mode))

(use-package which-key
  :config
  (which-key-mode))

(defconst meow-cheatsheet-layout-gallium
  '((<TLDE> "`"	"~")
    (<AE01> "1"	"!")
    (<AE02> "2"	"@")
    (<AE03> "3"	"#")
    (<AE04> "4"	"$")
    (<AE05> "5"	"%")
    (<AE06> "6"	"^")
    (<AE07> "7"	"&")
    (<AE08> "8"	"*")
    (<AE09> "9"	"(")
    (<AE10> "0"	")")
    (<AE11> "-"	"_")
    (<AE12> "="	"+")
    (<AD01> "b"	"B")
    (<AD02> "l"	"L")
    (<AD03> "d"	"D")
    (<AD04> "c"	"C")
    (<AD05> "v"	"V")
    (<AD06> "j"	"J")
    (<AD07> "y"	"Y")
    (<AD08> "o"	"O")
    (<AD09> "u"	"U")
    (<AD10> "'"	"\"")
    (<AD11> "["	"{")
    (<AD12> "]"	"}")
    (<AC01> "n"	"N")
    (<AC02> "r"	"R")
    (<AC03> "t"	"T")
    (<AC04> "s"	"S")
    (<AC05> "g"	"G")
    (<AC06> "p"	"p")
    (<AC07> "h"	"H")
    (<AC08> "a"	"A")
    (<AC09> "e"	"E")
    (<AC10> "i"	"I")
    (<AC11> "/"	"?")
    (<AB01> "x" "X")
    (<AB02> "q" "Q")
    (<AB03> "m" "M")
    (<AB04> "w"	"W")
    (<AB05> "z"	"Z")
    (<AB06> "k"	"K")
    (<AB07> "f"	"F")
    (<AB08> "'"	"\"")
    (<AB09> ";"	":")
    (<AB10> "."	">")
    (<BKSL> "\\" "|")))

(use-package meow
  :ensure t
  :config
  (setq meow-cheatsheet-layout meow-cheatsheet-layout-gallium)
  (meow-motion-define-key
   '("o" . meow-prev)
   '("a" . meow-next)
   '("<escape>" . ignore))
  (meow-leader-define-key
   ;; Use SPC (0-9) for digit arguments.
   '("1" . meow-digit-argument)
   '("2" . meow-digit-argument)
   '("3" . meow-digit-argument)
   '("4" . meow-digit-argument)
   '("5" . meow-digit-argument)
   '("6" . meow-digit-argument)
   '("7" . meow-digit-argument)
   '("8" . meow-digit-argument)
   '("9" . meow-digit-argument)
   '("0" . meow-digit-argument)
   '("/" . meow-keypad-describe-key)
   '("?" . meow-cheatsheet))
  (meow-normal-define-key
   ;; Expansion
   '("0" . meow-expand-0)
   '("9" . meow-expand-9)
   '("8" . meow-expand-8)
   '("7" . meow-expand-7)
   '("6" . meow-expand-6)
   '("5" . meow-expand-5)
   '("4" . meow-expand-4)
   '("3" . meow-expand-3)
   '("2" . meow-expand-2)
   '("1" . meow-expand-1)
   '("-" . negative-argument)
   '("/" . meow-reverse)

   ;; Movement
   '("o" . meow-prev)
   '("h" . meow-left)
   '("a" . meow-next)
   '("e" . meow-right)

   '("j" . meow-search)
   '("." . meow-visit)

   ;; Expansion
   '("O" . meow-prev-expand)
   '("H" . meow-left-expand)
   '("A" . meow-next-expand)
   '("E" . meow-right-expand)

   '("y" . meow-back-word)
   '("Y" . meow-back-symbol)
   '("u" . meow-next-word)
   '("U" . meow-next-symbol)

   '("n" . meow-mark-word)
   '("N" . meow-mark-symbol)
   '("r" . meow-line)
   '("R" . meow-goto-line)
   '("l" . meow-block)
   '("L" . meow-to-block) ;; Addition
   '("b" . meow-join)
   '("g" . meow-grab)
   '("G" . meow-pop-grab) ;; Addition
   '("f" . meow-swap-grab)
   '("F" . meow-sync-grab)
   '("," . meow-cancel-selection)
   '("<" . meow-pop-selection)

   '("q" . meow-till)
   '("x" . meow-find)

   '("'" . meow-beginning-of-thing)
   '(";" . meow-end-of-thing)
   '("\"" . meow-inner-of-thing)
   '(":" . meow-bounds-of-thing)

   ; editing
   '("t" . meow-clipboard-kill)
   '("s" . meow-change)
   '("S" . meow-replace)
   '("v" . meow-delete)
   '("V" . meow-backward-delete) ;; Addition
   '("m" . meow-clipboard-save)
   '("w" . meow-clipboard-yank)
   '("W" . meow-yank-pop)

   '("d" . meow-insert)
   '("D" . meow-open-above)
   '("c" . meow-append)
   '("C" . meow-open-below)

   '("p" . meow-undo)
   '("P" . meow-undo-in-selection) ;; Changed

   '("z" . open-line)
   '("Z" . split-line)

   '("[" . indent-rigidly-left-to-tab-stop)
   '("]" . indent-rigidly-right-to-tab-stop)

   ; prefix k
   '("ks" . meow-comment)
   '("kv" . meow-start-kmacro-or-insert-counter)
   '("kc" . meow-start-kmacro)
   '("kd" . meow-end-or-call-kmacro)
   ;; ...etc

   ; prefix i
   '("is" . save-buffer)
   '("iS" . save-some-buffers)
   '("it" . meow-query-replace-regexp)
   '("ib" . switch-to-buffer)
   '("ix" . meow-M-x)
   '("ik" . kill-buffer)
   '("if" . find-file)

   ; ignore escape
   '("<escape>" . ignore))
  :init
  (meow-global-mode 1))

(use-package direnv
  :ensure t
  :config
  (direnv-mode))

(use-package eglot
  :hook
  ;; Automatically format before saving in programming modes
  (prog-mode . (lambda ()
                 (add-hook 'before-save-hook #'eglot-format nil t)))
  :config
  ;; This is (at best) tangentially related to Eglot, but whatever
  (setq major-mode-remap-alist
        '((python-mode . python-ts-mode))))

(defun mqnr/eglot-setup (mode server-command)
  "Hook eglot into MODE and register SERVER-COMMAND."
  (add-hook (intern (format "%s-hook" mode)) #'eglot-ensure)
  (with-eval-after-load 'eglot
    (setf (alist-get mode eglot-server-programs) server-command)))

;; Nix
(use-package nix-ts-mode
  :ensure t
  :mode "\\.nix\\'"
  :config
  (mqnr/eglot-setup 'nix-ts-mode '("nixd")))

;; Python
(use-package python-ts-mode
  :mode "\\.py\\'"
  :config
  (mqnr/eglot-setup 'python-ts-mode '("basedpyright-langserver" "--stdio")))

(use-package markdown-mode
  :ensure t
  :mode ("README\\.md\\'" . gfm-mode)
  :init (setq markdown-command "multimarkdown")
  :bind (:map markdown-mode-map
              ("C-c C-e" . markdown-do)))
