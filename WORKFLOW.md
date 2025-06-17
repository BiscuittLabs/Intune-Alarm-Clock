# 📃 Git Workflow Guide for Ear Trainer

This guide describes a clean and professional Git workflow for maintaining and versioning the **Ear Trainer** project.

---

## 🏠 Branch Strategy

### Main Branches:

- `main`: Stable production code
- `dev` (optional): Integration branch for tested but unreleased features

### Feature/Task Branches:

- `feature/<name>`: For new features (e.g., `feature/random-note-color`)
- `fix/<name>`: For bug fixes (e.g., `fix/sampler-load-delay`)

---

## 🌟 Daily Development Flow

### 1. Start with the Latest Code

```bash
git checkout main
git pull origin main
```

### 2. Create a New Branch

```bash
git checkout -b feature/your-feature-name
```

### 3. Make Changes and Commit

```bash
git add .
git commit -m "🖌️ Add feature description"
```

### 4. Push to GitHub

```bash
git push -u origin feature/your-feature-name
```

### 5. Open a Pull Request

- Base branch: `main`
- Compare branch: your feature
- Describe your change clearly

### 6. Merge the Pull Request

- Use "Squash and Merge" to keep history clean
- Delete the branch after merge

### 7. Update Local and Clean Up

```bash
git checkout main
git pull origin main
git branch -d feature/your-feature-name
```

---

## 🔖 Tagging Releases

Use [semantic versioning](https://semver.org/): `MAJOR.MINOR.PATCH`

- `v0.1.0`: Initial working version
- `v0.2.0`: Adds new features
- `v1.0.0`: First stable release

### Create and Push a Tag

```bash
git tag v0.2.0
git push origin v0.2.0
```

Then go to **GitHub → Releases** to draft a new release for that tag.

---

## ✅ Commit Message Style

- ✏️ `Add support for custom soundfonts`
- ⚒️ `Fix sampler crashing on missing file`
- 🔄 `Refactor engine initialization`
- 💡 `Improve note randomization logic`

Use clear, meaningful messages that explain what and why.

---

## 🚀 Bonus Commands

| Task                 | Command                             |
| -------------------- | ----------------------------------- |
| See all branches     | `git branch -a`                     |
| Delete remote branch | `git push origin --delete <branch>` |
| See commit history   | `git log --oneline --graph --all`   |
| Undo last commit     | `git reset --soft HEAD~1`           |

---

Stay clean, consistent, and collaborative ✨

Happy coding! ✨

