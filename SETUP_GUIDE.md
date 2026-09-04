# Setting up your Site Dashboard (GitHub-backed)

This turns your site into something you can update yourself — logo, hero
photo, About photo and text, homepage Featured Project cards (and their
order), and your project list — without touching code, from one
token-protected dashboard.

The dashboard saves changes as real commits to this project's own GitHub
repository, using a Personal Access Token you create once. There's no
separate database to sign up for.

You'll need about 10 minutes and a (free) GitHub account.

---

## Step 1 — Push this project to GitHub, as a **public** repo

The live site reads its data straight from `raw.githubusercontent.com`
without logging in, so the repository needs to be public (this only exposes
your portfolio's own content and images — nothing more sensitive than
what's already visible on your live site).

```
git init
git add .
git commit -m "Initial commit"
```

Then create a new **public** repository on github.com and push:

```
git remote add origin https://github.com/YOUR_USERNAME/YOUR_REPO.git
git branch -M main
git push -u origin main
```

## Step 2 — Create a fine-grained Personal Access Token

1. On github.com, go to **Settings → Developer settings → Personal access
   tokens → Fine-grained tokens → Generate new token**.
2. **Repository access**: choose "Only select repositories" and pick the
   repo you just pushed. Don't choose "All repositories."
3. **Permissions → Repository permissions → Contents**: set to
   **Read and write**. Leave everything else at its default (no access).
4. Generate the token and copy it somewhere safe — GitHub only shows it once.

> **Why fine-grained, and why scoped to just this repo:** this token is
> what the dashboard uses to log in and save your changes — whoever holds
> it can push commits to whatever it's scoped to. A fine-grained token
> limited to this one repository's Contents means a leaked token can only
> ever touch your portfolio's data and images. A classic token with full
> `repo` scope would expose every other repository you own too — never use
> one of those here.

## Step 3 — Plug your repo details into both files

Open **`admin-dashboard.html`** in a text editor, find near the top of the
`<script>` block:
```js
var GITHUB_OWNER = 'PASTE_YOUR_GITHUB_OWNER_HERE';
var GITHUB_REPO = 'PASTE_YOUR_GITHUB_REPO_HERE';
var GITHUB_BRANCH = 'main';
```
Replace `GITHUB_OWNER`/`GITHUB_REPO` with your GitHub username and the repo
name (leave `GITHUB_BRANCH` as `main` unless you pushed to a different
branch).

Then open **`yogesh-portfolio.html`** (your live site), search for
`PASTE_YOUR_GITHUB`, and paste the same two values in there too.

Commit and push both files:
```
git add admin-dashboard.html yogesh-portfolio.html
git commit -m "Configure CMS repo details"
git push
```

## Step 4 — Open the dashboard

1. Open `admin-dashboard.html` in your browser (or its hosted URL, if you
   host it somewhere — see below).
2. Paste your Personal Access Token from Step 2 and log in.
3. You'll land on **Site Settings** — from there:
   - **Site Settings**: upload a new logo, hero photo, or About-page photo
     — each shows a live preview before you save, and a **Reset to
     default** button if you ever want to go back to the original design.
     There's also an **About page text** card for the headline, tagline,
     and bio paragraphs — **this only affects the mobile/phone view**; the
     desktop About page's text is part of the artwork and can't be changed
     from here.
   - **Featured Projects**: pick up to 6 projects for the homepage's
     Featured Projects section, using the ↑/↓ buttons to set their order.
     Any of the 6 card positions you don't fill keeps its original design.
   - **All Projects**: add, edit, or delete projects. Each one has a
     **Thumbnail** (required — shown on the card) and an optional separate
     **Project file** (PNG, JPEG, or PDF — shown when someone opens the
     project; leave it blank to just reuse the thumbnail everywhere), a
     category, a description, a Tools Used list, and a **Pin to top**
     checkbox (pinned projects sort to the front of "All Projects").

Every save is a real commit to your repository. The live site picks it up
automatically — usually within a few minutes (GitHub's content delivery
network caches briefly before a change is visible to your site's visitors,
so don't expect it to be instant).

---

## What this dashboard can and can't change

The decorative background artwork, the desktop hero section's layout, the
desktop About page's headline and bio text, and the "Professional
Experience" job history are baked into the page's artwork rather than being
simple fields — those still need a code change. There's also a separate,
unrelated `HERO` text block (name/kicker/headline/intro) that controls the
*homepage's* mobile hero wording — that's still a code-only edit too (see
`README.md`'s "mobile view" section); it's not the same thing as the About
page text above.

Everything listed in Step 4 above (logo, hero photo, About photo + mobile
text, the 6 Featured Project cards and their order, and your full project
list) **is** fully self-service from here on.

---

## Where to host these files

- **Netlify** or **Vercel** — drag-and-drop `yogesh-portfolio.html`, get a
  free URL in seconds.
- **GitHub Pages** — enable Pages on the same repo you just pushed.
- Your own domain, if you have one.

The site's HTML can be hosted anywhere — only `data/site-data.json` and the
`assets/uploads/` folder need to live in the GitHub repo; the dashboard
commits there directly no matter where the site itself is hosted.

Keep `admin-dashboard.html` somewhere you don't publicly link to from your
site's navigation — the token protects it regardless, but there's no reason
to advertise where it lives.

---

## Notes on how this works

- **Security**: every save from this dashboard is a real commit to your
  public GitHub repository, made using the token you paste in — that token
  grants direct write access to your repo, so treat it like a password to
  your code, not like an old-fashioned CMS password. It's kept only in this
  browser tab's session storage (cleared when you log out or close the
  tab), never written into either HTML file. **Log out when you're done
  editing, and regenerate the token on GitHub immediately if you ever
  suspect it leaked.**
- **Images**: uploads are automatically resized and compressed before
  saving, so they stay small. PDFs are stored as-is; keep them under a few
  MB for best performance.
- **Staleness**: the live site fetches `data/site-data.json` from GitHub's
  raw-content CDN, which caches briefly (typically a few minutes) — if a
  save doesn't show up immediately on the live site, give it a few minutes
  and refresh.
- **Undo**: because every save is a git commit, your full edit history is
  just your repo's commit log — you can always look at (or revert to) an
  earlier version of `data/site-data.json` from GitHub itself.
