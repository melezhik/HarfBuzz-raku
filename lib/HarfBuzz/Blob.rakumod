unit class HarfBuzz::Blob;

use HarfBuzz::Raw;
use NativeCall;

has hb_blob $.raw is built;

multi submethod TWEAK(Str:D :$file!) {
    $!raw .= new: :$file;
    $!raw.reference;
}

multi submethod TWEAK(hb_blob:D :$!raw!) {
}

multi submethod TWEAK(Blob:D :$buf!) {
    $!raw .= new: :$buf;
    $!raw.reference;
}

method Blob {
    my uint32 $len;
    my Pointer $data = $!raw.get-data($len);
    my buf8 $buf .= allocate($len);
    HarfBuzz::Raw::memcpy(nativecast(Pointer, $buf), $data, $len);
    $buf;
}

submethod DESTROY {
    $!raw.destroy;
}
