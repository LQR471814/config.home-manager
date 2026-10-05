#!/usr/bin/env nu

# Shrink a PDF by rasterizing pages to PNG via ghostscript, then reassembling
# with imagemagick. Built for vector-heavy PDFs (e.g. BOOX / e-reader ink note
# exports) where image downsampling has no effect because the bulk is vector
# path data in content streams.
#
# PNG is lossless -> crisp strokes, no JPEG ringing. For monochrome / grayscale
# notes PNG also compresses smaller than JPEG. Auto-retries at lower DPI until
# the output fits the target size.
def main [
    input: path                       # source PDF
    --output (-o): path               # output path (default: <input>_small.pdf)
    --target (-t): filesize = 10MB    # max output size
    --dpi (-r): int = 300             # starting raster resolution
    --color                           # full color (png16m); default grayscale
    --min-dpi: int = 100              # lowest DPI to try before giving up
] {
    if not ($input | path exists) {
        error make { msg: $"input not found: ($input)" }
    }

    let device = if $color { "png16m" } else { "pnggray" }
    let out = ($output | default (($input | path parse | get stem) + "_small.pdf"))
    let tmp = (mktemp -d)

    mut dpi = $dpi
    mut done = false

    try {
        while not $done {
            print $"rasterizing ($device) at ($dpi) dpi..."
            let stale = (glob $"($tmp)/p*.png")
            if ($stale | is-not-empty) { rm -f ...$stale }

            (gs -sDEVICE=($device) $"-r($dpi)"
                -dNOPAUSE -dQUIET -dBATCH
                $"-sOutputFile=($tmp)/p%03d.png" $input)

            let pages = (glob $"($tmp)/p*.png" | sort)
            if ($pages | is-empty) {
                error make { msg: "ghostscript produced no pages" }
            }

            magick ...$pages $out
            let size = (ls $out | get 0.size)
            print $"  -> ($size)"

            if $size <= $target {
                $done = true
            } else if $dpi > $min_dpi {
                $dpi = ([($dpi - 50) $min_dpi] | math max)
                print "  over target, retrying lower dpi..."
            } else {
                print $"  warning: still over target at min dpi ($min_dpi); keeping best effort"
                $done = true
            }
        }
    } catch { |e|
        rm -rf $tmp
        error make { msg: $"failed: ($e.msg)" }
    }

    rm -rf $tmp
    let final = (ls $out | get 0.size)
    print $"done: ($out) \(($final))"
}
