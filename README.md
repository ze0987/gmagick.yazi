# gmagick.yazi

Alternative [image preview](https://github.com/sxyazi/yazi/blob/main/yazi-plugin/preset/plugins/magick.lua) plugin for [yazi](https://github.com/sxyazi/yazi) that uses [GraphicsMagick](http://www.graphicsmagick.org/) instead of [ImageMagick](https://imagemagick.org/). Depending on the format, encoding method, image size or CPU, GraphicsMagick can be faster or slower than ImageMagick; usually requires less RAM. This plugin does not limit the number of threads by default. Uncomment `-- "-limit" , "threads", 1,` and adjust the thread limit as needed.

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
