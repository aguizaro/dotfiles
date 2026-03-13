# Team tmux Quick Start Guide

This guide explains **how to use our shared tmux setup** to work faster and more consistently when doing SSH, monitoring, and day‑to‑day Unix work.

You do **not** need to be a tmux or Linux expert. If you can open a terminal, run commands, and SSH into machines, this is enough.

> **Feeling overwhelmed?** tmux is just a tool - it is not required for every task. If you ever need to get something done quickly and tmux feels like too much, press `Cmd + T` to open a new terminal tab and work the way you normally would. Come back to tmux when you're ready.

---

## What tmux is (in plain English)

`tmux` lets you:

* Keep **multiple terminals** inside one window
* Split your screen into panes (side‑by‑side or stacked)
* Disconnect and reconnect **without losing output** (great for SSH)
* Organize work by task instead of by terminal windows

Think of it as a **workspace manager for terminals**.

---

## Core idea of our workflow

We organize work like this:

* **One tmux session per job or context**

  * Example: `activations`, `troubleshooting`, `pepsi-sites`, etc
* **One window (tab) per task/site**

  * Example: `THEA3`, `Lumina`, `Portico`
* **Multiple panes inside a window** for related machines

  * Ping on the left, SSH on the right
  * Jump deeper by splitting again

This keeps things visually organized and easy to return to later.

---

## The Prefix Key (most important thing to learn)

Our tmux prefix key is:

```
Ctrl + a
```

Almost all tmux commands start with this.

You will see instructions written like:

```
Ctrl-a |   (means: hold Ctrl, press a, then press |)
```

---

## Essential tmux commands

These are the only commands you need to type directly into your terminal (outside of tmux). Everything else is done with the prefix key once you're inside.

### Start or attach to a session

```
tmux
```

Starts a new unnamed session. *If you only ever run one session, this is all you need.*

```
tmux new -s activations
```

Starts a new session named `activations`. Use a name that describes your context.

```
tmux attach -t workspace
```

Re-attach to an existing session by name. Short form: `tmux a -t workspace`

```
tmux a
```

Attach to the most recent session (useful when you only have one).

### List sessions

```
tmux ls
```

Shows all running sessions, how many windows each has, and when they were created.

### Kill a session

```
tmux kill-session -t workspace
```

Destroys the session and everything in it. Use when you're fully done with a context.

### Detach from a session (keep it running)

```
Ctrl-a d
```

Leaves tmux but keeps the session alive in the background. Everything keeps running. Re-attach later with `tmux a`.

---

## Windows (tabs)

### Create a new window

```
Ctrl-a c
```

A new window opens at the end.

### Rename the window (recommended)

```
Ctrl-a ,
```

Use short, descriptive names. I like to use site names:

* `Remy`
* `UPSBP`
* `Helios`

This makes switching much easier.

### Switch between windows

**Next / Previous window**

```
Shift + ← / →
```

**Jump directly by number**

```
Ctrl-a 1
Ctrl-a 2
Ctrl-a 3
```

Window numbers are stable and predictable.

---

## Panes (splits inside a window)

### Split vertically (side by side)

```
Ctrl-a |
```

Common use:

* Left pane: ping or logs
* Right pane: SSH session

### Split horizontally (top / bottom)

```
Ctrl-a -
```

Common use:

* Top: primary SSH
* Bottom: deeper SSH hop

### Close a pane

```
Ctrl-a x
```
You will be prompted to confirm.
Enter 'y' for yes

### Swap panes

```
Ctrl-a {
Ctrl-a }
```

Useful for rearranging your layout.

---

## Mouse, scrolling, and copying (macOS friendly)

### Mouse is always ON

You can:

* Click to focus panes
* Resize panes with the mouse
* Scroll using two‑finger trackpad

### Scrolling

* Two‑finger scroll enters scrollback mode
* You can scroll far back in output (up to 200k lines)

### Copying text

1. Scroll to where you want
2. Highlight text with your mouse
3. Release mouse → **text is copied to your clipboard automatically**

Paste normally with:

```
Cmd + v
```

Important behavior:

