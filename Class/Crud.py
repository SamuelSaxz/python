from Database import Database
from datetime import datetime

class Crud(Database):
    def __init__(self):
        # Inicializa a classe Database
        super().__init__()

    # Função que gera uma string para o WHERE
    def where(self, fields: list, values: list, operators: list, complements: list = None):
        # Verifica se complements não foi inserido e se o número de campos é mais do que 1
        if complements is None and len(fields) > 1:
            raise ValueError("Não foi Especificado Complemento para Operador!")

        # Verifica se o número de campos, valores e operadores corresponde
        if len(fields) != len(values) or len(fields) != len(operators):
            raise ValueError("Número de campos, Valores e Operadores não Correspondem!")

        # Itera sobre os campos, valores, operadores e complementos (se existirem)
        for i, (field, value, operator) in enumerate(zip(fields, values, operators)):
            # Verifica se há complementos
            complement = complements[i] if complements and i < len(complements) else ''
            # Constrói a string WHERE
            clause = f"{field} {operator} '{value}' {complement} "
            # Se for o primeiro campo, inicia a cláusula WHERE
            if i == 0:
                where = clause
            else:
                # Adiciona a cláusula subsequente
                where += clause
        # Retorna a string WHERE completa
        return f" WHERE {where.strip()}"

    
    # Função que lê dados de uma tabela
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

    # Função que verifica se existe registros
    def verifyExist(self, query:str):
        # Retorna o número de registros que correspondem ao query
        return len(query)

    # Função que cria um novo registro
    def create(self, table: str, fields: list, values: list):
        # Pega a data e hora atual
        now = datetime.now().strftime("%Y-%m-%d %H:%M:%S")
        # Cria a string INSERT
        query = f"INSERT INTO {table} ({', '.join(fields)}, created_at, updated_at) VALUES ('{"', '".join(str(value) for value in values)}', '{now}', '{now}')"
        # Executa a string INSERT
        return self.execute(query)
    
    # Função que atualiza um registro
    def update(self, table: str, fields: list, values: list, where: str):
        # Cria a string UPDATE
        query = f"UPDATE {table} SET {', '.join(f"{field} = '{value}'" for field, value in zip(fields, values))} {where}"
        # Executa a string UPDATE
        return self.execute(query)

    # Função que deleta um registro
    def delete(self, table: str, autoID: bool = False, read: str = None, where: str = None):
        # Verifica se deseja que o sistema busque pelo o usuário, sem a necessidade de passar o ID
        if autoID:
            if read is not None:
                # Pega o ID do registro
                id = read[0][0] # Obtém o ID do registro
                # Cria a string DELETE
                query = f"DELETE FROM {table} WHERE id = {id}"
                # Executa a string DELETE
                return self.execute(query)
            else: 
                print("Nenhum registro encontrado para excluir!")
        # Verifica se o AutoID é False e se há um WHERE especificado (Recomendado passar o ID)
        elif where is not None:
            # Cria a string DELETE
            query = f"DELETE FROM {table} {where}"
            # Executa a string DELETE
            return self.execute(query)
        # Caso contrário, exibe uma mensagem de erro
        else:
            raise ValueError("Nenhuma condição de exclusão foi especificada!")


"""
Documentação do Crud:
Vocês podem ver que a classe Crud possui algumas funções que podem ser usadas, como:
- create: Cria um novo registro
- read: Lê dados de uma tabela
- update: Atualiza um registro
- delete: Deleta um registro
- where: Gera uma string WHERE para a consulta
- verifyExist: Verifica se existe registros

Já fiz as Funções pensando em algumas situações que poderiam ocorrer, mas há algumas situações que ainda não foram feitas como ORDER BY, LIMIT, OFFSET, JOIN entre outras.
Mas com o tempo, as situações que não foram feitas podem ser feitas.

Vou dá um exemplo de como usar a classe Crud:
crud = Crud()

# Cria um novo registro
crud.create('users', ['name', 'email', 'password', 'money'], ['Teste', 'teste@gmail.com', 'Teste1234', '1000'])

# Lê os dados de uma tabela
crud.read('users', ['*'], crud.where(['name', 'email'], ['Teste', 'teste@gmail.com'], ['=', '='], ['AND']))

# Atualiza um registro
crud.update('users', ['name', 'email', 'password', 'money'], ['Teste', 'teste@gmail.com', 'Teste1234', '1000'], crud.where(['name', 'email'], ['Teste', 'teste@gmail.com'], ['=', '='], ['AND']))
crud.update('users', ['name', 'email', 'password', 'money'], ['Teste', 'teste@gmail.com', 'Teste1234', '1000'], crud.where(['id'], ['1], ['='], ['AND']))

# Deleta um registro
crud.delete('users', True, crud.read('users', ['*'], crud.where(['email'], ['teste@gmail.com'], ['='])))
crud.delete('users', False, None, crud.where(['id'], ['1'], ['=']))

Não Fiz nenhum exemplo com VerifyExist, pois não sei se é necessário, mas caso seja, basta usar o seguinte:

# Cria um novo registro Com VerifyExist
if crud.verifyExist(crud.read('users', ['*'], crud.where(['email'], ['teste@gmail.com'], ['=']))) == 0:
    crud.create('users', ['name', 'email', 'password', 'money'], ['Teste', 'teste@gmail.com', 'Teste1234', '1000'])
else:
    print("Usuário já existe")

# Lê os dados de uma tabela Com VerifyExist
if crud.verifyExist(crud.read('users', ['*'], crud.where(['email'], ['teste@gmail.com'], ['=']))) == 0:
    print("Usuário não Existe")
else:
    crud.read('users', ['*'], crud.where(['email'], ['teste@gmail.com'], ['=']))
    print("Usuário Existe")

# Atualiza um registro Com VerifyExist
if crud.verifyExist(crud.read('users', ['*'], crud.where(['email'], ['teste@gmail.com'], ['=']))) == 0:
    print("Usuário não Existe")
else:
    crud.update('users', ['name', 'email', 'password', 'money'], ['Teste', 'teste@gmail.com', 'Teste1234', '1000'], crud.where(['name', 'email'], ['Teste', 'teste@gmail.com'], ['=', '='], ['AND']))
    print("Usuário Existe")

# Deleta um registro Com VerifyExist
if crud.verifyExist(crud.read('users', ['*'], crud.where(['email'], ['teste@gmail.com'], ['=']))) == 0:
    print("Usuário não Existe")
else:
    crud.delete('users', True, crud.read('users', ['*'], crud.where(['email'], ['teste@gmail.com'], ['='])))
    print("Usuário Existe")
"""


