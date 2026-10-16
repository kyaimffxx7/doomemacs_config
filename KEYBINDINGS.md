# Doom Emacs 快捷键整理

> 基于本机配置 `~/.config/doom`（`init.el` / `config.el`）整理。
>
> **重要：本配置没有启用 evil**（`;;evil +everywhere` 被注释），所以：
>
> - 普通编辑使用原生 Emacs 按键；
> - `<leader>` = `C-c`
> - `<localleader>` = `C-c l`
> - `<leader>` 的父 map 是 `mode-specific-map`，因此未被子 map 覆盖的原生 `C-c ...` 依然可用。

---

## 1. 你自定义的快捷键（config.el）

| 快捷键 | 命令 | 说明 |
| --- | --- | --- |
| `C-c r p` | `consult-ripgrep` | 全局 ripgrep 搜索 |
| `C-c c f` | `lsp-format-buffer` | LSP 格式化当前缓冲 |
| `C-c c r` | `lsp-rename` | LSP 重命名 |
| `C-c c a` | `lsp-execute-code-action` | LSP 代码操作 |

### Corfu 补全弹窗（`corfu-map`，仅在弹窗激活时生效）

| 快捷键 | 命令 |
| --- | --- |
| `TAB` / `RET` | `corfu-insert` 确认补全 |
| `C-n` / `C-j` | `corfu-next` 下一个候选 |
| `C-p` / `C-k` | `corfu-previous` 上一个候选 |

> config.el 里同时开启了 `corfu-auto`、`corfu-popupinfo-mode`、`org-mode` 下的 `corfu-mode`。

---

## 2. 全局快捷键（非 leader）

