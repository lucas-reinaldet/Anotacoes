from cassandra.cluster import Cluster, uuid, Session
from datetime import datetime

# pip install cassandra-driver

CS_HOST = ['172.16.230.10']
CS_PORT = 9042
CS_KEYSPACE = 'prototipo'

def cs_connect():
    cluster = Cluster(CS_HOST, port=CS_PORT)
    return cluster.connect(CS_KEYSPACE)


def cs_insert_trajeto(session : Session, trajeto):

    try:
        # session = connect()
        cqlsh = """INSERT INTO trajeto 
                            (tj_id, tj_trajeto, tj_data_cadastro)
                        VALUES
                            (%s, %s, %s)    
                """
        result = session.execute_async(cqlsh, (uuid.uuid1(), trajeto, datetime.now()))
        return result.result()
    except Exception as error:
        print(f'Daos - Insert Trajeto - error: {error}')
        return False

def cs_insert_passagem_veiculo(session : Session, veiculo):

    try:
        # session = connect()
        cqlsh = """INSERT INTO veiculo_passagem 
                            (vp_id, vp_placa, vp_ponto, vp_data_cadastro)
                        VALUES
                            (%s, %s, %s, %s)    
                """
        result = session.execute_async(cqlsh, (uuid.uuid1(), veiculo[0], veiculo[1], datetime.now()))
        return result.result()
    except Exception as error:
        print(f'Daos - INSERT PAssagem - error: {error}')
        return False 
