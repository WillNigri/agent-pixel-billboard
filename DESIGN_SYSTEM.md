# ASO Design System

> Design guidelines for Agentic Search Optimization

## Brand Identity

**Brand Name:** Agentic Search Optimization (ASO)
**Tagline:** The definitive directory for AI agent tools
**Logo Mark:** Square cyan block with "A" character
**Logo Wordmark:** `ASO_` (with trailing underscore)

---

## Color Palette

### Primary Colors

| Name | Hex | RGB | Usage |
|------|-----|-----|-------|
| **Cyan (Primary)** | `#00ffd5` | `0, 255, 213` | Primary accent, CTAs, highlights, links |
| **Coral** | `#e8594c` | `232, 89, 76` | Secondary accent, gradients |
| **Blue** | `#3b82f6` | `59, 130, 246` | Tertiary accent, chain tags |

### Background Colors

| Name | Hex | Usage |
|------|-----|-------|
| **Dark** | `#0a0a0a` | Main background |
| **Surface** | `#111111` | Section backgrounds, footer |
| **Card** | `#161616` | Card backgrounds |

### Text Colors

| Name | Hex | Usage |
|------|-----|-------|
| **Primary** | `#f5f5f5` | Headings, primary text |
| **Secondary** | `#a0a0a0` | Body text, descriptions |
| **Muted** | `#666666` | Labels, meta text, placeholders |

### Semantic Colors

| Name | Hex | Usage |
|------|-----|-------|
| **Success (Green)** | `#22c55e` | API connected, success states |
| **Error (Red)** | `#ef4444` | Errors, warnings |
| **Warning (Amber)** | `#f59e0b` | Fallback states |
| **Rating (Gold)** | `#fbbf24` | Star ratings |

### Border Colors

| Name | Hex | Usage |
|------|-----|-------|
| **Default** | `#2a2a2a` | Card borders, dividers |
| **Accent** | `#00ffd5` | Focus states, hover borders |

### CSS Variables

```css
:root {
    --bg-dark: #0a0a0a;
    --bg-surface: #111111;
    --bg-card: #161616;
    --text-primary: #f5f5f5;
    --text-secondary: #a0a0a0;
    --text-muted: #666;
    --accent-cyan: #00ffd5;
    --accent-green: #22c55e;
    --accent-red: #ef4444;
    --accent-coral: #e8594c;
    --accent-blue: #3b82f6;
    --border: #2a2a2a;
    --border-accent: #00ffd5;
}
```

---

## Typography

### Font Stack

| Usage | Font | Fallback |
|-------|------|----------|
| **Headings** | Space Grotesk | sans-serif |
| **Body** | Inter | -apple-system, sans-serif |
| **Code/Mono** | JetBrains Mono | monospace |

### Font Import

```html
<link href="https://fonts.googleapis.com/css2?family=Space+Grotesk:wght@400;500;600;700&family=JetBrains+Mono:wght@400;500&family=Inter:wght@400;500;600&display=swap" rel="stylesheet">
```

### Type Scale

| Element | Size | Weight | Font | Letter Spacing |
|---------|------|--------|------|----------------|
| **H1 (Hero)** | clamp(3rem, 8vw, 5.5rem) | 700 | Space Grotesk | -0.02em |
| **H2 (Section)** | 2.5rem | 700 | Space Grotesk | -0.02em |
| **H3 (Card Title)** | 1.5rem | 700 | Space Grotesk | -0.02em |
| **H4 (Subsection)** | 1.15rem | 700 | Space Grotesk | -0.02em |
| **Body** | 1rem | 400 | Inter | normal |
| **Body Large** | 1.25rem | 400 | Inter | normal |
| **Small** | 0.9rem | 400 | Inter | normal |
| **Code** | 0.85rem | 400 | JetBrains Mono | normal |
| **Badge** | 0.75rem | 500 | JetBrains Mono | 0.1em |
| **Tag** | 0.7rem | 400 | JetBrains Mono | normal |

### Text Styles

```css
/* Headings */
h1, h2, h3, h4 {
    font-family: 'Space Grotesk', sans-serif;
    font-weight: 700;
    letter-spacing: -0.02em;
}

/* Body */
body {
    font-family: 'Inter', -apple-system, sans-serif;
    line-height: 1.6;
    -webkit-font-smoothing: antialiased;
}

/* Monospace */
.mono, code {
    font-family: 'JetBrains Mono', monospace;
}
```

---

## Spacing

### Base Unit
`4px` (use multiples: 8, 12, 16, 20, 24, 32, 40, 48, 60, 80, 100)

### Common Values

| Usage | Value |
|-------|-------|
| Tight | 4px |
| Default | 8px |
| Compact | 12px |
| Regular | 16px |
| Medium | 24px |
| Large | 40px |
| Section | 60px |
| Hero | 100px |

---

## Components

### Buttons

#### Primary Button
```css
.btn-primary {
    background: var(--accent-cyan);
    color: var(--bg-dark);
    padding: 14px 28px;
    font-family: 'Space Grotesk', sans-serif;
    font-weight: 600;
    font-size: 0.95rem;
    border: none;
    cursor: pointer;
    transition: all 0.2s;
}

.btn-primary:hover {
    background: #00e6c0;
    transform: translateY(-2px);
}
```