| 快捷键 | 命令 | 说明 |
| --- | --- | --- |
| `C-;` | `embark-act` | 对光标处对象执行 Embark 动作 |
| `C-'` | `imenu` | 跳转到当前缓冲的符号 |
| `C-=` | `er/expand-region` | 逐步扩大选区 |
| `C-S-r` | `vertico-repeat` | 重放上一次 Vertico 搜索 |
| `C-x b` | `persp-switch-to-buffer` | 切换当前 workspace 的 buffer |
| `C-x B` | `switch-to-buffer` | 切换所有 buffer |
| `C-x 4 b` | `switch-to-buffer-other-window` | 在另一窗口打开 buffer |
| `C-x C-b` | `ibuffer` | 打开 ibuffer |
| `C-x K` | `doom/kill-this-buffer-in-all-windows` | 在所有窗口关闭当前 buffer |
| `C-x p` | `+popup/other` | 切换到其它弹出窗口 |
| ``C-` `` | `+popup/toggle` | 切换弹出窗口 |
| `C-~` | `+popup/raise` | 提升弹出窗口 |
| `<f9>` | `+treemacs/toggle` | 开关 treemacs 侧栏 |
| `<C-f9>` | `treemacs-find-file` | 在侧栏定位当前文件 |

---

## 3. Leader 前缀（`C-c`）

### `C-c` 直接命令

| 快捷键 | 命令 | 说明 |
| --- | --- | --- |
| `C-c e` | `+eval/line-or-region` | 求值当前行/选区 |
| `C-c a` | `embark-act` | Embark 动作（vertico 提供） |
| `C-c C-f` | (fold 前缀) | 代码折叠，见下 |
| `C-c l` | (localleader) | 局部 leader，见第 4 节 |
| `C-c !` | (checkers 前缀) | 检查器 |

### `C-c c` — code（代码）

| 快捷键 | 命令 | 说明 |
| --- | --- | --- |
| `C-c c c` | `compile` | 编译 |
| `C-c c C` | `recompile` | 重新编译 |
| `C-c c d` | `+lookup/definition` | 跳到定义 |
| `C-c c D` | `+lookup/references` | 查找引用 |
| `C-c c e` | `+eval/buffer-or-region` | 求值 buffer/选区 |
| `C-c c E` | `+eval/region-and-replace` | 求值并替换 |
| `C-c c f` | `lsp-format-buffer` | **你自定义**：LSP 格式化 |
| `C-c c i` | `+lookup/implementations` | 查找实现 |
| `C-c c k` | `+lookup/documentation` | 查看文档 |
| `C-c c s` | `+eval/buffer-or-region-in-repl` | 发送到 REPL |
| `C-c c t` | `+lookup/type-definition` | 跳到类型定义 |
| `C-c c w` | `delete-trailing-whitespace` | 删除行尾空白 |
| `C-c c W` | `doom/delete-trailing-newlines` | 删除行尾空行 |
| `C-c c x` | `+default/diagnostics` | 错误列表 |
| `C-c c a` | `lsp-execute-code-action` | **你自定义**：LSP 代码操作 |
| `C-c c o` | `lsp-organize-imports` | 整理 import |
| `C-c c r` | `lsp-rename` | **你自定义**：LSP 重命名 |
| `C-c c j` | `consult-lsp-symbols` | 当前 workspace 符号 |
| `C-c c J` | `consult-lsp-symbols (all)` | 所有 workspace 符号 |
| `C-c c l` | `lsp-command-map` | LSP 子前缀（见下） |

**`C-c c l` LSP 子前缀：**

| 快捷键 | 说明 | 快捷键 | 说明 |
| --- | --- | --- | --- |
| `C-c c l ==` | 格式化 buffer | `C-c c l =r` | 格式化 region |
| `C-c c l ga` | workspace 符号 | `C-c c l gd` | 查找声明 |
| `C-c c l gg` | 查找定义 | `C-c c l gi` | 查找实现 |
| `C-c c l gr` | 查找引用 | `C-c c l gt` | 查找类型定义 |
| `C-c c l ge` | 错误列表 | `C-c c l gh` | 调用层级 |
| `C-c c l hh` | 显示光标处符号 | `C-c c l hs` | 签名帮助 |
| `C-c c l hg` | 快速预览符号 | | |
| `C-c c l aa` | 代码操作 | `C-c c l ah` | 高亮符号 |
| `C-c c l al` | lens | `C-c c l ai` | 接受 inlay hint |
| `C-c c l ro` | 整理 import | `C-c c l rr` | 重命名 |
| `C-c c l wd` | 描述 session | `C-c c l wq` | 关闭 server |
| `C-c c l wr` | 重启 server | `C-c c l ws` | 启动 server |
| `C-c c l wD` | 断开连接 | | |
| `C-c c l Fa/Fr/Fb` | 管理 workspace 文件夹 | | |
| `C-c c l TD/Ta/Td/Th/Tl/Ts/Tb/Tf/TS/TL` | 各种开关 | | |
| `C-c c l Gg/Gi/Gr/Gs` | peek 定义/实现/引用/符号 | | |

### `C-c f` — file（文件）

| 快捷键 | 命令 | 说明 |
| --- | --- | --- |
| `C-c f f` | `find-file` | 打开文件 |
| `C-c f F` | `+default/find-file-under-here` | 从当前目录打开文件 |
| `C-c f d` | `dired` | 打开目录 |
| `C-c f r` | `recentf-open-files` | 最近文件 |
| `C-c f R` | `projectile-recentf` | 最近项目文件 |
| `C-c f C` | `doom/copy-this-file` | 复制当前文件 |
| `C-c f D` | `doom/delete-this-file` | 删除当前文件 |
| `C-c f m` | `doom/move-this-file` | 移动/重命名当前文件 |
| `C-c f e` | `doom/find-file-in-emacsd` | 在 emacs.d 中找文件 |
| `C-c f E` | `doom/browse-in-emacsd` | 浏览 emacs.d |
| `C-c f p` | `doom/find-file-in-private-config` | 在私有配置中找文件 |
| `C-c f P` | `doom/open-private-config` | 打开私有配置 |
| `C-c f l` | `locate` | locate 查找 |
| `C-c f u` | `doom/sudo-this-file` | sudo 打开当前文件 |
| `C-c f U` | `doom/sudo-find-file` | sudo 打开文件 |
| `C-c f y` | `+default/yank-buffer-path` | 复制文件路径 |
| `C-c f Y` | `+default/yank-buffer-path-relative-to-project` | 复制相对项目路径 |
| `C-c f x` | `doom/toggle-scratch-buffer` | 开关 scratch buffer |
| `C-c f X` | `doom/switch-to-scratch-buffer` | 切到 scratch buffer |

### `C-c s` — search（搜索）

| 快捷键 | 命令 | 说明 |
| --- | --- | --- |
| `C-c s p` | `+default/search-project` | 搜索项目 |
| `C-c s P` | `+default/search-other-project` | 搜索其它项目 |
| `C-c s .` | `+default/search-project-for-symbol-at-point` | 搜索项目内光标符号 |
| `C-c s b` | `consult-line` | 搜索当前 buffer |
| `C-c s B` | `consult-line-multi (all-buffers)` | 搜索所有 buffer |
| `C-c s s` | `+default/search-buffer` | 搜索 buffer |
| `C-c s S` | `+vertico/search-symbol-at-point` | 搜索光标处符号 |
| `C-c s d` | `+default/search-cwd` | 搜索当前目录 |
| `C-c s D` | `+default/search-other-cwd` | 搜索其它目录 |
| `C-c s e` | `+default/search-emacsd` | 搜索 emacs.d |
| `C-c s i` | `imenu` | 跳转符号 |
| `C-c s I` | `consult-imenu-multi` | 所有 buffer 符号 |
| `C-c s f` | `+lookup/file` | locate 文件 |
| `C-c s l` | `link-hint-open-link` | 打开可见链接 |
| `C-c s L` | `ffap-menu` | 跳转链接 |
| `C-c s m` | `bookmark-jump` | 跳转书签 |
| `C-c s o` | `+lookup/online` | 在线查找 |
| `C-c s O` | `+lookup/online-select` | 在线查找（选择） |
| `C-c s k` | `+lookup/in-docsets` | 本地文档集查找 |
| `C-c s K` | `+lookup/in-all-docsets` | 所有文档集查找 |
| `C-c s t` | `+lookup/dictionary-definition` | 词典 |
| `C-c s T` | `+lookup/synonyms` | 同义词 |

### `C-c i` — insert（插入）

| 快捷键 | 命令 | 说明 |
| --- | --- | --- |
| `C-c i e` | `emoji-search` | 插入 emoji |
| `C-c i f` | `+default/insert-file-path` | 插入文件名 |
| `C-c i F` | `+default/insert-file-path (full)` | 插入完整路径 |
| `C-c i s` | `yas-insert-snippet` | 插入 snippet |
| `C-c i u` | `insert-char` | 插入 Unicode 字符 |
| `C-c i y` | `+default/yank-pop` | 从剪贴板插入 |

### `C-c n` — notes（Org 笔记）

| 快捷键 | 命令 | 说明 |
| --- | --- | --- |
| `C-c n a` | `org-agenda` | 打开 agenda |
| `C-c n n` | `org-capture` | 新建 capture |
| `C-c n N` | `org-capture-goto-target` | 跳到 capture 目标 |
| `C-c n t` | `org-todo-list` | 全局 TODO 列表 |
| `C-c n m` | `org-tags-view` | 标签搜索 |
| `C-c n v` | `org-search-view` | 搜索视图 |
| `C-c n s` | `+default/org-notes-search` | 搜索笔记 |
| `C-c n S` | `+default/org-notes-headlines` | 搜索 agenda 标题 |
| `C-c n f` | `+default/find-in-notes` | 在笔记中找文件 |
| `C-c n F` | `+default/browse-notes` | 浏览笔记 |
| `C-c n l` | `org-store-link` | 存储链接 |
| `C-c n o` | `org-clock-goto` | 跳到正在计时的任务 |
| `C-c n c` | `+org/toggle-last-clock` | 开关上次 clock |
| `C-c n C` | `org-clock-cancel` | 取消当前 clock |
| `C-c n .` | `+default/search-notes-for-symbol-at-point` | 搜索光标符号笔记 |
| `C-c n y` | `+org/export-to-clipboard` | 导出到剪贴板 |
| `C-c n Y` | `+org/export-to-clipboard-as-rich-text` | 导出 RTF 到剪贴板 |

### `C-c o` — open（打开）

| 快捷键 | 命令 | 说明 |
| --- | --- | --- |
| `C-c o b` | `browse-url-of-file` | 用浏览器打开 |
| `C-c o d` | `+debugger/start` | 启动调试器 |
| `C-c o f` | `make-frame` | 新建 frame |
| `C-c o r` | `+eval/open-repl-other-window` | 在另一窗口开 REPL |
| `C-c o R` | `+eval/open-repl-same-window` | 在当前窗口开 REPL |
| `C-c o -` | `dired-jump` | 跳到当前文件所在目录 |
| `C-c o p` | `+treemacs/toggle` | 开关 treemacs |
| `C-c o P` | `treemacs-find-file` | 在 treemacs 中定位文件 |
| `C-c o t` | `+vterm/toggle` | 开关 vterm 弹窗 |
| `C-c o T` | `+vterm/here` | 在当前目录开 vterm |

### `C-c p` — project（项目）

| 快捷键 | 命令 | 说明 |
| --- | --- | --- |
| `C-c p p` | (projectile) | 切换项目 |
| `C-c p f` | (projectile) | 项目内找文件 |
| `C-c p s` | `+default/search-project` | 搜索项目 |
| `C-c p .` | `+default/search-project-for-symbol-at-point` | 搜索项目内符号 |
| `C-c p F` | `doom/find-file-in-other-project` | 其它项目找文件 |
| `C-c p x` | `doom/toggle-project-scratch-buffer` | 项目 scratch buffer |
| `C-c p X` | `doom/switch-to-project-scratch-buffer` | 切到项目 scratch |
| `C-c p 4 ...` | (projectile) | 在其它窗口打开 |
| `C-c p 5 ...` | (projectile) | 在其它 frame 打开 |

> 另：`projectile-mode-map` 把 `C-c p` 接了 `projectile-command-map`。

### `C-c q` — quit/restart（退出/重启）

| 快捷键 | 命令 | 说明 |
| --- | --- | --- |
| `C-c q q` | `save-buffers-kill-terminal` | 退出 |
| `C-c q Q` | `kill-emacs` | 不保存退出 |
| `C-c q K` | `save-buffers-kill-emacs` | 退出（含 daemon） |
| `C-c q f` | `delete-frame` | 关闭当前 frame |
| `C-c q F` | `doom/kill-all-buffers` | 清空所有 buffer |
| `C-c q r` | `doom/restart` | 重启 Emacs |
| `C-c q d` | `+default/restart-server` | 重启 server |
| `C-c q s` | `doom/quicksave-session` | 快速保存会话 |
| `C-c q l` | `doom/quickload-session` | 恢复上次会话 |
| `C-c q S` | `doom/save-session` | 保存会话到文件 |
| `C-c q L` | `doom/load-session` | 从文件恢复会话 |

### `C-c &` — snippets（代码片段）

| 快捷键 | 命令 | 说明 |
| --- | --- | --- |
| `C-c & n` | `yas-new-snippet` | 新建 snippet |
| `C-c & i` | `yas-insert-snippet` | 插入 snippet |
| `C-c & /` | `yas-visit-snippet-file` | 查找 snippet |
| `C-c & r` | `yas-reload-all` | 重载所有 snippet |
| `C-c & c` | `aya-create` | 创建临时模板 |
| `C-c & e` | `aya-expand` | 使用临时模板 |

### `C-c t` — toggle（开关）

| 快捷键 | 命令 | 说明 |
| --- | --- | --- |
| `C-c t l` | `doom/toggle-line-numbers` | 行号 |
| `C-c t w` | `+word-wrap-mode` | 软换行 |
| `C-c t c` | `global-display-fill-column-indicator-mode` | 80 列指示线 |
| `C-c t f` | `flycheck-mode` | Flycheck |
| `C-c t b` | `doom-big-font-mode` | 大字体模式 |
| `C-c t F` | `toggle-frame-fullscreen` | 全屏 |
| `C-c t I` | `doom/toggle-indent-style` | 缩进风格 |
| `C-c t v` | `visible-mode` | visible 模式 |
| `C-c t r` | `read-only-mode` | 只读 |

### `C-c v` — versioning（版本控制 / Magit）

基础：

| 快捷键 | 命令 | 说明 |
| --- | --- | --- |
| `C-c v g` | `magit-status` | 打开 Magit status |
| `C-c v G` | `magit-status-here` | 当前目录的 Magit status |
| `C-c v /` | `magit-dispatch` | Magit 命令面板 |
| `C-c v .` | `magit-file-dispatch` | 当前文件命令面板 |
| `C-c v '` | `forge-dispatch` | Forge 面板 |
| `C-c v B` | `magit-blame-addition` | blame |
| `C-c v C` | `magit-clone` | clone 仓库 |
| `C-c v F` | `magit-fetch` | fetch |
| `C-c v L` | `magit-log-buffer-file` | 当前文件 log |
| `C-c v S` | `magit-stage-file` | stage 文件 |
| `C-c v U` | `magit-unstage-file` | unstage 文件 |
| `C-c v x` | `magit-file-delete` | 删除文件 |
| `C-c v R` | `vc-revert` | 还原文件 |
| `C-c v r` | `+vc-gutter/revert-hunk` | 还原 hunk |
| `C-c v s` | `+vc-gutter/stage-hunk` | stage hunk |
| `C-c v t` | `git-timemachine-toggle` | 时间机器 |
| `C-c v n` / `C-c v p` | `+vc-gutter/next-hunk` / `previous-hunk` | 上下一个 hunk |
| `C-c v y` / `C-c v Y` | 复制远程/主页链接 | |

