# ATLANTECH Design Tokens (extracted from Figma)

Source: Figma file `E5LYIJCA56H7xZQ5Zf8CNx`, local variables, text styles and effect styles.
Light theme only. Components use **semantic** tokens; primitives only define them.

## 1. Primitive colors

| Scale | 50 | 100 | 200 | 300 | 400 | 500 | 600 | 700 | 800 | 900 | 950 |
|---|---|---|---|---|---|---|---|---|---|---|---|
| navy | #E8EDEF | #DCE3E6 | #C2CED3 | #A7B9C0 | #8CA3AD | #6F8C98 | #517483 | #305A6C | #083A4F | #062D3E | #052736 |
| teal | #E8EFF1 | #D8E4E7 | #C0D5D6 | #94B7BF | #6F9EA8 | #407E8C | #37707D | #306470 | #295964 | #224E58 | #1F4852 |
| gold | #F4F1EC | #ECE8E0 | #DDD4C5 | #CDBFA9 | #BBA98B | #A58D66 | #907A58 | #7E6A4B | #6D5B40 | #5C4D34 | #54452F |
| neutral | #F6F4F2 | #EEEBE8 | #E5E1DD | #CFCAC5 | #A9A8A6 | #84898B | #5F676B | #434C51 | #2B363C | #17252D | #0C171D |

| Scale | 50 | 100 | 200 | 500 | 600 | 700 | 800 |
|---|---|---|---|---|---|---|---|
| success | #E8F1ED | #DAE8E2 | #BCD5CB | #5B987D | #2F7D5B | #276B4E | #215C42 |
| warning | #F8F1E3 | #F4E7D0 | #EBD2A8 | #C9891A | #B07716 | #9A6813 | #855A11 |
| danger | #F7EAE8 | #F1DCD9 | #E6C0BB | #C26357 | #B23A2B | #983124 | #82291E |

white #FFFFFF · black #000000

## 2. Semantic colors (Light)

| Token | → Primitive | Use |
|---|---|---|
| bg/page | neutral/50 | App page |
| bg/surface | white | Cards, tables, dialogs |
| bg/subtle | neutral/100 | Table header, hover row |
| bg/muted | neutral/200 | Selected or disabled fill |
| bg/inverse | navy/800 | Sidebar, cover |
| bg/brand-tint | teal/100 | Info tint, selected row |
| bg/overlay | navy/950 | Dialog scrim at 33% opacity |
| text/primary | navy/900 | Titles, values |
| text/secondary | neutral/700 | Body text |
| text/muted | neutral/600 | Hints, captions |
| text/disabled | neutral/400 | Disabled |
| text/inverse | white | On navy and teal |
| text/link | teal/700 | Links |
| text/accent | gold/700 | Gold highlight text |
| border/default | neutral/200 | Dividers, cards |
| border/strong | neutral/300 | Inputs, table outline |
| border/focus | teal/500 | Focus ring |
| border/inverse | navy/700 | On dark surfaces |
| brand/primary | navy/800 | Primary button |
| brand/primary-hover | navy/700 | Hover |
| brand/primary-pressed | navy/900 | Pressed |
| brand/secondary | teal/500 | Secondary action, info |
| brand/secondary-hover | teal/600 | Hover |
| brand/accent | gold/500 | Accent (rare) |
| brand/accent-tint | gold/100 | Accent tint |
| status/info/{bg,border,fg} | teal/100, teal/300, teal/800 | Info, selected, confirmed |
| status/success/{bg,border,fg} | success/50, success/200, success/700 | Completed, DONE, Acknowledged |
| status/warning/{bg,border,fg} | warning/50, warning/200, warning/800 | Pending, stale, expiring, READ_ONLY |
| status/danger/{bg,border,fg} | danger/50, danger/200, danger/700 | Rejected, Failed, Escalated, 409/423 |
| status/neutral/{bg,border,fg} | neutral/100, neutral/300, neutral/700 | Draft, inactive, n/a |

## 3. Spacing, radius, borders, sizes (px = logical px / dp)

- space: 0=0, 1=2, 2=4, 3=8, 4=12, 5=16, 6=20, 7=24, 8=32, 9=40, 10=48, 11=64
- radius: none=0, sm=4 (buttons, inputs, badges), md=8 (cards, dialogs), lg=12 (large panels), full=999 (pills)
- border: thin=1, medium=2
- size: control-sm=32, control-md=40, control-lg=48, touch=56, icon-sm=16, icon-md=20, icon-lg=24
- Web only (not used in the app): sidebar-web=232, content-max=1208

## 4. Typography

Fonts: Montserrat (headings, numbers), Inter (everything else), Roboto Mono (IDs). Arabic falls back to the system font.
Format: family weight size/lineHeight, letter spacing 0 unless noted.

| Style | Spec |
|---|---|
| Heading/H1 | Montserrat SemiBold 28/36 |
| Heading/H2 | Montserrat SemiBold 22/30 |
| Heading/H2-24 | Montserrat SemiBold 24/32 |
| Heading/H3 | Montserrat SemiBold 18/26 |
| Heading/H3-20 | Montserrat SemiBold 20/28 |
| Heading/H3-26 | Montserrat SemiBold 26/34 |
| Heading/H4 | Montserrat SemiBold 16/24 |
| Number/Display | Montserrat Bold 32/40 |
| Number/M | Montserrat SemiBold 22/28 |
| Body/L | Inter Regular 16/24 |
| Body/M | Inter Regular 14/20 |
| Body/S | Inter Regular 13/18 |
| Body/18 | Inter Regular 18/26 |
| Label/L | Inter Medium 16/22 |
| Label/M | Inter Medium 14/20 |
| Label/M-13 | Inter Medium 13/18 |
| Label/S | Inter Medium 12/16 |
| Strong/M | Inter SemiBold 14/20 |
| Strong/S | Inter SemiBold 13/18 |
| Strong/XS | Inter SemiBold 12/16 |
| Caption | Inter Regular 12/16 |
| Overline | Inter SemiBold 11/16, +4% letter spacing, uppercase |
| Mono/M | Roboto Mono Regular 13/20 |
| **Tablet/H1** | Montserrat SemiBold 32/40 |
| **Tablet/H2** | Montserrat SemiBold 24/32 |
| **Tablet/Body** | Inter Regular 18/26 |
| **Tablet/Label** | Inter Medium 18/24 |
| **Tablet/Caption** | Inter Regular 14/20 |

Weights: Regular 400, Medium 500, SemiBold 600, Bold 700.

## 5. Elevation (shadow color = navy/800 #083A4F)

| Style | Shadow |
|---|---|
| Elevation/1 · card | y 1, blur 2, spread 0, 8% opacity |
| Elevation/2 · dropdown | y 4, blur 12, spread 0, 12% opacity |
| Elevation/3 · dialog | y 12, blur 32, spread 0, 20% opacity |
| Focus ring | spread 3, blur 0, teal/500 #407E8C at 45% opacity |

Dialogs: Elevation/3 over a 33% navy/950 scrim.

## 6. Layout

- Tablet frame 1280 × 800: 8 columns, 16 gutter, 24 margin. Header 88, footer 40, body 672.
- 4 px grid. Line heights are multiples of 2, spacing multiples of 4.
