# jepa-learning-order

Lean 4 formalization of the feature learning order of a depth-L linear JEPA model under small random initialization. Part of the [lean-workspace](https://github.com/davidcagoh/lean-workspace) methodology workspace.

## Result

In a depth-$L$ linear JEPA model trained by gradient flow under small random initialization, features are learned in order of $\rho^*$ — the effective signal-to-noise strength of each feature direction. Concretely, the critical times $\tilde t_r^*$ at which feature $r$ becomes detectable obey the ordering implied by $\rho^*$ at leading order in $\varepsilon$, with the leading Laurent term $\varepsilon$-independent and ordering entering at the $n=1$ term. The main theorem `JEPA_dynamics_ordering` in `JepaLearningOrder/JEPA.lean` makes this precise.

**Status.** 12pp paper draft at `my_theorems/paper.tex`. The Lean body of `JEPA_dynamics_ordering` is sorry-free. Two named sorries remain inside the helper `bernoulli_laurent_bound`: `h_gronwall` (Picard-Lindelöf + Grönwall + hitting-time comparison) and `h_laurent` (Littwin 2024 Thm 4.5). Both are standard ODE/Laurent facts that informal learning-theory papers leave implicit; they are treated as named axioms under the CompCert convention and documented in the paper appendix.

## Repository structure

| Path | Role |
|---|---|
| `JepaLearningOrder/JEPA.lean` | Main theorem — `JEPA_rho_ordering` |
| `JepaLearningOrder/Lemmas.lean` | Supporting lemmas (Grönwall, PD bounds) |
| `JepaLearningOrder/BootstrapLemmas.lean` | Sub-lemmas decomposing `bootstrap_consistency` |
| `JepaLearningOrder/OffDiagHelpers.lean` | Off-diagonal bridging lemmas |
| `JepaLearningOrder/GronwallIntegral.lean` | Grönwall integral machinery |
| `my_theorems/paper.tex` | LaTeX paper (14pp) |
| `my_theorems/paper_draft.md` | Theorem spec submitted to Aristotle |
| `literature/` | Reference PDFs |
| `requests/` | Aristotle submission prompts |
| `results/` | Aristotle result tarballs |

## Commands

```bash
lake build
lake build JepaLearningOrder.JEPA

python ../stochastic-proofs-handbook/scripts/status.py
python ../stochastic-proofs-handbook/scripts/submit.py my_theorems/paper_draft.md "Fill in the sorries"
python ../stochastic-proofs-handbook/scripts/retrieve.py [project-id]
```

## Setup

```bash
pip install aristotlelib pathspec python-dotenv
# API key in lean-workspace/.env — no per-project .env needed
lake build
```

Lean toolchain: `leanprover/lean4:v4.28.0` · Mathlib: `v4.28.0` · Shared cache: `../.lean-packages/`
