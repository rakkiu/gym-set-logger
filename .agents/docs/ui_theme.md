# UI Theme

## Color Palette

**File:** `lib/app/theme.dart` — `AppColors`

| Token | Hex | Usage |
|-------|-----|-------|
| `background` | `#0F0F0F` | Scaffold background (near-black, OLED-friendly) |
| `surface` | `#1A1A1A` | Cards, BottomNav, sheets |
| `surfacePlus` | `#252525` | Elevated surfaces, chip backgrounds, picker backgrounds |
| `primary` | `#C8FF00` | Neon lime — all CTAs, highlights, labels, FAB, active states |
| `primaryDim` | `#8FB800` | Secondary color in ColorScheme |
| `danger` | `#FF4444` | Delete actions, error states, timer low |
| `success` | `#00E676` | Timer high (>50%), body weight chart, positive indicators |
| `text` | `#F0F0F0` | Primary text |
| `textMuted` | `#888888` | Secondary text, labels, hints |

## Typography

All fonts loaded via `google_fonts` package.

| Role | Font | Weight | Usage |
|------|------|--------|-------|
| Display/Headlines | Bebas Neue | Regular | Screen titles, timer digits, section headers |
| Body/UI | Inter | Regular | All body text, labels, list items |
| Data/Stats | JetBrains Mono | Regular | Timer numbers, weight/reps values |

### Text Styles (from `AppTheme.darkTheme`)

- `displayLarge`: Bebas 48sp
- `displayMedium`: Bebas 36sp
- `displaySmall`: Bebas 24sp
- `headlineLarge`: Bebas 22sp
- `headlineMedium`: Bebas 18sp
- `bodyLarge`: Inter 16sp
- `bodyMedium`: Inter 14sp
- `bodySmall`: Inter 12sp (muted)
- `labelLarge`: JetBrains Mono 16sp
- `labelMedium`: JetBrains Mono 14sp
- `labelSmall`: JetBrains Mono 12sp (muted)

## Design Tokens

- **Card border radius:** 12px (via `CardThemeData`)
- **FAB:** Circle shape, primary color, center-docked in bottom nav
- **Bottom nav:** Fixed type, surface background, primary selected color
- **AppBar:** No elevation, background matches scaffold

## Muscle Group Colors

**File:** `lib/features/workout/presentation/schedule_screen.dart` — `allMuscleGroups`

| Group | Color | Hex |
|-------|-------|-----|
| chest | Coral | `#FF6B6B` |
| back | Teal | `#4ECDC4` |
| shoulders | Yellow | `#FFE66D` |
| arms | Mint | `#95E1D3` |
| legs | Lavender | `#AA96DA` |
| core | Orange | `#FF8A5C` |

## Exercise Type Colors

| Type | Color | Hex |
|------|-------|-----|
| compound | Primary lime | `#C8FF00` |
| isolation | Teal | `#4ECDC4` |
| bodyweight | Lavender | `#AA96DA` |

## Rest Timer Visual

- **Circle border:** 6px, color interpolated based on remaining time
- **Timer digits:** 72sp, JetBrains Mono
- **Color interpolation:**
  - > 50% remaining: `#C8FF00` (lime) → `#00E676` (green)
  - <= 50% remaining: `#FF4444` (red) → `#C8FF00` (lime)
- **Pulse animation:** Scale 0.8–1.0, 1000ms, easeInOut, repeat

## Layout Principles

- Dark theme only (gym environment = bright overhead lights)
- Minimum padding — high data density
- Bottom nav with center FAB for primary action (start workout)
- Bottom sheets for quick actions (log set, add exercise, export)
- Full-screen overlays for timer
