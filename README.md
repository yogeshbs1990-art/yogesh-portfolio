# Yogesh Salunkhe — Portfolio Site

Open this whole folder in VS Code (**File → Open Folder…**) to see everything
together. There's no build step — each `.html` file is fully self-contained
and can be opened directly in a browser (right-click → "Open with Live
Server", or just double-click the file).

## Previewing it on your own PC

Double-click **`start-local.bat`**. It serves this folder at
<http://localhost:8000> and opens the portfolio in your browser; close the
black window to stop it. If neither Python nor Node is installed it just
opens the page directly instead, which works fine for looking at the site.

## Files in this folder

| File | What it is |
|---|---|
| `start-local.bat` | **Double-click to preview locally.** Starts a small web server for this folder and opens the site. |
| `yogesh-portfolio.html` | **Your live site.** The full portfolio — home, about, and projects pages in one file. This is what you upload/host. |
| `admin-dashboard.html` | **Your Site Dashboard.** Token-protected CMS for updating the logo, hero photo, About photo/text, Featured Project cards (and their order), and your project list — without touching code. Don't publicly link to this from your site's navigation. |
| `data/site-data.json` | The CMS's data file, read live by `yogesh-portfolio.html` and written by `admin-dashboard.html` via the GitHub API — this is what makes a dashboard save show up on the live site. |
| `SETUP_GUIDE.md` | Step-by-step setup instructions — start here if this is your first time connecting the dashboard. |

## Before anything works live

Both `yogesh-portfolio.html` and `admin-dashboard.html` need your GitHub
repo's owner/name pasted in, plus a Personal Access Token entered at the
dashboard's login screen (not stored in either file). In VS Code, use
**Find in Files** (`Cmd+Shift+F` / `Ctrl+Shift+F`) and search for
`PASTE_YOUR_GITHUB` — it'll show you the two spots (one per file) where the
owner/repo go. Full details are in `SETUP_GUIDE.md`.

## The mobile view

Below 760px wide the site switches to a phone layout. The desktop design is a
fixed 1366px illustration with text baked into it, which can't reflow, so on
phones the artwork is cropped to a decorative band at the top of each page and
the content underneath is rebuilt as real, readable HTML — with a fixed header
and a hamburger menu.

Two things in `yogesh-portfolio.html` control how it looks. Search for
`MOBILE VIEW` to find them, both near the bottom of the file:

- **`ART_BANDS`** — which slice of each page's artwork shows as the band, as
  `[x, y, width, height]` in artboard units (home is 1366×4250, about is
  1366×950). Nudge the `y` and `height` numbers until the band frames the part
  of the illustration you want.
- **`HERO`** — the name, kicker, headline and intro paragraph shown on phones.
  The desktop hero is vector artwork, so it can't be reused; these are plain
  strings you can edit freely.

To check your changes, open the site with `start-local.bat`, press `F12`, and
click the phone icon in the top-left of the DevTools panel to simulate a
phone screen.

## What's editable from the dashboard vs. what needs a code change

The dashboard (`admin-dashboard.html`) can change: the logo, the hero photo,
the About page photo and mobile-only text (headline/tagline/bio), the 6
homepage Featured Project cards and their order, and your full project list
(add/edit/delete, a thumbnail plus an optional separate PDF/image project
file, category, tools used, pin-to-top flag).

The decorative background artwork, the desktop hero/About sections' baked-in
text, and the "Professional Experience" job history on the About page are
baked into the site's artwork rather than being simple fields — those still
need me to make a code change if you want to update them. The `HERO` object
mentioned below (the homepage's *mobile* hero wording) is also still a
code-only edit, separate from the dashboard's About-page text fields.
