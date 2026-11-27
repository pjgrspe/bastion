# Stack Guardrail Reference (Load Only in Mode A/B/D)

## TypeScript / JS (Node, React, Next.js, Vite)
- **`tsconfig.json`:** `strict: true`, `noUncheckedIndexedAccess: true`, `noImplicitOverride: true`, `noFallthroughCasesInSwitch: true`, `exactOptionalPropertyTypes: true`.
- **Lint (ESLint/Biome):** Ban `any`, unused vars, floating promises. Use `no-restricted-imports`/`no-restricted-syntax` to restrict React `useEffect`, raw `process.env` (validate via Zod in `src/core/env.ts`), and raw `fetch` (wrap in `src/core/http.ts`) to `src/core/**`.
- **Boundaries:** `dependency-cruiser` or `eslint-plugin-boundaries`: `core/` never imports `features/` or `ui/`; features import siblings only via public `index.ts`.
- **Verify script:** `"verify": "tsc --noEmit && biome check . && vitest run --reporter=dot && npm run build"`.

## Python (FastAPI, Django, CLI, Agents)
- **Typing & Schemas:** `pyright` (strict) or `mypy --strict`; validate boundaries with `pydantic`.
- **Lint (`ruff`):** Enable `E, F, I, B, UP, SIM, TID, S`. Use `TID251` to ban footgun imports (`os.environ`, raw `requests.get`, `eval`) outside `core/`.
- **Boundaries:** `import-linter` to keep `core` independent of `features`/`api`.
- **Verify cmd:** `ruff check . && ruff format --check . && pyright && pytest -q`.

## High-Criticality Systems
- Property-based tests (`fast-check` / `hypothesis`) for parsers, state machines, and invariants; TLA+ or Lean specs for critical protocols.
