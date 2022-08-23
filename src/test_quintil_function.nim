import quintil_function
import util
proc test_acklaman()=
    let expected=0.333
    assert isLike(expected,acklaman(0.63307))
when isMainModule:
    test_acklaman()