子前缀：

- `C-c v f` find：`f` 文件、`g` gitconfig、`c` commit、`i` issue、`p` pull request
- `C-c v o` open in browser：`.` 文件/选区、`h` 主页、`r` remote、`c` commit、`i` issue、`p` PR、`I` issues、`P` PRs
- `C-c v l` list：`r` 仓库、`s` 子模块、`i` issues、`p` PRs、`n` 通知
- `C-c v c` create：`r` 初始化仓库、`R` clone、`c` commit、`f` fixup、`i` issue、`p` PR

### `C-c w` — workspaces/windows（工作区/窗口）

| 快捷键 | 命令 | 说明 |
| --- | --- | --- |
| `C-c w c` | `+workspace/new` | 新建工作区 |
| `C-c w C` | `+workspace/new-named` | 新建命名工作区 |
| `C-c w d` | `+workspace/display` | 显示工作区 |
| `C-c w r` | `+workspace/rename` | 重命名 |
| `C-c w k` | `+workspace/kill` | 删除工作区 |
| `C-c w K` | `+workspace/delete` | 删除已保存工作区 |
| `C-c w S` | `+workspace/save` | 保存工作区 |
| `C-c w o` | `+workspace/other` | 切到其它工作区 |
| `C-c w p` / `C-c w n` | 左/右工作区 | |
| `C-c w w` | `+workspace/switch-to` | 切换工作区 |
| `C-c w 1` … `C-c w 9` | 切到工作区 1–9 | |
| `C-c w 0` | 切到最后一个工作区 | |
| `C-c w a` | `doom/quicksave-session` | 自动保存会话 |
| `C-c w s` / `C-c w l` | 保存 / 加载会话 | |
| `C-c w u` / `C-c w U` | `winner-undo` / `winner-redo` | 撤销/重做窗口布局 |

