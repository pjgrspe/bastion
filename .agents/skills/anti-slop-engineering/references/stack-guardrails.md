# Stack-Specific Guardrail Reference

Use this reference when executing **Mode A (Bootstrap)**, **Mode B (Harden)**, or **Mode D (Mistake → Constraint)** in `SKILL.md`.

---

## TypeScript / JavaScript (Node, React, Next.js, Vite)

### 1. Strict TypeScript (`tsconfig.json`)
Enable at minimum:
```json
{
  "compilerOptions": {
    "strict": true,
    "noUncheckedIndexedAccess": true,
    "noImplicitOverride": true,
    "noFallthroughCasesInSwitch": true,
    "exactOptionalPropertyTypes": true
  }
}
```

### 2. Linting & Banned Footguns (ESLint / Biome)
- Ban `any` (`@typescript-eslint/no-explicit-any`), unused vars, and floating promises (`@typescript-eslint/no-floating-promises`).
- Ban nuance-heavy APIs in feature code via `no-restricted-imports` / `no-restricted-syntax`:
  - **React `useEffect` in product/feature folders:** Restrict `useEffect` to `src/core/**` or `src/hooks/**` and ban it in `src/features/**` or `src/components/**`.
  - **Direct `process.env` reads:** Centralize in `src/core/env.ts` validated with Zod; ban `process.env` elsewhere.
  - **Raw `fetch` in UI components:** Centralize in `src/core/http.ts` with typed responses and timeouts.

### 3. Architectural Boundaries
- Use `dependency-cruiser` or ESLint `eslint-plugin-boundaries` to enforce:
  - `core/` cannot import from `features/` or `ui/`
  - `features/<A>/` cannot import internals of `features/<B>/` (only public `index.ts`)

### 4. Single `verify` Script (`package.json`)
```json
{
  "scripts": {
    "typecheck": "tsc --noEmit",
    "lint": "biome check .",
    "test": "vitest run",
    "verify": "npm run typecheck && npm run lint && npm run test && npm run build"
  }
}
```

---

## Python (FastAPI, Django, CLI, AI Agents)

### 1. Strict Static Typing
- Use `pyright` (strict mode) or `mypy --strict`.
- Validate external boundaries (API inputs, env vars, LLM outputs) with `pydantic`.

### 2. Fast Linting & Formatting (`ruff`)
- Enable `E`, `F`, `I`, `B` (bugbear), `UP` (pyupgrade), `SIM` (simplify), `TID` (banned imports), and `S` (bandit security rules) in `pyproject.toml`.
- Use `flake8-tidy-imports` (`TID251`) in Ruff to ban footgun imports outside `core/` (e.g., direct `requests.get`, raw `os.environ`, or unsafe `eval`).

### 3. Architectural Boundaries
- Use `import-linter` to enforce layer contracts (e.g., `core` is independent of `features` and `api`).

### 4. Testing & Verification
- Use `pytest` for behavioral tests and `hypothesis` for property-based testing of parsers, state machines, and transformations.
- Expose a single `verify` command (via `Makefile`, `justfile`, or `uv run`):
  ```bash
  ruff check . && ruff format --check . && pyright && pytest
  ```

---

## High-Criticality Systems (Concurrency, Distributed State, Money, Safety)

- Add **property-based tests** (`fast-check` in TS, `hypothesis` in Python) to test invariants across randomized inputs and interleavings.
- For complex protocols or state machines, write a lightweight **formal spec** (e.g., TLA+ or Lean) to prove invariants before scaling agent-authored implementations.
