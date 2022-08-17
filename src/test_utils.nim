import util
proc test_media()=
    let expected=(1+2+3+4+5+6+7+8+9)/9.0
    assert expected == media(@[1.0,2,3,4,5,6,7,8,9]) 
proc test_var()=
    let expected=2.5
    assert expected==varianza(@[1.0,2,3,4,5])
when isMainModule:
    test_media()
    test_var()
