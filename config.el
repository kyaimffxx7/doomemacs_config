;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
;; (setq user-full-name "John Doe"
;;       user-mail-address "john@doe.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-symbol-font' -- for symbols
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;;
;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:
;;
;;(setq doom-font (font-spec :family "Fira Code" :size 12 :weight 'semi-light)
;;      doom-variable-pitch-font (font-spec :family "Fira Sans" :size 13))
;;
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-tokyo-night)

;; Font size
(setq doom-font (font-spec :family "JetBrainsMono Nerd Font" :size 20))

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type 'relative)
(global-display-line-numbers-mode +1)
(setq display-line-numbers-excluded-modes
      '(pdf-view-mode
        nov-mode
        image-mode))

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/Orgs/")

(marginalia-mode t)
;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `after!' block, otherwise Doom's defaults may override your settings. E.g.
;;
;;   (after! PACKAGE
;;     (setq x y))
;;
;; The exceptions to this rule:
;;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look up their documentation).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; ;; Reader for epub
(add-to-list 'auto-mode-alist '("\\.epub\\'" . nov-mode))

;; ;; Images display in org mode
(after! org
  ;; auto display inline images
  (setq org-startup-with-inline-images t)
  ;; more format and zoom
  (setq org-image-actual-width nil)
  (setq org-display-remote-inline-images 'download))
(add-hook 'org-mode-hook #'org-display-inline-images)
;;
;; ;; Set up super-save
(use-package super-save
  :config
  (super-save-mode 1)
  (setq
   super-save-auto-save-when-idle t
   super-save-idle-duration 30
   super-save-remote-files nil
   super-save-triggers '(focus-out-hook switch-buffer-hook)))
;;
;; ;; Set up company
(setq company-idle-delay 0.2)
(setq company-minimum-prefix-length 1)
;;
;; ===================
;; LSP Configurations
;; ===================
;;
;; Generic LSP setup
(after! lsp-mode
  (setq lsp-inlay-hint-enable t)
  (add-hook! 'lsp-mode-hook #'lsp-inlay-hints-mode))

(after! lsp-ui
  (setq lsp-ui-doc-enable t           ; 启用文档悬浮
        lsp-ui-doc-position 'float
        lsp-ui-doc-delay 0.5           ; 延迟显示时间
        lsp-ui-doc-max-height 40       ; 最大高度
        lsp-ui-doc-max-width 120))

(setq lsp-idle-delay 0.5)
(setq lsp-completion-provider :capf)
;;
;; ;; Rust LSP setup
(use-package! rustic
  :config
  ;; 设置 rust-analyzer 路径（默认自动查找）
  (setq rustic-rustfmt-path "rustfmt")
  (setq rustic-cargo-path "cargo")
  (setq rustic-lsp-server 'rust-analyzer)  ; 明确指定 LSP 服务器
                                        ; (setq rustic-format-on-save t)
  ;; LSP 配置
  (add-hook 'rustic-mode-hook #'lsp-deferred))  ; 延迟启动 LSP
;;
;; ;; Clangd LSP setup
(after! lsp-mode
  (add-to-list 'lsp-language-id-configuration
               '(c-mode . "c"))
  (add-to-list 'lsp-language-id-configuration
               '(c++-mode . "cpp"))

  (setq lsp-clients-clangd-executable "clangd")
  (setq lsp-clients-clangd-args '("--background-index"
                                  "--clang-tidy"
                                  "--header-insertion=iwyu"
                                  "--log=error"
                                  "--compile-commands-dir=."
                                  "--completion-style=detailed"))
  ;; auto format
  (add-hook 'c-mode-hook #'lsp))
;;
;;
;; =======================
;; Additional Keybindings
;; =======================
;; ;; global ripgrep
(map! :leader
      "r p" #'consult-ripgrep)

(map! :map company-active-map
      "TAB" #'company-complete-selection)
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;; Alternatively, use `C-h o' to look up a symbol (functions, variables, faces,
;; etc).
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.
