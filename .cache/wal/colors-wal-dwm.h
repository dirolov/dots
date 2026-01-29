static const char norm_fg[] = "#c1c3c3";
static const char norm_bg[] = "#070f12";
static const char norm_border[] = "#56676a";

static const char sel_fg[] = "#c1c3c3";
static const char sel_bg[] = "#063C44";
static const char sel_border[] = "#c1c3c3";

static const char *colors[][3]      = {
    /*               fg           bg         border                         */
    [SchemeNorm] = { norm_fg,     norm_bg,   norm_border }, // unfocused wins
    [SchemeSel]  = { sel_fg,      sel_bg,    sel_border },  // the focused win
};