#### Outline Button
```css
.btn-outline {
    background: transparent;
    color: var(--text-primary);
    border: 2px solid var(--border);
    padding: 14px 28px;
    font-family: 'Space Grotesk', sans-serif;
    font-weight: 600;
}

.btn-outline:hover {
    border-color: var(--accent-cyan);
    color: var(--accent-cyan);
}
```

### Cards

```css
.card {
    background: var(--bg-card);
    border: 1px solid var(--border);
    padding: 24px;
    transition: all 0.2s;
}

.card:hover {
    border-color: var(--accent-cyan);
    transform: translateY(-2px);
}

/* Left accent on hover */
.card::before {
    content: '';
    position: absolute;
    top: 0;
    left: 0;
    width: 3px;
    height: 100%;
    background: var(--accent-cyan);
    opacity: 0;
    transition: opacity 0.2s;
}

.card:hover::before {
    opacity: 1;
}
```

### Tags

```css
.tag {
    font-family: 'JetBrains Mono', monospace;
    font-size: 0.7rem;
    padding: 4px 8px;
    background: var(--bg-dark);
    border: 1px solid var(--border);
    color: var(--text-muted);
    text-transform: uppercase;
}

.tag.chain {
    border-color: var(--accent-blue);
    color: var(--accent-blue);
}
```

### Badges

```css
.badge {
    display: inline-block;
    font-family: 'JetBrains Mono', monospace;
    font-size: 0.75rem;
    text-transform: uppercase;
    letter-spacing: 0.1em;
    color: var(--accent-cyan);
    border: 1px solid var(--accent-cyan);
    padding: 6px 12px;
}
```

### Input Fields

```css
.input {
    width: 100%;
    padding: 16px 24px;
    background: var(--bg-surface);
    border: 2px solid var(--border);
    color: var(--text-primary);
    font-family: 'Inter', sans-serif;
    font-size: 1rem;
    transition: border-color 0.2s;
}

.input:focus {
    outline: none;
    border-color: var(--accent-cyan);
}

.input::placeholder {
    color: var(--text-muted);
}
```

---

## Layout

### Container Width
`max-width: 1200px` (with `1400px` for navigation)

### Section Padding
`padding: 100px 40px` (mobile: `60px 20px`)

### Grid System
Use CSS Grid with `auto-fill` for responsive layouts:

```css
.grid {
    display: grid;
    grid-template-columns: repeat(auto-fill, minmax(350px, 1fr));
    gap: 20px;
}
```

---

## Animations

### Transitions
Default: `all 0.2s`

### Hover Effects
- Cards: `transform: translateY(-2px)`
- Buttons: `transform: translateY(-2px)`

### Aurora Effect (Hero)
WebGL shader-based flowing wave animation with:
- Colors: Cyan, Coral, Blue
- Additive blending
- Noise-based distortion
- Pleating effect

---

## Iconography

Use inline SVG icons with:
- `stroke="currentColor"` for color inheritance
- `stroke-width="2"` for consistent weight
- `24x24` base size

---

## Responsive Breakpoints

| Breakpoint | Width | Usage |
|------------|-------|-------|
| Mobile | `< 600px` | Single column, stacked layout |
| Tablet | `600px - 900px` | Two columns, reduced padding |
| Desktop | `> 900px` | Full layout |
| Large | `> 1024px` | Aurora effect full width |

---

## Accessibility

- Minimum contrast ratio: 4.5:1
- Focus states: Use `border-color: var(--accent-cyan)`
- Interactive elements: 44x44px minimum touch target
- Semantic HTML: Use appropriate heading hierarchy

---

## File Naming

- Components: `kebab-case.html`
- CSS classes: `kebab-case`
- JavaScript: `camelCase`
- Images: `lowercase-with-dashes.png`

---

## Brand Voice

- **Technical but approachable**
- **Concise and direct**
- Use trailing underscores for CTAs: `Subscribe_`, `Browse Directory →`
- Use brackets for emphasis: `[SEARCH]`
- Reference the "agent-first" perspective

---

## Examples

### Hero Section
```html
<section class="hero">
    <span class="hero-badge">The Agent Tool Registry</span>
    <h1>
        AGENTIC<br>
        <span class="bracket">[</span><span class="accent">SEARCH</span><span class="bracket">]</span><br>
        OPTIMIZATION_
    </h1>
    <p class="hero-subtitle">
        The definitive directory for AI agent tools.
    </p>
</section>
```

### Card Grid
```html
<div class="tools-grid">
    <article class="tool-card">
        <div class="tool-header">
            <h3 class="tool-name">Tool Name</h3>
            <div class="tool-rating">★★★★☆ 4.0</div>
        </div>
        <p class="tool-description">Description text here.</p>
        <div class="tool-tags">
            <span class="tool-tag chain">BASE</span>
            <span class="tool-tag">CAPABILITY</span>
        </div>
    </article>
</div>
```

---

## Version History

| Version | Date | Changes |
|---------|------|---------|
| 1.0.0 | March 2026 | Initial design system |