### `C-c C-f` — fold（折叠）

| 快捷键 | 命令 | 说明 |
| --- | --- | --- |
| `C-c C-f C-f` | `+fold/toggle` | 开关折叠 |
| `C-c C-f C-u` | `+fold/open` | 展开 |
| `C-c C-f C-d` | `vimish-fold-delete` | 删除折叠 |
| `C-c C-f C-a C-f` | `+fold/close-all` | 全部折叠 |
| `C-c C-f C-a C-u` | `+fold/open-all` | 全部展开 |
| `C-c C-f C-a C-d` | `vimish-fold-delete-all` | 删除所有折叠 |

---

## 4. Local leader（`C-c l`）— 按模式区分

### Org mode（`org-mode-map`）

| 快捷键 | 命令 | 说明 |
| --- | --- | --- |
| `C-c l t` | `org-todo` | 切换 TODO 状态 |
| `C-c l T` | `org-todo-list` | TODO 列表 |
| `C-c l q` | `org-set-tags-command` | 设置标签 |
| `C-c l o` | `org-set-property` | 设置属性 |
| `C-c l e` | `org-export-dispatch` | 导出 |
| `C-c l '` | `org-edit-special` | 编辑代码块 |
| `C-c l ,` | `org-switchb` | 切换 org buffer |
| `C-c l .` | `consult-org-heading` | 跳转标题 |
| `C-c l /` | `consult-org-agenda` | 搜索 agenda |
| `C-c l n` | `org-store-link` | 存链接 |
| `C-c l h` | `org-toggle-heading` | 切换标题 |
| `C-c l i` | `org-toggle-item` | 切换列表项 |
| `C-c l x` | `org-toggle-checkbox` | 切换 checkbox |
| `C-c l I` | `org-id-get-create` | 创建 ID |
| `C-c l A` | `org-archive-subtree-default` | 归档 |
| `C-c l #` | `org-update-statistics-cookies` | 更新统计 |
| `C-c l *` | `org-ctrl-c-star` | |
| `C-c l -` | `org-ctrl-c-minus` | |
| `C-c l @` | `org-cite-insert` | 插入引用 |
| `C-c l f` | `org-footnote-action` | 脚注 |
| `C-c l k` | `org-babel-remove-result` | 清除 babel 结果 |
| `C-c l K` | `+org/remove-result-blocks` | 清除所有结果块 |
| `C-c l a` | attachments 子前缀 | `a` 附件、`f` 找文件、`l` 链接、`n` 新建、`o` 打开、`r` reveal、`s`/`S` 等 |
| `C-c l b` | tables 子前缀 | `a` 对齐、`c` 建表、`s` 排序、`r` 重算，`d`/`i`/`t` 子前缀 |
| `C-c l c` | clock 子前缀 | `i` 开始、`o` 结束、`c` 取消、`g` 跳转、`l` 上次、`r` 重算等 |
| `C-c l d` | date/deadline | `d` deadline、`s` schedule、`t`/`T` 时间戳 |
| `C-c l g` | goto 子前缀 | `g` 跳转、`c` clock、`i` id、`r` refile 位置、`x` capture |
| `C-c l l` | links 子前缀 | `l` 插链接、`s` 存链接、`d` 删链接、`t` 开关显示、`y` yank 等 |
| `C-c l P` | publish 子前缀 | `a` 全部、`f` 当前文件、`p`/`P` 项目、`s` sitemap |
| `C-c l r` | refile 子前缀 | `r` refile、`f` 到文件、`o` 到其它窗口、`v` 到可见区等 |
| `C-c l s` | tree/subtree | `d` 剪切、`h`/`l` 升降级、`j`/`k` 上下移、`n` 窄化、`s` sparse tree、`S` 排序 |
| `C-c l p` | priority 子前缀 | `p` 设置、`u`/`d` 升降 |

