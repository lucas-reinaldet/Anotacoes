import json

dic = {
    "dataRegistro": "9/8/2010 23:59:59",
    "camera": {
        "codigo": 47710,
        "sentido": "Centro",
        "empresa": {
            "nomeEmpresa": "6VEIP3KPE7GLJDD1WGT1F0FHLK43GB"
        }
    },
    "velocidade": "104",
    "latitude": "-45.0",
    "longitude": "-45.0",
    "grauFidelidade": "86.0",
    "ocorrencia": {
        "placa": "QX5BZ56",
        "marca": "JXBD6MTL8J",
        "modelo": "69NHD04XYQ",
        "cor": "VR24DCGF49",
        "codigoOcorrenciaMonitoramento": 15,
        "descricaoSituacaoOcorrencia": "Descri\u00e7\u00e3o unica!",
        "dataHoraRegistroOcorrencia": "15/4/2020 23:59:59"
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