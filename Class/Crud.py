from Database import Database
from datetime import datetime

class Crud(Database):
    def __init__(self):
        # Inicializa a classe Database
        super().__init__()

    def where(self, fields_id:list, values_id:list, operators: list, complements: list = None):
        # Verifica se complements não foi inserido e se o número de campos é mais do que 1
        if complements is None and len(fields_id) > 1:
            # Retornando uma mensagem de Erro caso não seja especificado complemento para operador
            raise ValueError("Não foi Especificado Complemento para Operador!")
        
        # Verifica se o número de campos, valores e operadores corresponde
        if len(fields_id) != len(values_id) or len(fields_id) != len(operators):
            # Retornando uma mensagem de Errro caso há valores faltando ou não correspondem
            raise ValueError("Número de campos, Valores e Operadores não Correspondem!")

        # Itera sobre os campos
        for i in range(len(fields_id)):
            # Verifica se há complementos
            if complements != None:
                # Se existir, obtém o complemento
                complement = complements[i] if i < len(complements) else ''
            else:
                # Caso contrário, não há complemento
                complement = ''

            # Verifica se o campo é o primeiro, isso é necessário para adicionar os valores dentro de WHERE, pois dá erro caso não seja primeiro atribuido e depois adicionado.
            if i == 0:
                # Se for o primeiro somente atribuir valores dentro de WHERE
                where = f"{fields_id[i]} {operators[i]} '{values_id[i]}' {complement} "
            else:
                # Se não for o primeiro, adiciona os valores dentro de WHERE
                where += f"{fields_id[i]} {operators[i]} '{values_id[i]}' {complement} "

        # Retorna a string WHERE
        return f" WHERE {where}"
    
    def read(self, table:str, fields:list, where: str):
        # Verifica se existem campos para ler
        if len(fields) > 0:
            # Se existirem, adiciona os campos dentro de SELECT
            fields = ', '.join(fields)
            # Cria a string SELECT
            query = f"SELECT {fields} FROM {table}"
            # Verifica se há WHERE
            if where != '':
                # Se existir, adiciona o WHERE
                query += where
            # Executa a string SELECT
            return self.execute(query)
        else:
            # Caso contrário, retorna None
            return None

    def verifyExist(self, query:str):
        # Retorna o número de registros que correspondem ao query
        return len(query)

    def create(self, table: str, fields: list, values: list):
        # Pega a data e hora atual
        now = datetime.now().strftime("%Y-%m-%d %H:%M:%S")
        # Cria a string INSERT
        query = f"INSERT INTO {table} ({', '.join(fields)}, created_at, updated_at) VALUES ('{"', '".join(str(value) for value in values)}', '{now}', '{now}')"
        # Executa a string INSERT
        return self.execute(query)


"""
crud = Crud()

crud.read('users', ['*'], crud.where(['name', 'email'], ['Samuel', 'samuel@gmail.com'], ['=', '='], ['AND']))

if crud.verifyExist(crud.read('users', ['*'], crud.where(['email'], ['samuel13@gmail.com'], ['=']))) == 0:
    crud.create('users', ['name', 'email', 'password', 'money'], ['Samuel', 'samuel13@gmail.com', 'Samuel1234', '1000'])
else:
    print("Usuário já existe")
"""



