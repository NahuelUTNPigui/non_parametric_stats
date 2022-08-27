import util
let numeros:seq[float] = @[
    90.0,
    64,
    74,
    77,
    100,
    65,
    90,
    72,
    95,
    88,
    57,
    64,
    80,
    100,
    90,
    89,
    100,
    35,
    95,
    84,
    76
]

proc test_media()=
    let expected=(1+2+3+4+5+6+7+8+9)/9.0
    assert expected == media(@[1.0,2,3,4,5,6,7,8,9]) 
proc test_var()=
    let expected=2.5
    assert expected==varianza(@[1.0,2,3,4,5])
proc test_kurtosis(expected:float, numeros:seq[float])=
    let k= kurtosis(numeros)
    
    assert is_like(k,expected)
proc test_std_kurtosis(expected:float, numeros:seq[float])=
    
    assert is_like(expected,std_k(len(numeros).float))
proc test_skew(expected:float, numeros:seq[float])=
    
    assert is_like(expected,skew(numeros))
proc test_std_skew(expected:float, numeros:seq[float])=
    assert is_like(expected,std_sk(len(numeros).float))

proc test_is_normal(expected:bool,numeros:seq[float])=
    assert isNormal(numeros,0.05)==expected
proc test_capitulo2(numeros:seq[float])=
    echo "Media"
    test_media()
    echo "var"
    test_var()
    echo "kurtosis"
    test_kurtosis(1.153,numeros)
    echo "std error kurtosis"
    test_std_kurtosis(0.972,numeros)
    echo "skew"
    test_skew(-1.018,numeros)
    echo "std skew"
    test_std_skew(0.501,numeros)
    echo "normal"
    test_is_normal(false,numeros)
proc wilcoxon_test()=
    let pairs = @[
        @[31.0,31],
        @[14.0,14],
        @[53.0,50],
        @[18.0,30],
        @[21.0,28],
        @[44.0,48.0],
        @[12.0,35],
        @[36.0,32],
        @[22.0,23],
        @[29.0,34],
        @[17.0,27],
        @[40.0,42]
    ]
    assert false==wilcoxon_signed_rank(pairs,0.05)
proc sign_test_test()=
    let pairs = @[
        @[31.0,31],
        @[14.0,14],
        @[53.0,50],
        @[18.0,30],
        @[21.0,28],
        @[44.0,48.0],
        @[12.0,35],
        @[36.0,32],
        @[22.0,23],
        @[29.0,34],
        @[17.0,27],
        @[40.0,42]
    ]
    assert false==sign_test(pairs,0.05)    
proc test_capitulo3()=
    wilcoxon_test()
    sign_test_test()
when isMainModule:
    test_capitulo3()

