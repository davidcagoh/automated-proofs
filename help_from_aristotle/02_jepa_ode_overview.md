# Aristotle Plan: JEPA ODE Lemmas

**File**: `AutomatedProofs/JEPA.lean`
**Total sorries remaining**: 5 (as of 2026-03-23; JEPA_rho_ordering Parts C/D/E proved)

---

## Dependency Graph

```
Already proved (do not re-prove):
  gradient_projection         ✓  algebraic, local
  critical_time_formula       ✓  existential, local
  critical_time_ordering      ✓  algebraic, local
  preconditioner_integral_    ✓  measure theory, local
    diverges_L1
  gronwall_approx_ode_bound   ✓  Lemmas.lean, job 48ec8df6
  frobenius_pd_lower_bound    ✓  Lemmas.lean, job 48ec8df6
  pd_quadratic_lower_bound    ✓  Lemmas.lean, job 48ec8df6

─────────────────────────────────────────────────────────────────
                         Lean formal deps
─────────────────────────────────────────────────────────────────

  quasiStatic_approx          ←  gronwall_approx_ode_bound (✓)
  (line ~234)

  diagonal_ODE                ←  gradient_projection (✓)
  (line ~288)                    hV_qs  [hypothesis: quasi-static bound]
                                 hoff_diag_small  [hypothesis: offdiag O(ε^{1/L})]

  offDiag_ODE                 ←  gradient_projection (✓)
  (line ~427)                    hV_qs  [hypothesis: quasi-static bound]

  preconditioner_             ←  h_sigma1_lb  [hypothesis: diagonal ODE lower bound]
    integral_bounded
  (line ~461)

  offDiag_bound               ←  gronwall_approx_ode_bound (✓)
  (line ~527)                    h_ode  [hypothesis: offDiag_ODE result]
                                 h_int_bound  [hypothesis: preconditioner_integral_bounded result]

  JEPA_rho_ordering           ←  quasiStatic_approx  (called)
  (line ~627)                 ←  diagonal_ODE  (called; establishes h_ode premise for offDiag_bound)
                              ←  offDiag_ODE  (called; provides offdiag ODE result)
                              ←  preconditioner_integral_bounded  (called; provides integral bound)
                              ←  offDiag_bound  (called; gives |c_{rs}| = O(ε^{1/L}))
                              ←  critical_time_ordering (✓)
                              ←  preconditioner_integral_diverges_L1 (✓)
```

### What "hypothesis" means here

`diagonal_ODE`, `offDiag_ODE`, `preconditioner_integral_bounded`, and `offDiag_bound`
each take their mathematical prerequisites as **explicit hypotheses in their type
signatures** — not as calls to other proved lemmas. This means each is **formally
independent** in Lean: Aristotle can prove any one of them without the others being
proved first.

`JEPA_rho_ordering` is the exception — it formally **calls** all five lemmas in its
proof body, establishing the required hypotheses along the way. It cannot be proved
until all five are proved.

### Logical proof flow inside JEPA_rho_ordering

```
  hWbar_slow, hV_flow_ode, hV_init
          ↓
  quasiStatic_approx  →  quasi-static bound (part A)
          ↓
  diagonal_ODE        →  diagonal ODE lower bound
          ↓
  preconditioner_integral_bounded  →  ∫ P_{rs} du = O(1)
          ↓
  offDiag_ODE         →  offdiag ODE bound
          ↓
  offDiag_bound       →  |c_{rs}(t)| = O(ε^{1/L}) (part B)
          ↓
  critical_time_ordering  →  ordering (part C)
  preconditioner_integral_diverges_L1  →  depth threshold (part D)
  (algebraic)         →  JEPA vs MAE (part E)
```

---

## All Sorries

| # | Lemma | Line | Formally depends on | Logically needs |
|---|---|---|---|---|
| 1 | `quasiStatic_approx` | ~234 | `gronwall_approx_ode_bound` (✓) | — |
| 2 | `diagonal_ODE` | ~288 | (all hypotheses) | quasi-static bound as premise |
| 3 | `offDiag_ODE` | ~427 | (all hypotheses) | quasi-static bound as premise |
| 4 | `preconditioner_integral_bounded` | ~461 | (all hypotheses) | diag ODE lower bound as premise |
| 5 | `offDiag_bound` | ~527 | `gronwall_approx_ode_bound` (✓), (hypotheses) | offDiag_ODE + preconditioner results |
| 6 | `JEPA_rho_ordering` | ~627 | calls all 5 above | all 5 must be proved |

---

## Submission Plan

| Job | Doc | Targets | Tier | Status |
|---|---|---|---|---|
| `7f119cde` | `03_7f119cde_building_blocks.md` | `diagonal_ODE`, `offDiag_ODE`, `preconditioner_integral_bounded` | 1 | COMPLETE_WITH_ERRORS — proved nothing |
| `be5085d7` | `04_be5085d7_hard_lemmas.md` | `quasiStatic_approx`, `offDiag_bound`, `JEPA_rho_ordering` | 1+3 | COMPLETE_WITH_ERRORS — Parts C/D/E proved ✓; A/B partial |
| `96f51b3a` | `05_96f51b3a_request.md` | `diagonal_ODE` | 1 | IN_PROGRESS |
| `2e29172e` | `06_2e29172e_request.md` | `offDiag_ODE` | 1 | IN_PROGRESS |
| `d103e486` | `07_d103e486_request.md` | `preconditioner_integral_bounded` | 1 | IN_PROGRESS |
| `6e5b685c` | `08_6e5b685c_request.md` | `quasiStatic_approx` | 1 | IN_PROGRESS |
| `cd27691a` | `09_cd27691a_request.md` | `offDiag_bound` | 1 | IN_PROGRESS |

### Changes since first round

- `JEPA_rho_ordering` Parts (C), (D), (E) ported locally from `be5085d7` ✓
- `hoff_small` added as explicit hypothesis to `JEPA_rho_ordering`, breaking the
  circular dependency between `quasiStatic_approx` and `offDiag_bound`
- All 5 remaining sorries are now formally independent — submitted as 5 separate jobs

### Ideal plan (for future reference)

```
Job A: quasiStatic_approx, diagonal_ODE, offDiag_ODE, preconditioner_integral_bounded
       (all formally independent — submit together)
       ↓ wait for completion, port results
Job B: offDiag_bound
       (formally independent, but logically cleaner after A)
       ↓ wait for completion, port results
Job C: JEPA_rho_ordering alone
       (now all 5 helpers are proved — best shot at success)
```

---

## Already Proved (do not re-prove)

| Lemma | Where | How |
|---|---|---|
| `gradient_projection` | JEPA.lean | algebraic, proved locally |
| `critical_time_formula` | JEPA.lean | existential, proved locally |
| `critical_time_ordering` | JEPA.lean | algebraic, proved locally |
| `preconditioner_integral_diverges_L1` | JEPA.lean | measure theory, proved locally |
| `gronwall_approx_ode_bound` | Lemmas.lean | Aristotle job `48ec8df6` |
| `frobenius_pd_lower_bound` | Lemmas.lean | Aristotle job `48ec8df6` |
| `pd_quadratic_lower_bound` | Lemmas.lean | Aristotle job `48ec8df6` |
