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
(setq doom-font (font-spec :family "Maple Mono NF CN" :size 20))

;; 隐藏窗口标题栏（GNOME/GTK 下的窗口装饰）
;; 用 `undecorated-round' 可保留圆角，去掉下面这行则用直角。
(add-to-list 'default-frame-alist '(undecorated-round . t))
(add-to-list 'default-frame-alist '(undecorated . t))
;; 对已经存在的 frame 立即生效（config.el 加载时首帧可能已创建）
(when (display-graphic-p)
  (set-frame-parameter nil 'undecorated-round t)
  (set-frame-parameter nil 'undecorated t))

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

;;;; Soft wrap
(setq-default fill-column 80)
;; Soft wrap with visual indicators
(global-visual-line-mode 1)
(global-display-fill-column-indicator-mode 1)
;; Customize indicator
(setq display-fill-column-indicator-character ?\u2502)
(set-face-foreground 'fill-column-indicator "#4a4a4a")

;; ;; Images display in org mode
(after! org
  ;; auto display inline images
  (setq org-startup-with-inline-images t)
  ;; more format and zoom
  (setq org-image-actual-width nil)
  (setq org-display-remote-inline-images 'download)
  ;; Enable corfu in org-mode
  (add-hook 'org-mode-hook #'corfu-mode)
  ;; Better completion settings for Org
  (setq org-completion-use-ish t)  ; Fuzzy completion for tags/properties
  ;; Optional: Enable specific completions
  (setq org-use-property-inheritance t)
  (add-hook 'org-mode-hook
            (lambda ()
              (visual-line-mode 1)
              (adaptive-wrap-prefix-mode 1))))
(add-hook 'org-mode-hook #'org-display-inline-images)
;;
;; Set up super-save：空闲 / 窗口失焦 / 切换 buffer 时自动保存
(use-package! super-save
  :demand t
  :config
  ;; 注意：这些变量必须在 `super-save-mode' 之前设置，
  ;; 因为 idle 定时器是在启用模式时根据它们创建的。
  (setq super-save-auto-save-when-idle t    ; 空闲时自动保存
        super-save-idle-duration 10         ; 空闲 10 秒后保存
        super-save-when-focus-lost t        ; 窗口失焦（鼠标移出/切到别的程序）时保存
        super-save-when-buffer-switched t   ; 切换 buffer 时保存
        super-save-silent t                 ; 静默保存，不刷回显区
        super-save-remote-files nil         ; 不自动保存 TRAMP 远程文件
        super-save-exclude '("\\.gpg$" "\\.age$")) ; 排除加密文件
  (super-save-mode +1))
