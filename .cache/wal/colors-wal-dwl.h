/* Taken from https://github.com/djpohly/dwl/issues/466 */
#define COLOR(hex)    { ((hex >> 24) & 0xFF) / 255.0f, \
                        ((hex >> 16) & 0xFF) / 255.0f, \
                        ((hex >> 8) & 0xFF) / 255.0f, \
                        (hex & 0xFF) / 255.0f }

static const float rootcolor[]             = COLOR(0x070f12ff);
static uint32_t colors[][3]                = {
	/*               fg          bg          border    */
	[SchemeNorm] = { 0xc1c3c3ff, 0x070f12ff, 0x56676aff },
	[SchemeSel]  = { 0xc1c3c3ff, 0x0C4E4Bff, 0x063C44ff },
	[SchemeUrg]  = { 0xc1c3c3ff, 0x063C44ff, 0x0C4E4Bff },
};
