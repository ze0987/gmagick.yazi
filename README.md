# gmagick.yazi

Alternative [image preview](https://github.com/sxyazi/yazi/blob/main/yazi-plugin/preset/plugins/magick.lua) plugin for [yazi](https://github.com/sxyazi/yazi) that uses [GraphicsMagick](http://www.graphicsmagick.org/) instead of [ImageMagick](https://imagemagick.org/). Depending on the format, image size or CPU, GraphicsMagick can be faster or slower than ImageMagick; usually requires less RAM. This plugin does not limit the number of threads by default; rather, it sets the maximum number offered by the processor on which it is running. While this significantly speeds up the generation of JPEG-XL file previews with preloaders disabled, it is not optimal with the default Yazi settings, where up to 10 thumbnail generation processes run in parallel. I encourage you to uncomment `-- "-limit" , "threads", 1,` and adjust the thread limit as needed.

## Requirements

- `graphicsmagick`

## Installation

```sh
ya pkg add 'ze0987/gmagick'
```

## Usage

Add the following to your `yazi.toml`. Extend the list of MIME types as you see fit. The complete list of supported formats is available [here](http://www.graphicsmagick.org/formats.html).

```toml
[plugin]
prepend_previewers = [
  { mime = "image/{avif,hei?,jxl}", run = "gmagick" },
]

prepend_preloaders = [
{ mime = "image/{avif,hei?,jxl}", run = "gmagick" },
]
```

## x86 Benchmarks
```
CPU: Intel 13th gen 6 P-Cores w/ SMT, 8 E-Cores
ImageMagick version: 7.1.2-8
GraphicsMagick version: 1.3.46
GraphicsMagick command: gm convert input_image -auto-orient -thumbnail 600x900 -quality 75 jpg:th
ImageMagick command : magick input_image -auto-orient -thumbnail 600x900 -quality 75 jpg:th

```
### Small file (700 x 875 px)
#### JPEG XL
| Test | Mean [ms] | Min [ms] | Max [ms] | Relative | Max RSS (kbytes) |
|:---|---:|---:|---:|---:|---:|
| GraphicsMagick - 10t | 15.5 ± 0.8 | 13.7 | 17.0 | 1.00 ||
| GraphicsMagick - 9t | 15.7 ± 0.8 | 13.6 | 17.0 | 1.01 ± 0.08 ||
| GraphicsMagick - 5t | 15.8 ± 1.9 | 12.4 | 19.0 | 1.02 ± 0.13 ||
| GraphicsMagick - 11t | 16.0 ± 0.7 | 14.8 | 17.1 | 1.03 ± 0.07 ||
| GraphicsMagick - 12t | 16.1 ± 0.7 | 14.6 | 18.1 | 1.04 ± 0.07 ||
| GraphicsMagick - 14t | 16.2 ± 1.4 | 13.2 | 19.0 | 1.05 ± 0.11 ||
| GraphicsMagick - 13t | 16.3 ± 0.9 | 14.4 | 17.7 | 1.05 ± 0.08 ||
| GraphicsMagick - 8t | 16.3 ± 1.4 | 13.5 | 18.5 | 1.05 ± 0.10 ||
| GraphicsMagick - 16t | 16.3 ± 1.4 | 13.7 | 18.6 | 1.05 ± 0.11 ||
| GraphicsMagick - 18t | 16.6 ± 1.9 | 10.5 | 19.4 | 1.07 ± 0.13 ||
| GraphicsMagick - 7t | 16.6 ± 0.7 | 15.5 | 18.3 | 1.07 ± 0.07 ||
| GraphicsMagick - 17t | 16.8 ± 1.6 | 12.1 | 18.8 | 1.08 ± 0.12 ||
| GraphicsMagick - 20t | 16.9 ± 2.1 | 14.0 | 20.5 | 1.09 ± 0.14 |34096|
| GraphicsMagick - 15t | 16.9 ± 1.0 | 14.6 | 19.0 | 1.09 ± 0.08 ||
| GraphicsMagick - 19t | 16.9 ± 1.0 | 15.4 | 18.9 | 1.09 ± 0.09 ||
| GraphicsMagick - 3t | 16.9 ± 2.6 | 11.5 | 20.3 | 1.09 ± 0.18 ||
| GraphicsMagick - 6t | 17.3 ± 1.0 | 15.2 | 19.5 | 1.11 ± 0.09 ||
| GraphicsMagick - 4t | 17.7 ± 2.1 | 13.7 | 21.4 | 1.14 ± 0.15 ||
| GraphicsMagick - 2t | 19.3 ± 2.3 | 13.5 | 23.4 | 1.24 ± 0.16 ||
| GraphicsMagick - 1t | 22.2 ± 3.5 | 16.0 | 27.3 | 1.43 ± 0.24 |29784|
| ImageMagick - 20t | 26.0 ± 2.2 | 23.2 | 31.2 | 1.67 ± 0.17 |41132|
| ImageMagick - 19t | 26.3 ± 2.7 | 23.5 | 35.5 | 1.70 ± 0.19 ||
| ImageMagick - 18t | 31.3 ± 2.8 | 27.9 | 39.7 | 2.02 ± 0.21 ||
| ImageMagick - 17t | 32.2 ± 2.0 | 28.4 | 37.0 | 2.07 ± 0.17 ||
| ImageMagick - 15t | 32.3 ± 1.9 | 28.0 | 36.8 | 2.09 ± 0.16 ||
| ImageMagick - 16t | 32.5 ± 3.6 | 28.3 | 42.9 | 2.09 ± 0.26 ||
| ImageMagick - 10t | 33.8 ± 1.8 | 31.7 | 38.2 | 2.18 ± 0.16 ||
| ImageMagick - 11t | 34.0 ± 1.8 | 32.2 | 40.2 | 2.19 ± 0.16 ||
| ImageMagick - 8t | 34.2 ± 1.4 | 32.7 | 38.6 | 2.20 ± 0.15 ||
| ImageMagick - 13t | 34.4 ± 2.6 | 32.2 | 41.6 | 2.22 ± 0.21 ||
| ImageMagick - 9t | 34.5 ± 1.2 | 32.6 | 38.1 | 2.22 ± 0.14 ||
| ImageMagick - 12t | 34.8 ± 2.5 | 32.3 | 42.0 | 2.24 ± 0.20 ||
| ImageMagick - 3t | 34.8 ± 2.2 | 32.3 | 39.7 | 2.25 ± 0.19 ||
| ImageMagick - 6t | 35.0 ± 2.1 | 32.4 | 38.4 | 2.26 ± 0.18 ||
| ImageMagick - 14t | 35.0 ± 2.4 | 32.0 | 39.8 | 2.26 ± 0.19 ||
| ImageMagick - 7t | 35.3 ± 2.2 | 32.6 | 39.7 | 2.28 ± 0.19 ||
| ImageMagick - 4t | 35.3 ± 2.0 | 32.5 | 39.2 | 2.28 ± 0.17 ||
| ImageMagick - 5t | 35.4 ± 2.4 | 32.3 | 41.5 | 2.28 ± 0.20 ||
| ImageMagick - 2t | 37.0 ± 3.4 | 33.2 | 44.6 | 2.38 ± 0.25 ||
| ImageMagick - 1t* | 40.4 ± 3.0 | 36.3 | 45.9 | 2.61 ± 0.24 |41112|

#### AVIF
| Test | Mean [ms] | Min [ms] | Max [ms] | Relative | Max RSS (kbytes) |
|:---|---:|---:|---:|---:|---:|
| GraphicsMagick - 1t | 33.8 ± 3.3 | 28.9 | 41.7 | 1.00 |49864|
| GraphicsMagick - 20t | 36.0 ± 3.0 | 30.7 | 42.4 | 1.07 ± 0.14 |52256|
| ImageMagick - 20t | 40.7 ± 2.7 | 36.7 | 46.1 | 1.20 ± 0.14 |60012|
| ImageMagick - 1t* | 49.5 ± 2.5 | 46.3 | 54.4 | 1.46 ± 0.16 |60176|

#### HEIC
| Test | Mean [ms] | Min [ms] | Max [ms] | Relative | Max RSS (kbytes) |
|:---|---:|---:|---:|---:|---:|
| GraphicsMagick - 1t | 44.6 ± 3.6 | 39.9 | 52.1 | 1.00 |50352|
| GraphicsMagick - 20t | 45.2 ± 4.0 | 37.6 | 51.0 | 1.01 ± 0.12 |50388|
| ImageMagick - 20t | 52.3 ± 3.3 | 46.5 | 58.8 | 1.17 ± 0.12 |57912|
| ImageMagick - 1t* | 59.3 ± 2.6 | 54.7 | 63.4 | 1.33 ± 0.12 |57788|

### Medium file (4271 x 5697 px)
#### JPEG-XL
| Test | Mean [ms] | Min [ms] | Max [ms] | Relative | Max RSS (kbytes) |
|:---|---:|---:|---:|---:|---:|
| GraphicsMagick - 17t | 198.2 ± 6.8 | 188.4 | 212.5 | 1.00 ||
| GraphicsMagick - 18t | 201.0 ± 6.6 | 191.0 | 214.2 | 1.01 ± 0.05 ||
| GraphicsMagick - 20t | 201.2 ± 7.8 | 190.7 | 214.2 | 1.02 ± 0.05 |385236|
| GraphicsMagick - 19t | 201.2 ± 4.3 | 196.7 | 211.6 | 1.02 ± 0.04 ||
| GraphicsMagick - 14t | 201.7 ± 4.6 | 195.9 | 210.3 | 1.02 ± 0.04 ||
| GraphicsMagick - 16t | 203.2 ± 6.0 | 194.7 | 211.8 | 1.03 ± 0.05 ||
| GraphicsMagick - 15t | 204.2 ± 6.8 | 197.2 | 218.2 | 1.03 ± 0.05 ||
| GraphicsMagick - 13t | 204.8 ± 4.6 | 196.7 | 212.4 | 1.03 ± 0.04 ||
| GraphicsMagick - 11t | 204.9 ± 5.1 | 196.1 | 213.6 | 1.03 ± 0.04 ||
| GraphicsMagick - 12t | 207.5 ± 5.5 | 201.6 | 216.1 | 1.05 ± 0.05 ||
| GraphicsMagick - 10t | 208.4 ± 5.3 | 199.5 | 214.9 | 1.05 ± 0.04 ||
| GraphicsMagick - 9t | 209.4 ± 7.1 | 201.4 | 222.6 | 1.06 ± 0.05 ||
| GraphicsMagick - 8t | 212.0 ± 7.0 | 204.0 | 223.3 | 1.07 ± 0.05 ||
| GraphicsMagick - 7t | 213.3 ± 4.7 | 205.4 | 221.1 | 1.08 ± 0.04 ||
| GraphicsMagick - 6t | 224.2 ± 5.5 | 218.7 | 234.2 | 1.13 ± 0.05 ||
| GraphicsMagick - 5t | 234.7 ± 5.2 | 225.2 | 243.6 | 1.18 ± 0.05 ||
| GraphicsMagick - 4t | 249.7 ± 5.2 | 241.4 | 256.6 | 1.26 ± 0.05 ||
| ImageMagick - 19t | 256.5 ± 5.4 | 250.0 | 264.5 | 1.29 ± 0.05 ||
| ImageMagick - 20t | 258.3 ± 3.8 | 252.3 | 264.8 | 1.30 ± 0.05 |498304|
| ImageMagick - 18t | 269.6 ± 4.1 | 264.8 | 275.0 | 1.36 ± 0.05 ||
| ImageMagick - 17t | 271.7 ± 3.4 | 266.1 | 278.0 | 1.37 ± 0.05 ||
| ImageMagick - 16t | 274.1 ± 3.9 | 264.7 | 279.4 | 1.38 ± 0.05 ||
| ImageMagick - 14t | 276.4 ± 5.4 | 269.3 | 287.7 | 1.39 ± 0.06 ||
| ImageMagick - 15t | 277.0 ± 5.7 | 268.5 | 283.4 | 1.40 ± 0.06 ||
| GraphicsMagick - 3t | 278.2 ± 2.2 | 274.7 | 281.7 | 1.40 ± 0.05 ||
| ImageMagick - 13t | 296.7 ± 8.5 | 286.9 | 312.3 | 1.50 ± 0.07 ||
| ImageMagick - 12t | 299.0 ± 6.5 | 292.4 | 313.5 | 1.51 ± 0.06 ||
| ImageMagick - 10t | 304.6 ± 5.1 | 295.2 | 311.3 | 1.54 ± 0.06 ||
| ImageMagick - 11t | 306.8 ± 9.2 | 299.0 | 326.9 | 1.55 ± 0.07 ||
| ImageMagick - 9t | 312.2 ± 3.9 | 306.5 | 320.0 | 1.57 ± 0.06 ||
| ImageMagick - 8t | 323.2 ± 7.5 | 315.1 | 340.5 | 1.63 ± 0.07 ||
| ImageMagick - 7t | 327.0 ± 4.8 | 323.8 | 338.9 | 1.65 ± 0.06 ||
| GraphicsMagick - 2t | 343.4 ± 4.6 | 338.1 | 350.6 | 1.73 ± 0.06 ||
| ImageMagick - 6t | 358.2 ± 4.7 | 353.9 | 369.3 | 1.81 ± 0.07 ||
| ImageMagick - 5t | 369.6 ± 3.4 | 365.4 | 374.7 | 1.86 ± 0.07 ||
| ImageMagick - 4t | 383.2 ± 3.8 | 378.6 | 389.3 | 1.93 ± 0.07 ||
| ImageMagick - 3t | 414.9 ± 2.9 | 409.4 | 420.9 | 2.09 ± 0.07 ||
| ImageMagick - 2t | 478.4 ± 3.6 | 475.0 | 486.5 | 2.41 ± 0.09 ||
| GraphicsMagick - 1t | 549.2 ± 7.6 | 543.8 | 569.1 | 2.77 ± 0.10 |356984|
| ImageMagick - 1t* | 671.5 ± 2.2 | 669.3 | 674.9 | 3.39 ± 0.12 |494716|

#### AVIF
| Test | Mean [ms] | Min [ms] | Max [ms] | Relative | Max RSS (kbytes) |
|:---|---:|---:|---:|---:|---:|
| GraphicsMagick - 20t | 247.4 ± 3.8 | 242.8 | 253.2 | 1.00 |352468|
| ImageMagick - 20t | 255.7 ± 6.1 | 248.4 | 265.2 | 1.03 ± 0.03 |487380|
| GraphicsMagick - 1t | 256.3 ± 2.2 | 253.2 | 260.7 | 1.04 ± 0.02 |353084|
| ImageMagick - 1t* | 327.8 ± 4.5 | 323.7 | 339.7 | 1.32 ± 0.03 |487660|

#### HEIC
| Test | Mean [s] | Min [s] | Max [s] | Relative | Max RSS (kbytes) |
|:---|---:|---:|---:|---:|---:|
| GraphicsMagick - 20t | 1.063 ± 0.002 | 1.060 | 1.066 | 1.00 |389148|
| ImageMagick - 20t | 1.073 ± 0.003 | 1.069 | 1.079 | 1.01 ± 0.00 |527320|
| GraphicsMagick - 1t | 1.075 ± 0.003 | 1.072 | 1.082 | 1.01 ± 0.00 |387800|
| ImageMagick - 1t* | 1.146 ± 0.003 | 1.142 | 1.151 | 1.08 ± 0.00 |527320|

### Big File (14105 x 21358 px)
#### JPEG-XL
| Test | Mean [s] | Min [s] | Max [s] | Relative | Max RSS (kbytes) |
|:---|---:|---:|---:|---:|---:|
| ImageMagick - 16t | 1.322 ± 0.002 | 1.320 | 1.325 | 1.00 ||
| ImageMagick - 19t | 1.322 ± 0.004 | 1.318 | 1.328 | 1.00 ± 0.00 ||
| ImageMagick - 17t | 1.323 ± 0.011 | 1.309 | 1.334 | 1.00 ± 0.01 ||
| ImageMagick - 15t | 1.323 ± 0.005 | 1.317 | 1.330 | 1.00 ± 0.00 ||
| ImageMagick - 18t | 1.325 ± 0.007 | 1.318 | 1.335 | 1.00 ± 0.01 ||
| ImageMagick - 14t | 1.331 ± 0.010 | 1.321 | 1.347 | 1.01 ± 0.01 ||
| ImageMagick - 20t | 1.332 ± 0.008 | 1.323 | 1.340 | 1.01 ± 0.01 |5297920|
| ImageMagick - 13t | 1.343 ± 0.012 | 1.330 | 1.359 | 1.02 ± 0.01 ||
| ImageMagick - 12t | 1.361 ± 0.007 | 1.349 | 1.367 | 1.03 ± 0.01 ||
| ImageMagick - 11t | 1.376 ± 0.010 | 1.364 | 1.389 | 1.04 ± 0.01 ||
| ImageMagick - 10t | 1.399 ± 0.013 | 1.383 | 1.415 | 1.06 ± 0.01 ||
| GraphicsMagick - 19t | 1.403 ± 0.012 | 1.391 | 1.420 | 1.06 ± 0.01 ||
| GraphicsMagick - 18t | 1.406 ± 0.009 | 1.391 | 1.416 | 1.06 ± 0.01 ||
| GraphicsMagick - 17t | 1.408 ± 0.031 | 1.383 | 1.460 | 1.07 ± 0.02 ||
| ImageMagick - 9t | 1.414 ± 0.011 | 1.396 | 1.425 | 1.07 ± 0.01 ||
| GraphicsMagick - 20t | 1.418 ± 0.013 | 1.405 | 1.433 | 1.07 ± 0.01 |4108684|
| GraphicsMagick - 16t | 1.422 ± 0.066 | 1.376 | 1.538 | 1.08 ± 0.05 ||
| GraphicsMagick - 15t | 1.426 ± 0.041 | 1.380 | 1.483 | 1.08 ± 0.03 ||
| GraphicsMagick - 14t | 1.440 ± 0.061 | 1.386 | 1.507 | 1.09 ± 0.05 ||
| ImageMagick - 8t | 1.466 ± 0.013 | 1.455 | 1.482 | 1.11 ± 0.01 ||
| GraphicsMagick - 10t | 1.488 ± 0.016 | 1.465 | 1.502 | 1.13 ± 0.01 ||
| ImageMagick - 7t | 1.490 ± 0.005 | 1.484 | 1.495 | 1.13 ± 0.00 ||
| GraphicsMagick - 13t | 1.493 ± 0.045 | 1.446 | 1.540 | 1.13 ± 0.03 ||
| GraphicsMagick - 11t | 1.506 ± 0.048 | 1.450 | 1.578 | 1.14 ± 0.04 ||
| GraphicsMagick - 12t | 1.510 ± 0.033 | 1.462 | 1.554 | 1.14 ± 0.03 ||
| GraphicsMagick - 9t | 1.530 ± 0.042 | 1.475 | 1.593 | 1.16 ± 0.03 ||
| ImageMagick - 6t | 1.540 ± 0.004 | 1.535 | 1.546 | 1.16 ± 0.00 ||
| GraphicsMagick - 6t | 1.549 ± 0.027 | 1.527 | 1.585 | 1.17 ± 0.02 ||
| GraphicsMagick - 7t | 1.569 ± 0.027 | 1.529 | 1.599 | 1.19 ± 0.02 ||
| GraphicsMagick - 8t | 1.579 ± 0.031 | 1.544 | 1.620 | 1.19 ± 0.02 ||
| GraphicsMagick - 5t | 1.658 ± 0.026 | 1.639 | 1.700 | 1.25 ± 0.02 ||
| ImageMagick - 5t | 1.700 ± 0.007 | 1.690 | 1.707 | 1.29 ± 0.01 ||
| GraphicsMagick - 4t | 1.787 ± 0.024 | 1.768 | 1.827 | 1.35 ± 0.02 ||
| ImageMagick - 4t | 1.901 ± 0.013 | 1.886 | 1.917 | 1.44 ± 0.01 ||
| GraphicsMagick - 3t | 1.997 ± 0.022 | 1.977 | 2.031 | 1.51 ± 0.02 ||
| ImageMagick - 3t | 2.163 ± 0.010 | 2.154 | 2.180 | 1.64 ± 0.01 ||
| GraphicsMagick - 2t | 2.486 ± 0.021 | 2.470 | 2.520 | 1.88 ± 0.02 ||
| ImageMagick - 2t | 2.789 ± 0.022 | 2.768 | 2.822 | 2.11 ± 0.02 ||
| GraphicsMagick - 1t | 3.965 ± 0.021 | 3.941 | 3.997 | 3.00 ± 0.02 |4065828|
| ImageMagick - 1t* | 4.437 ± 0.035 | 4.400 | 4.489 | 3.36 ± 0.03 |5255328|
#### AVIF
| Test | Mean [s] | Min [s] | Max [s] | Relative | Max RSS (kbytes) |
|:---|---:|---:|---:|---:|---:|
| ImageMagick - 20t | 1.502 ± 0.004 | 1.497 | 1.506 | 1.00 |4453504|
| ImageMagick - 1t* | 1.585 ± 0.007 | 1.577 | 1.593 | 1.05 ± 0.01 |4453572|
| GraphicsMagick - 20t | 1.736 ± 0.005 | 1.730 | 1.745 | 1.16 ± 0.00 |3277588|
| GraphicsMagick - 1t | 1.747 ± 0.006 | 1.738 | 1.752 | 1.16 ± 0.01 |3277216|
#### HEIC
| Test | Mean [s] | Min [s] | Max [s] | Relative | Max RSS (kbytes) |
|:---|---:|---:|---:|---:|---:|
| ImageMagick - 20t | 4.446 ± 0.009 | 4.438 | 4.460 | 1.00 |4462012|
| ImageMagick - 1t* | 4.524 ± 0.010 | 4.508 | 4.535 | 1.02 ± 0.00 |4461648|
| GraphicsMagick - 20t | 4.676 ± 0.005 | 4.668 | 4.683 | 1.05 ± 0.00 |3288672|
| GraphicsMagick - 1t | 4.680 ± 0.004 | 4.675 | 4.687 | 1.05 ± 0.00 |3288256|

\* default in Yazi

## aarch64 Benchmarks
```
CPU: M1 4 P-Core / 4 E-Core
ImageMagick version: 7.1.2-8
GraphicsMagick version: 1.3.46
GraphicsMagick command: gm convert input_image -auto-orient -thumbnail 600x900 -quality 75 jpg:th
ImageMagick command : magick input_image -auto-orient -thumbnail 600x900 -quality 75 jpg:th

```
### Small file (700 x 875 px)
#### JXL
| Command | Mean [ms] | Min [ms] | Max [ms] | Relative | Max RSS (kbytes) |
|:---|---:|---:|---:|---:|---:|
| GraphicsMagick - 4t | 15.6 ± 0.2 | 15.4 | 15.9 | 1.00 ||
| GraphicsMagick - 7t | 15.7 ± 0.1 | 15.4 | 15.9 | 1.00 ± 0.01 ||
| GraphicsMagick - 6t | 15.7 ± 0.2 | 15.4 | 16.2 | 1.00 ± 0.02 ||
| GraphicsMagick - 5t | 15.7 ± 0.2 | 15.5 | 16.0 | 1.01 ± 0.02 ||
| GraphicsMagick - 8t | 15.8 ± 0.3 | 15.4 | 16.6 | 1.01 ± 0.02 | 24848 |
| GraphicsMagick - 3t | 16.0 ± 0.2 | 15.8 | 16.5 | 1.02 ± 0.02 ||
| GraphicsMagick - 2t | 16.7 ± 0.2 | 16.3 | 17.1 | 1.07 ± 0.02 ||
| GraphicsMagick - 1t | 19.0 ± 0.4 | 18.4 | 19.9 | 1.21 ± 0.03 | 20640 |
| ImageMagick - 4t | 39.5 ± 0.1 | 39.4 | 39.8 | 2.53 ± 0.03 ||
| ImageMagick - 7t | 39.5 ± 0.2 | 39.3 | 39.8 | 2.53 ± 0.03 ||
| ImageMagick - 8t | 39.6 ± 0.2 | 39.2 | 40.0 | 2.53 ± 0.03 | 38144 |
| ImageMagick - 5t | 39.7 ± 0.4 | 39.3 | 40.8 | 2.54 ± 0.04 ||
| ImageMagick - 6t | 39.8 ± 0.6 | 39.3 | 41.5 | 2.55 ± 0.05 ||
| ImageMagick - 3t | 40.0 ± 0.3 | 39.6 | 40.7 | 2.56 ± 0.04 ||
| ImageMagick - 2t | 40.8 ± 0.5 | 40.4 | 42.0 | 2.61 ± 0.04 ||
| ImageMagick - 1t | 42.7 ± 0.2 | 42.4 | 43.1 | 2.74 ± 0.03 | 33696 |

#### AFIV
| Command | Mean [ms] | Min [ms] | Max [ms] | Relative | Max RSS (kbytes) |
|:---|---:|---:|---:|---:|---:|
| GraphicsMagick - 1t  | 29.0 ± 0.2 | 28.7 | 29.3 | 1.00 | 25024 |
| GraphicsMagick - 8t  | 29.1 ± 0.2 | 28.8 | 29.4 | 1.00 ± 0.01 | 25088 |
| ImageMagick - 8t  | 54.0 ± 0.2 | 53.7 | 54.2 | 1.86 ± 0.01 | 37616 |
| ImageMagick - 1t  | 54.0 ± 0.2 | 53.8 | 54.4 | 1.87 ± 0.02 | 37664 |

#### HEIC
| Command | Mean [ms] | Min [ms] | Max [ms] | Relative | Max RSS (kbytes) |
|:---|---:|---:|---:|---:|---:|
| GraphicsMagick - 8t | 39.8 ± 0.1 | 39.7 | 40.1 | 1.00 | 21152 |
| GraphicsMagick - 1t | 39.9 ± 0.1 | 39.7 | 40.0 | 1.00 ± 0.00 | 20880 |
| ImageMagick - 1t | 64.8 ± 0.1 | 64.5 | 65.0 | 1.63 ± 0.01 | 34496 | 
| ImageMagick - 8t | 64.8 ± 0.2 | 64.5 | 65.1 | 1.63 ± 0.01 | 34480 |

### Medium file (4271 x 5697 px)
#### JXL
| Command | Mean [ms] | Min [ms] | Max [ms] | Relative | Max RSS (kbytes) |
|:---|---:|---:|---:|---:|---:|
| GraphicsMagick - 8t | 255.9 ± 0.7 | 255.2 | 256.8 | 1.00 | 442944 |
| GraphicsMagick - 7t | 263.2 ± 2.0 | 261.8 | 266.8 | 1.03 ± 0.01 ||
| GraphicsMagick - 6t | 269.7 ± 1.1 | 268.8 | 271.1 | 1.05 ± 0.01 ||
| GraphicsMagick - 5t | 279.2 ± 1.6 | 277.8 | 281.4 | 1.09 ± 0.01 ||
| GraphicsMagick - 4t | 291.5 ± 1.7 | 289.9 | 294.2 | 1.14 ± 0.01 ||
| GraphicsMagick - 3t | 336.1 ± 0.6 | 335.3 | 336.7 | 1.31 ± 0.00 ||
| ImageMagick - 8t | 344.1 ± 1.4 | 342.6 | 345.7 | 1.34 ± 0.01 | 554032 |
| ImageMagick - 7t | 353.0 ± 4.0 | 349.4 | 357.7 | 1.38 ± 0.02 ||
| ImageMagick - 6t | 387.9 ± 2.9 | 385.4 | 392.3 | 1.52 ± 0.01 ||
| ImageMagick - 5t | 398.3 ± 3.4 | 394.6 | 402.7 | 1.56 ± 0.01 ||
| ImageMagick - 4t | 410.7 ± 3.0 | 407.9 | 414.2 | 1.60 ± 0.01 ||
| GraphicsMagick - 2t | 419.7 ± 1.4 | 418.6 | 422.1 | 1.64 ± 0.01 ||
| ImageMagick - 3t | 455.5 ± 2.0 | 453.4 | 457.7 | 1.78 ± 0.01 ||
| ImageMagick - 2t | 539.6 ± 3.2 | 535.5 | 543.6 | 2.11 ± 0.01 ||
| GraphicsMagick - 1t | 663.2 ± 1.7 | 661.0 | 664.9 | 2.59 ± 0.01 | 437984 |
| ImageMagick - 1t | 783.6 ± 3.2 | 779.3 | 786.6 | 3.06 ± 0.01 | 550400 |

#### AVIF
| Command | Mean [ms] | Min [ms] | Max [ms] | Relative | Max RSS (kbytes) |
|:---|---:|---:|---:|---:|---:|
| ImageMagick - 8t  | 720.7 ± 3.8 | 718.3 | 727.2 | 1.00 | 833456 |
| ImageMagick - 1t  | 747.7 ± 0.7 | 746.7 | 748.7 | 1.04 ± 0.01 | 833392 |
| GraphicsMagick - 8t  | 759.7 ± 1.6 | 757.5 | 761.3 | 1.05 ± 0.01 | 524176 |
| GraphicsMagick - 1t  | 760.1 ± 1.8 | 758.5 | 762.9 | 1.05 ± 0.01 | 524176 |

#### HEIC
| Command | Mean [s] | Min [s] | Max [s] | Relative | Max RSS (kbytes) |
|:---|---:|---:|---:|---:|---:|
| ImageMagick - 8t | 1.396 ± 0.001 | 1.396 | 1.397 | 1.00 | 576944 |
| ImageMagick - 1t | 1.425 ± 0.001 | 1.424 | 1.425 | 1.02 ± 0.00 | 576800 |
| GraphicsMagick - 1t | 1.451 ± 0.000 | 1.451 | 1.452 | 1.04 ± 0.00 | 450096 |
| GraphicsMagick - 8t | 1.452 ± 0.001 | 1.450 | 1.453 | 1.04 ± 0.00 | 450080 |

### Big File (14105 x 21358 px)
#### JXL
| Command | Mean [s] | Min [s] | Max [s] | Relative | Max RSS (kbytes) |
|:---|---:|---:|---:|---:|---:|
| ImageMagick - 8t | 1.994 ± 0.009 | 1.984 | 2.007 | 1.00 | 5103232 ||
| ImageMagick - 7t | 2.054 ± 0.005 | 2.050 | 2.062 | 1.03 ± 0.01 ||
| GraphicsMagick - 8t | 2.065 ± 0.008 | 2.056 | 2.075 | 1.04 ± 0.01 | 3914752 |
| GraphicsMagick - 7t | 2.123 ± 0.002 | 2.121 | 2.126 | 1.06 ± 0.00 ||
| ImageMagick - 6t | 2.139 ± 0.005 | 2.134 | 2.147 | 1.07 ± 0.01 ||
| GraphicsMagick - 6t | 2.188 ± 0.003 | 2.185 | 2.190 | 1.10 ± 0.00 ||
| ImageMagick - 5t | 2.273 ± 0.005 | 2.266 | 2.278 | 1.14 ± 0.01 ||
| GraphicsMagick - 5t | 2.275 ± 0.002 | 2.272 | 2.277 | 1.14 ± 0.01 ||
| GraphicsMagick - 4t | 2.387 ± 0.003 | 2.382 | 2.390 | 1.20 ± 0.01 ||
| ImageMagick - 4t | 2.428 ± 0.007 | 2.417 | 2.434 | 1.22 ± 0.01 ||
| GraphicsMagick - 3t | 2.832 ± 0.003 | 2.827 | 2.835 | 1.42 ± 0.01 ||
| ImageMagick - 3t | 2.895 ± 0.003 | 2.890 | 2.899 | 1.45 ± 0.01 ||
| GraphicsMagick - 2t | 3.665 ± 0.005 | 3.658 | 3.672 | 1.84 ± 0.01 ||
| ImageMagick - 2t | 3.800 ± 0.006 | 3.790 | 3.806 | 1.91 ± 0.01 ||
| GraphicsMagick - 1t | 6.143 ± 0.011 | 6.128 | 6.155 | 3.08 ± 0.01 | 3905984 |
| ImageMagick - 1t | 6.385 ± 0.006 | 6.377 | 6.393 | 3.20 ± 0.01 | 5093664 |

#### AVIF
| Command | Mean [s] | Min [s] | Max [s] | Relative | Max RSS (kbytes) |
|:---|---:|---:|---:|---:|---:|
| ImageMagick - 8t  | 2.493 ± 0.004 | 2.487 | 2.496 | 1.00 | 8848800 |
| ImageMagick - 1t  | 2.568 ± 0.023 | 2.543 | 2.592 | 1.03 ± 0.01 | 7418528 |
| GraphicsMagick - 8t  | 3.625 ± 0.007 | 3.617 | 3.633 | 1.45 ± 0.00 | 5015536 |
| GraphicsMagick - 1t  | 3.625 ± 0.006 | 3.617 | 3.632 | 1.45 ± 0.00 | 5015536 |

#### HEIC
| Command | Mean [s] | Min [s] | Max [s] | Relative | Max RSS (kbytes) |
|:---|---:|---:|---:|---:|---:|
| ImageMagick - 8t | 5.350 ± 0.001 | 5.348 | 5.351 | 1.00 | 5624272 |
| ImageMagick - 1t | 5.390 ± 0.004 | 5.386 | 5.396 | 1.01 ± 0.00 | 5624032 |
| GraphicsMagick - 1t | 6.938 ± 0.004 | 6.933 | 6.942 | 1.30 ± 0.00 | 4149632 |
| GraphicsMagick - 8t | 6.938 ± 0.002 | 6.936 | 6.940 | 1.30 ± 0.00 | 4149680 |
