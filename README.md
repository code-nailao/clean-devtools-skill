# Clean DevTools Skill

清理 macOS 上 Codex App 启动的 Chrome DevTools MCP 辅助进程。

在 Mac 上使用 Codex App + Chrome DevTools 时，`chrome-devtools-mcp` 有时会持续占用较高内存。这个 skill 提供了一个小脚本：先发送 `TERM`，等待 1 秒，再对仍然匹配的进程发送 `KILL`。

## 安装

在 Codex 里直接说：

```text
帮我安装一下这个 skill：https://github.com/code-nailao/clean-devtools-skill
```

也可以手动克隆到本地 skills 目录：

```bash
git clone https://github.com/code-nailao/clean-devtools-skill.git ~/.codex/skills/clean-devtools
```

也可以用 `skills` CLI 安装：

```bash
npx skills add code-nailao/clean-devtools-skill
```

安装后不一定需要重启整个 Codex App。可以手动刷新技能列表：

1. 按 `⌘K` 或 `⌘⇧P` 打开 Command Menu。
2. 搜索 `Force Reload Skills`，中文界面里可以搜索“技能”或“重新加载”。
3. 选择 `Force Reload Skills`。

最稳妥的测试方式：刷新后开一个新对话，输入 `/clean-devtools`。

## 使用

在 Codex 里输入：

```text
/clean-devtools
```

或者直接说：

```text
清理一下 Codex App 的 Chrome DevTools MCP 进程
```

只查看会匹配哪些进程，不执行清理：

```bash
bash scripts/clean-devtools.sh --dry-run
```

执行清理：

```bash
bash scripts/clean-devtools.sh
```

## 默认清理对象

- `chrome-devtools-mcp`

脚本只会匹配当前用户的进程。

注意：执行清理会断开当前正在使用的 Chrome DevTools MCP 会话，但不会关闭 Chrome 浏览器本身。
