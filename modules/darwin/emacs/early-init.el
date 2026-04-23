;;; early-init.el --- Early initialisation -*- lexical-binding: t -*-

;;; Commentary:
;; Runs before init.el, before package and UI initialisation.
;; We use this for performance-sensitive settings and to disable package.el
;; in favour of Elpaca.

;;; Code:

;; Defer garbage collection during startup; restored after init.
(setq gc-cons-threshold most-positive-fixnum)
(add-hook 'emacs-startup-hook
          (lambda ()
            (setq gc-cons-threshold (* 16 1024 1024))))

;; Required for lsp-mode's plist-based deserialisation, which is faster than
;; the default hash-table approach. Must be set before lsp-mode is compiled.
;; If you change this, delete and reinstall lsp-mode for it to take effect.
;; See: https://emacs-lsp.github.io/lsp-mode/page/performance/
(setenv "LSP_USE_PLISTS" "true")

;; Prevent package.el loading packages — Elpaca takes over.
(setq package-enable-at-startup nil)

;; Inhibit frame resizing during startup (avoids visual flicker).
(setq frame-inhibit-implied-resize t)

;; Disable UI elements before they can be drawn.
;; Note: we keep the menu bar on macOS since it's native and expected.
(setq default-frame-alist
      '((tool-bar-lines . 0)
        (vertical-scroll-bars . nil)
        (horizontal-scroll-bars . nil)
        (ns-transparent-titlebar . t)
        (ns-appearance . dark)))

;;; early-init.el ends here

;; Local Variables:
;; no-byte-compile: t
;; no-native-compile: t
;; no-update-autoloads: t
;; End:
