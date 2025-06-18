# gmagick.yazi

An alternative, slightly modified [image preview](https://github.com/sxyazi/yazi/blob/main/yazi-plugin/preset/plugins/magick.lua) plugin for [yazi](https://github.com/sxyazi/yazi) that uses [GraphicsMagick](http://www.graphicsmagick.org/) instead of [ImageMagick](https://imagemagick.org/). It generates AVIF and HEIF file thumbnails slightly faster, JPEG XL file thumbnails slightly slower. It uses considerably less RAM. By default, it uses the `thumbnail` method to generate thumbnails. This method is slightly slower than the `sample` method, but it offers better quality. I've included a performance comparison below to help you decide if switching is worth it. Also, this plugin does not limit threads to 1, so it will be faster if you reduced the number of `macro_workers`, disabled  the `preloaders` or/and have a CPU with a large number of threads.

## Benchmarks
```
Image Size: 7724x5148
CPU: Intel 13th gen 14c/20t

gm sample: gm convert input_image -auto-orient -strip -sample 600x900 -quality 75 jpg:th
gm thumbnail: gm convert input_image -auto-orient -strip -thumbnail 600x900 -quality 75 jpg:th
gm resize: gm convert input_image -auto-orient -strip -resize 600x900 -quality 75 jpg:th
im sample: magick input_image -auto-orient -strip -sample 600x900 -quality 75 jpg:th
im thumbnail: magick input_image -auto-orient -strip -thumbnail 600x900 -quality 75 jpg:th
im resize: magick input_image -auto-orient -strip -resize 600x900 -quality 75 jpg:th

* default in this plugin
** default in Yazi
```
### AVIF
| Test | Max RSS [MiB] | Mean [ms] | Min [ms] | Max [ms] | Relative |
|:---|---:|---:|---:|---:|---:|
| gm sample | 443 | 225.7 ± 1.2 | 224.2 | 228.1 | 1.00 |
| gm thumbnail* | 443 | 246.8 ± 6.2 | 237.9 | 257.5 | 1.09 ± 0.03 |
| gm resize | 443 | 307.9 ± 3.7 | 302.5 | 312.0 | 1.36 ± 0.02 |
| im sample** | 588 | 256.3 ± 3.9 | 251.9 | 265.4 | 1.14 ± 0.02 |
| im thumbnail | 588 | 281.0 ± 3.8 | 277.6 | 290.6 | 1.25 ± 0.02 |
| im resize | 588 | 435.9 ± 6.7 | 427.1 | 450.7 | 1.93 ± 0.03 |

### HEIF
| Test | Max RSS [MiB] | Mean [ms] | Min [ms] | Max [ms] | Relative |
|:---|---:|---:|---:|---:|---:|
| gm sample | 501 | 765.7 ± 0.9 | 764.4 | 767.5 | 1.00 |
| gm thumbnail* | 501 | 782.9 ± 2.3 | 779.9 | 788.1 | 1.02 ± 0.00 |
| gm resize | 501 | 844.6 ± 5.1 | 839.4 | 853.5 | 1.10 ± 0.01 |
| im sample** | 621 | 795.3 ± 1.5 | 792.5 | 798.4 | 1.04 ± 0.00 |
| im thumbnail | 621 | 820.1 ± 3.3 | 814.6 | 825.2 | 1.07 ± 0.00 |
| im resize | 621 | 977.3 ± 4.9 | 969.6 | 987.0 | 1.28 ± 0.01 |

### JPEG XL
| Test | Max RSS [MiB] | Mean [ms] | Min [ms] | Max [ms] | Relative |
|:---|---:|---:|---:|---:|---:|
| gm sample | 566 | 244.9 ± 11.1 | 229.9 | 267.6 | 1.02 ± 0.05 |
| gm thumbnail* | 566 | 261.5 ± 8.1 | 250.5 | 271.1 | 1.09 ± 0.04 |
| gm resize | 566 | 319.9 ± 8.3 | 306.0 | 330.4 | 1.34 ± 0.05 |
| im sample** | 715 | 239.2 ± 5.7 | 230.9 | 248.7 | 1.00 |
| im thumbnail | 715 | 266.2 ± 5.7 | 260.4 | 276.7 | 1.11 ± 0.04 |
| im resize | 715 | 423.5 ± 6.8 | 413.9 | 436.5 | 1.77 ± 0.05 |


## Requirements

- `graphicsmagick`

## Installation

```sh
ya pkg add 'ze0987/gmagick'
```

## Usage

Add the following to your `yazi.toml`:

```toml
[plugin]
prepend_previewers = [
  { mime = "image/{avif,hei?,jxl}", run = "gmagick" },
]

prepend_preloaders = [
{ mime = "image/{avif,hei?,jxl}", run = "gmagick" },
]
```