**Org-agenda（`org-agenda-mode-map`）：** `C-c l t` todo、`q` 标签、`r` refile、`c` clock 子前缀、`d` date 子前缀、`p` priority 子前缀。

### Markdown（`markdown-mode-map`）

| 快捷键 | 命令 | 说明 |
| --- | --- | --- |
| `C-c l '` | `markdown-edit-code-block` | 编辑代码块 |
| `C-c l o` | `markdown-open` | 打开 |
| `C-c l p` | `markdown-preview` | 预览 |
| `C-c l e` | `markdown-export` | 导出 |
| `C-c l i` | insert 子前缀 | `T` 目录、`i` 图片、`l` 链接、`1`–`6` 标题、`C` 代码块、`b` 加粗、`e` 斜体、`t` 表格等 |
| `C-c l t` | toggle 子前缀 | `e` 数学、`f` 代码高亮、`i` 图片、`l` URL、`m` 标记、`w` wiki、`x` checkbox |

### Nix（`nix-mode-map`）

| 快捷键 | 命令 | 说明 |
| --- | --- | --- |
| `C-c l b` | `nix-build` | 构建 |
| `C-c l s` | `nix-shell` | 进入 shell |
| `C-c l r` | `nix-repl-show` | REPL |
| `C-c l f` | `nix-update-fetch` | 更新 fetch |
| `C-c l u` | `nix-unpack` | 解包 |
| `C-c l o` | `+nix/lookup-option` | 查找 option |

