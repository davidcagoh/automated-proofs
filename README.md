# jepa-learning-order

**jepa-learning-order** is a Lean 4 formalization project for a theoretical result about the **feature learning order of a depth-2 linear JEPA model under small random initialization**. The repository treats representation learning as an object of formal mathematical study: instead of only reporting the theorem in a paper, it encodes the supporting definitions, lemmas, and proof structure in Lean.

This repository is part of a broader **Stochastic Proofs** workspace, but it should be read as a standalone research artifact. Its purpose is to make a specific learning-theoretic claim precise, inspectable, and mechanically checkable.

| Repository focus | Description |
|---|---|
| Research domain | Representation learning theory and self-supervised learning |
| Central object | A depth-2 linear JEPA model under small random initialization |
| Main goal | Formalize the learning-order result in Lean 4 |
| Technical stack | Lean 4, Mathlib, structured theorem-spec workflow |
| Portfolio value | Shows formal-methods work applied to modern learning theory rather than only classical mathematics |

## What this repository is about

The central claim of the project is that, in a simplified but mathematically tractable JEPA setting, features are not learned arbitrarily. They emerge in a specific order that can be analyzed and proved. The repository exists to formalize that statement carefully enough that the proof structure, supporting lemmas, and assumptions are visible in code rather than remaining only in prose.

That makes this repository different from a generic theorem-proving sandbox. It is a focused formalization of a modern machine-learning theorem, aimed at readers interested in the overlap between **learning theory**, **formal verification**, and **mechanized mathematics**.

## Why it matters

Most machine-learning theory lives entirely in papers and handwritten derivations. By contrast, this project asks what it looks like to turn a learning-theoretic argument into a formal object. That shift matters for at least three reasons.

First, it forces the assumptions of the theorem to become explicit. Second, it reveals exactly where proof complexity lives: in the main result, in helper inequalities, or in bridge lemmas needed to align paper mathematics with library machinery. Third, it demonstrates that proof assistants can be used not only for textbook mathematics, but also for contemporary questions about representation learning.

| Value of the repository | Why it is interesting |
|---|---|
| Formal transparency | The proof structure is inspectable at the level of definitions and lemmas |
| Modern subject matter | The repository formalizes a JEPA-related learning-theory result, not a standard classroom theorem |
| Research workflow | Shows how paper drafts, Lean skeletons, and proof automation can support each other |
| Portfolio signal | Highlights mathematically mature work on AI theory using formal tools |

## Repository structure

The code is organized around the main JEPA theorem and the support machinery needed to state and prove it cleanly.

| Path | Role |
|---|---|
| `JepaLearningOrder/JEPA.lean` | Main proof development for the learning-order result |
| `JepaLearningOrder/Lemmas.lean` | Supporting lemmas used throughout the argument |
| `JepaLearningOrder/OffDiagHelpers.lean` | Bridging helper lemmas for technically awkward intermediate steps |
| `JepaLearningOrder/GronwallIntegral.lean` | Grönwall-style support machinery for the analysis |
| `my_theorems/JEPA_v4_current.md` | Paper draft and theorem specification used to guide the formalization |
| `JepaLearningOrder.lean` | Entry-point file importing modules in dependency order |

## Development workflow

The workflow in this repository is paper-first and theorem-driven. A mathematical specification is written in prose, then translated into a Lean skeleton with explicit proof intent, after which the proof is iteratively completed and refined. This keeps the repository grounded in the actual theorem rather than drifting into disconnected proof experiments.

| Step | Typical command |
|---|---|
| Build the full project | `lake build` |
| Build the main theorem file | `lake build JepaLearningOrder.JEPA` |
| Build support lemmas | `lake build JepaLearningOrder.Lemmas` |
| Check remaining `sorry`s | `python scripts/status.py` |
| Preview a submission | `python scripts/submit.py my_theorems/JEPA_v4_current.md "Fill in all the sorries" --dry-run` |
| Submit the current theorem spec | `python scripts/submit.py my_theorems/JEPA_v4_current.md "Fill in all the sorries"` |
| Retrieve completed results | `python scripts/retrieve.py` |
| Watch in-flight jobs | `python scripts/watch.py` |

## Local setup

The repository is pinned to the Lean and Mathlib environment used by the associated proof workflow so that proofs remain reproducible and easy to verify locally.

```bash
pip install aristotlelib pathspec python-dotenv

echo "ARISTOTLE_API_KEY=arstl_..." > .env
lake build
```

As with the other Lean repositories in this workspace, the project is designed to share a parent-level Mathlib cache.

```bash
mkdir -p ~/lean-projects
cd ~/lean-projects
git clone <this-repo-url>
cd jepa-learning-order
lake build
```

| Environment component | Version |
|---|---|
| Lean toolchain | `leanprover/lean4:v4.28.0` |
| Mathlib | `v4.28.0` |
| Shared package cache | `../.lean-packages/` |

## Reading this repository as a portfolio piece

If you are arriving here from the GitHub profile, the intended takeaway is that this repository showcases a specific kind of technical work: **formalizing contemporary machine-learning theory in a proof assistant**. The important point is not only that the code builds, but that the mathematical narrative is legible. A reader should be able to see what theorem is being pursued, where the main analytical burden lies, and how the repository structure mirrors the proof strategy.

In that sense, **jepa-learning-order** is both a formalization project and a research communication artifact. It presents a learning-theoretic result in a way that is precise enough for mechanization and structured enough for an outside reader to understand.
