# automated-proofs

A workspace for formalizing mathematical proofs in Lean 4 using [Aristotle](https://aristotle.harmonic.fun) — Harmonic's automated theorem proving service.

The workflow is human-assisted: a proof paper (markdown) is manually translated into a Lean skeleton, then submitted to Aristotle in iterative rounds until all `sorry` placeholders are filled. Tooling manages the submission/retrieval loop.

## Current proof

**JEPA Learns Influential Features First** — formalizing the result that a depth-L ≥ 2 linear JEPA model trained from small random initialisation learns features in decreasing order of their generalised regression coefficient ρ*, without assuming simultaneous diagonalisability of the input and cross-covariance matrices.

Source: `AutomatedProofs/JEPA.lean`, with helper lemmas in `AutomatedProofs/Lemmas.lean`.

## Setup

Python 3.10+ and a Lean 4 toolchain are required.

```bash
pip install aristotlelib python-dotenv
```

Create `.env` in the project root:
```
ARISTOTLE_API_KEY=arstl_...
```

## Scripts

All scripts run from the project root.

```bash
# See current sorry count and submission status
python scripts/status.py

# Preview what would be packaged before submitting
python scripts/submit.py my_theorems/Paper.md "Fill in the sorries" --dry-run

# Submit to Aristotle
python scripts/submit.py my_theorems/Paper.md "Fill in the sorries"

# When Aristotle emails: download results and annotate the paper
python scripts/retrieve.py
```

Annotated results are written to `reports/<PaperName>_annotated.md` with per-lemma callouts (✓ proved / ◑ proved vacuously / ⚠ needs revision).

## What's automated vs. human-assisted

| Step | Automated |
|---|---|
| Packaging and submitting to Aristotle | ✓ |
| Polling status and downloading results | ✓ |
| Annotating the paper with proof outcomes | ✓ |
| Generating the initial Lean skeleton from a paper | Human |
| Diagnosing remaining sorries between rounds | Human |
| Creating helper lemmas for Mathlib gaps | Human |

## Lean environment

- **Local toolchain**: `leanprover/lean4:v4.29.0-rc6`
- **Aristotle's toolchain**: `leanprover/lean4:v4.28.0` (fixed; returned proofs target this version)
- **Entry point**: `AutomatedProofs.lean` → imports `Basic`, `Lemmas`, `JEPA`