### Rust（`rustic-mode-map`）

- `C-c l b` 构建子前缀：`b` cargo build、`c` check、`C` clippy、`r` run、`f` fmt、`t` test、`B` bench、`d`/`D` doc、`n` new、`o` outdated、`a` audit
- `C-c l t` 测试子前缀：`a` 全部测试、`t` 当前测试

### Emacs Lisp（`emacs-lisp-mode-map` / `lisp-interaction-mode-map`）

| 快捷键 | 命令 | 说明 |
| --- | --- | --- |
| `C-c l b` | `+emacs-lisp/change-working-buffer` | 设置工作 buffer |
| `C-c l m` | `macrostep-expand` | 展开宏 |
| `C-c l d f` / `C-c l d F` | edebug 开/关 | 调试 |
| `C-c l e b` | `eval-buffer` | 求值 buffer |
| `C-c l e d` | `eval-defun` | 求值 defun |
| `C-c l e e` | `eval-last-sexp` | 求值表达式 |
| `C-c l e r` | `eval-region` | 求值选区 |
| `C-c l e l` | `load-library` | 加载库 |
| `C-c l g f` / `g v` / `g l` | `find-function` / `find-variable` / `find-library` | 跳转 |

### C/C++（`c-mode-map` / `c++-mode-map`）