* Copying **does not jump you back to the bottom**
* You stay where you were scrolling
* Press `Esc` to exit copy mode and return to the live terminal

### How to tell you're in copy mode

The active pane border changes color:

* **Purple** → normal mode (live terminal)
* **Orange** → copy mode (scrolling or selecting)

This makes it obvious when you're no longer seeing live output. Press `Esc` to return.

---

## Searching output

Search is extremely useful for logs and long commands.

### Two ways to search

**`Cmd + F` — terminal-wide search**

Searches all visible content across every pane in the current window. Good for a quick look at what's on screen right now.

**`Ctrl-s` in copy mode (orange border) — per-pane search**

Searches through the full scrollback buffer (up to 200k lines). Much more powerful for digging through log output. Only searches the pane you're currently in — useful when multiple panes are running different things.

### How to use per-pane search (must be in copy mode)

1. Scroll up in the pane you want to search - border turns **orange** when in copy mode
2. Press `Ctrl-s` to start the search
3. Type your search term
4. Press `Enter` to confirm

### Navigate results

* Next match: `n`
* Previous match: `Shift + n`

Press `Esc` to exit and return to the live terminal.

---

## SSH‑heavy workflow (recommended pattern)

A common daily flow:

1. Create a window for a task

   ```
   Ctrl-a c
   Ctrl-a ,   → name it & hit enter
   ```

2. Start a long‑running command (ping, logs)

3. Split vertically

   ```
   Ctrl-a |
   ```

4. SSH into the target machine

5. Split again if needed

   ```
   Ctrl-a -
   ```

6. Keep related machines visible together

If SSH disconnects:

* Scroll up
* Use ↑ arrow to reuse the previous command
* History and output are preserved per pane

---

## Sessions (separating work contexts)

You usually only need one session, but sessions are great for context switching.

### Create a named session

```
tmux new -s activations
```

### Switch sessions

```
tmux attach -t troubleshooting
```

You can also cycle through sessions without leaving tmux:

```
Ctrl-a )    Next session
Ctrl-a (    Previous session
```

> Not commonly needed if you're working in a single session — but handy when you have a few running.



## Things you do NOT need to learn (on purpose)

This setup intentionally avoids:

* Vim‑style keybindings
* Complex pane navigation shortcuts
* Broadcasting commands to all panes
* Fancy status bar scripts

Focus on:

* Windows
* Panes
* Scrolling
* Searching

That alone covers 90% of daily productivity gains.

---

## Mental model to remember

* **Session** = job or context
* **Window** = task or site
* **Pane** = machine or command

If you follow that model, tmux stays simple and predictable.

---

## Quick cheat sheet

```
Ctrl-a c        New window
Ctrl-a ,        Rename window
Shift ← / →     Switch windows
Ctrl-a |        Vertical split
Ctrl-a -        Horizontal split
Ctrl-a x        Close pane
Ctrl-d          Close pane (shell exit)
Ctrl-a s        Search output
n / Shift-n     Next / previous match
Mouse drag      Copy text
Ctrl-a d        Detach session
Ctrl-a ?        Show all key bindings
```

---

## Going further

If you want to explore tmux on your own:

* **Built-in help** — press `Ctrl-a ?` inside tmux to see every available key binding
* **Official wiki** — [github.com/tmux/tmux/wiki](https://github.com/tmux/tmux/wiki)
* **tmux cheat sheet** — [tmuxcheatsheet.com](https://tmuxcheatsheet.com)
* **Man page** — run `man tmux` in your terminal for the full reference

> **Note:** Most online tmux guides use `Ctrl + b` as the prefix — that's the default out of the box. Our config remaps it to `Ctrl + a` (easier to reach). If you're following an external tutorial, mentally swap any `Ctrl-b` you see for `Ctrl-a`.

---

## Final note

This tmux setup is designed for:

* Long SSH sessions
* Distributed Linux environments
* Monitoring + editing + command work

If you use it consistently, it becomes muscle memory fast and removes a ton of terminal friction.

If something feels awkward or confusing, we can change it. All of this is customizable.
