import json

dic = {
    "dataRegistro": "9/8/2010 23:59:59",
    "a": {
        "b": 47710,
        "c": "Centro",
        "d": {
            "e": "6VEIP3KPE7GLJDD1WGT1F0FHLK43GB"
        }
    },
    "f": "104",
    "g": "-45.0",
    "h": "-45.0",
    "i": "86.0",
    "j": {
        "k": "QX5BZ56",
        "l": "JXBD6MTL8J",
        "m": "69NHD04XYQ",
        "n": "VR24DCGF49",
        "o": 15,
        "p": "Descri\u00e7\u00e3o unica!",
        "q": "15/4/2020 23:59:59"
    }
}

def x (dc : dict, r : dict = {}):

    for y in dc.items():
        
        if type(y[1]) is dict:
            x(y[1], r)
        else:
            r[y[0]] = y[1]
    
    return r

print(json.dumps(x(dic), indent=4))