| 快捷键 | 命令 | 说明 |
| --- | --- | --- |
| `C-c l lp` | `ccls-preprocess-file` | 预处理文件 |
| `C-c l lf` | `ccls-reload` | 重载 cache & ccls |
| `C-c l ct` | `+cc/eglot-ccls-inheritance-hierarchy` | 类型继承层级 |

### Dired（`dired-mode-map`）

| 快捷键 | 命令 | 说明 |
| --- | --- | --- |
| `C-c l h` | `dired-omit-mode` | 隐藏 `.` 开头的文件 |
| `C-c C-e` | `wdired-change-to-wdired-mode` | 进入可编辑的 wdired |

### Smerge（`smerge-mode-map`）

`C-c l n` 下一个冲突、`p` 上一个、`r` resolve、`a` keep all、`b` keep base、`l`/`o` keep lower、`m`/`u` keep upper、`E` ediff、`R` refine、`C-m` keep current、`=` 子前缀比较。

---

## 5. 模式内快捷键（非 leader）

### Vertico / minibuffer（`vertico-map`）

| 快捷键 | 命令 | 说明 |
| --- | --- | --- |
| `DEL` | `vertico-directory-delete-char` | 删除目录字符 |
| `C-;` | `embark-act` | 对候选执行动作 |
| `C-c C-;` | `embark-export` | 导出候选 |
| `C-c C-l` | `embark-collect` | 收集候选到 buffer |
| `C-c C-e` | `+vertico/embark-export-write` | 导出为可写 buffer |
| `M-A` | `marginalia-cycle` | 切换 marginalia 视图 |

### Treemacs

| 快捷键 | 命令 |
| --- | --- |
| `<f9>` / `<C-f9>` | 开关侧栏 / 定位当前文件 |
| `C-c o p` / `C-c o P` | 同上（通过 leader） |

### Magit（`magit-mode-map`）

| 快捷键 | 命令 |
| --- | --- |
| `q` / `Q` | `+magit/quit` / `+magit/quit-all` |
| `gr` / `gR` | 刷新 / 全部刷新 |
| `]` / `[` | 下一个 / 上一个 section 兄弟 |
| `gz`（status） | 刷新 |
| `gd`（diff） | 跳到 diffstat |

### Dired

| 快捷键 | 命令 |
| --- | --- |
| `C-c C-e` | 进入 wdired 可编辑模式 |
| `C-c l h` | 隐藏 dotfiles |

### Ibuffer

| 快捷键 | 命令 |
| --- | --- |
| `q` | `kill-current-buffer` |

### Vterm（`vterm-mode-map`）

| 快捷键 | 命令 |
| --- | --- |
| `C-q` | `vterm-send-next-key`（把下一个键发给终端） |

### Flycheck 错误列表（`flycheck-error-list-mode-map`）

| 快捷键 | 命令 |
| --- | --- |
| `C-n` / `j` | 下一个错误 |
| `C-p` / `k` | 上一个错误 |
| `RET` | 跳到错误处 |

### Undo / Redo

| 快捷键 | 命令 |
| --- | --- |
| `C-_` | 撤销 |
| `M-_` | 重做 |
| `C-M-_` | 全部重做 |
| `C-x r u` | 保存 undo 会话 |
| `C-x r U` | 恢复 undo 会话 |

---

## 6. 附：本配置启用的模块

- **completion**: `corfu +orderless`、`vertico +icons`
- **ui**: `doom`、`doom-dashboard`、`hl-todo`、`modeline`、`ophints`、`popup +defaults`、`treemacs`、`vc-gutter +pretty`、`vi-tilde-fringe`、`workspaces`
- **editor**: `file-templates`、`fold`、`format +onsave`、`snippets`、`whitespace +guess +trim`、`word-wrap`
- **emacs**: `dired`、`electric`、`ibuffer`、`tramp`、`undo`、`vc`
- **term**: `vterm`
- **checkers**: `syntax`（flycheck）
- **tools**: `eval +overlay`、`lookup`、`lsp +lsp-ui`、`magit`、`pdf`、`tree-sitter`
- **lang**: `cc +lsp`、`emacs-lisp`、`markdown`、`nix`、`org +pretty`、`rust +lsp`、`sh`
- **config**: `default +bindings +smartparens`

> 未启用 evil，所以没有 `SPC`/`g`/`z` 等 Vim 风格按键。
