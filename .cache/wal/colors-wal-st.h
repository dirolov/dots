const char *colorname[] = {

  /* 8 normal colors */
  [0] = "#070f12", /* black   */
  [1] = "#063C44", /* red     */
  [2] = "#0C4E4B", /* green   */
  [3] = "#136759", /* yellow  */
  [4] = "#119B5C", /* blue    */
  [5] = "#23C253", /* magenta */
  [6] = "#8AE45E", /* cyan    */
  [7] = "#c1c3c3", /* white   */

  /* 8 bright colors */
  [8]  = "#56676a",  /* black   */
  [9]  = "#063C44",  /* red     */
  [10] = "#0C4E4B", /* green   */
  [11] = "#136759", /* yellow  */
  [12] = "#119B5C", /* blue    */
  [13] = "#23C253", /* magenta */
  [14] = "#8AE45E", /* cyan    */
  [15] = "#c1c3c3", /* white   */

  /* special colors */
  [256] = "#070f12", /* background */
  [257] = "#c1c3c3", /* foreground */
  [258] = "#c1c3c3",     /* cursor */
};

/* Default colors (colorname index)
 * foreground, background, cursor */
 unsigned int defaultbg = 0;
 unsigned int defaultfg = 257;
 unsigned int defaultcs = 258;
 unsigned int defaultrcs= 258;