;;
;; ;; Set up corfu
(after! corfu
  (setq corfu-auto t
        corfu-auto-prefix 2
        corfu-auto-delay 0.2
        corfu-cycle t
        corfu-quit-at-boundary 'separator
        corfu-quit-no-match 'separator
        corfu-preview-current t
        corfu-preselect 'prompt
        corfu-on-exact-match 'insert
        corfu-popupinfo-delay '(0.5 . 0.2))
  (global-corfu-mode 1)
  (corfu-popupinfo-mode 1))

;;
;; ===================
;; LSP Configurations
;; ===================
;;
;; Generic LSP setup
(after! lsp-mode
  (setq lsp-inlay-hint-enable t
        lsp-idle-delay 0.5
        lsp-completion-provider :capf
        lsp-auto-guess-root nil
        lsp-enable-folding nil
        lsp-enable-snippet nil
        lsp-enable-symbol-highlighting nil
        lsp-enable-text-document-color nil
        lsp-completion-enable-additional-text-edit nil
        ;; Fix content modified errors
        lsp-enable-file-watchers nil
        lsp-response-timeout 10
        lsp-enable-on-type-formatting nil
        lsp-enable-file-notifications nil
        lsp-enable-suggest-on-release-modifiers nil
        lsp-enable-links nil
        lsp-keep-workspace-alive nil
        lsp-restart 'auto-restart
        lsp-file-watch-threshold 2000)

  (add-hook! 'lsp-mode-hook #'lsp-inlay-hints-mode)

  ;;;; Rust
  (setq lsp-rust-analyzer-cargo-watch-command "clippy"
        lsp-rust-analyzer-proc-macro-enable t
        lsp-rust-analyzer-cargo-load-out-dirs-from-check t

        ;; Import settings
        lsp-rust-analyzer-import-granularity "module"
        lsp-rust-analyzer-import-group "std"
        lsp-rust-analyzer-import-prefix "crate"

        ;; Inlay hints
        lsp-rust-analyzer-display-chaining-hints t
        lsp-rust-analyzer-display-parameter-hints t
        lsp-rust-analyzer-display-lifetime-elision-hints-enable "skip_trivial"
        lsp-rust-analyzer-display-closure-return-type-hints t

        lsp-rust-all-features t
                                        ; lsp-rust-analyzer-server-display-inlay-hints t
        lsp-rust-analyzer-diagnostics-disabled '["unresolved-proc-macro"]
        lsp-rust-analyzer-exclude-dirs '[".git" "target"])

  ;;;; C/C++
  (add-to-list 'lsp-language-id-configuration
               '(c-mode . "c"))
  (add-to-list 'lsp-language-id-configuration
               '(c++-mode . "cpp"))

  (setq lsp-clients-clangd-executable "clangd"
        lsp-clients-clangd-args '("--background-index"
                                  "--clang-tidy"
                                  "--header-insertion=iwyu"
                                  "--log=error"
                                  "--compile-commands-dir=."
                                  "--completion-style=detailed"
                                  "--header-insertion-decorators=0"
                                  "--header-insertion=never"
                                  "--pch-storage=memory"
                                  "-j=4"))
  ;; auto format and LSP for C/C++
  (add-hook 'c-mode-hook #'lsp-deferred)
  (add-hook 'c++-mode-hook #'lsp-deferred)


  (after! lsp-ui
    (setq lsp-ui-doc-enable t           ; 启用文档悬浮
          lsp-ui-doc-show-with-cursor t
          lsp-ui-doc-show-with-mouse t
          lsp-ui-doc-position 'at-point
          lsp-ui-doc-delay 0.6           ; 延迟显示时间
          lsp-ui-doc-max-height 40       ; 最大高度
          lsp-ui-doc-max-width 120

          lsp-ui-doc-offset 2

          ;; sideline settings
          lsp-ui-sideline-enable nil
          lsp-ui-sideline-show-diagnostics nil
          lsp-ui-sideline-show-hover nil))
  ;;
  ;; ;; Rust LSP setup
  (after! rustic
    (setq rustic-rustfmt-path "rustfmt"
          rustic-rustfmt-args '("--edition" "2024")
          rustic-cargo-path "cargo"
          rustic-lsp-server 'rust-analyzer
          rustic-format-on-save nil
          rustic-cargo-check t
          ;; Reduce conflicts with LSP
                                        ; rustic-analyzer-command '("rust-analyzer")
          rustic-format-trigger-marker nil))
                                        ; (add-hook 'rustic-mode-hook #'lsp-deferred))

  (setq lsp-lens-enable nil  ; Disable code lenses if you don't use them
        lsp-headerline-breadcrumb-enable nil  ; Can be distracting
        lsp-modeline-code-actions-enable nil))  ; Reduces modeline clutter

;;
;;
;; =======================
;; Additional Keybindings
;; =======================
;; ;; global ripgrep
(map! :leader
      "r p" #'consult-ripgrep)

;; Corfu keybindings
(map! :map corfu-map
      "TAB" #'corfu-insert
      "RET" #'corfu-insert
      "C-n" #'corfu-next
      "C-p" #'corfu-previous
      "C-j" #'corfu-next
      "C-k" #'corfu-previous)

(map! :leader
      :desc "LSP Format" "c f" #'lsp-format-buffer
      :desc "LSP Rename" "c r" #'lsp-rename
      :desc "LSP Actions" "c a" #'lsp-execute-code-action)

;; ===================
;; Additional Development Settings
;; ===================

;; Better compilation experience
(setq compilation-scroll-output 'first-error)

;; Code formatting
(after! cc-mode
  (setq c-default-style "linux"
        c-basic-offset 4))

;; Tree-sitter enhancements
(after! treesitter
  (setq treesit-language-source-alist
        '((rust . ("https://github.com/tree-sitter/tree-sitter-rust"))
          (c . ("https://github.com/tree-sitter/tree-sitter-c"))
          (cpp . ("https://github.com/tree-sitter/tree-sitter-cpp")))))

;; DAP (Debug Adapter Protocol) setup for future debugging
(after! dap-mode
  (setq dap-auto-configure-features '(breakpoints console))
  (dap-ui-mode 1)
  (dap-ui-controls-mode 1)

  ;; Register debuggers
  (require 'dap-gdb-lldb)
  (require 'dap-codellens))
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;; Alternatively, use `C-h o' to look up a symbol (functions, variables, faces,
;; etc).
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.
