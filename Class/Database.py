from mysql.connector import Error, connect

class Database:
    def __init__(self):
        self.host = 'localhost'
        self.user = 'root'
        self.password = 'root'
        self.database = 'dbshop'
        self.port = 3306
        self.connection = None
        self.connect()

    def connect(self):
        try:
            if self.connection is None or not self.connection.is_connected():
                self.connection = connect(
                    host=self.host,
                    user=self.user,
                    password=self.password,
                    database=self.database,
                    port=self.port
                )
                if self.connection.is_connected():
                    # print("Conectado com sucesso!")
                    return self.connection
                else:
                    raise ValueError("Conexão falhou!")
            else:
                raise ValueError("Conexão já estabelecida")
                return self.connection
    
        except Error as err:
            print(f"Erro: {err}")
            self.connection = None
            return None

    def execute(self, query: str):
        # Verifica se a conexão foi estabelecida
        if self.connection is not None:
            try:
                # Executando Query
                cursor = self.connection.cursor()
                cursor.execute(query)
                
                # Verifica o tipo de query e obtém os resultados, se necessário
                if query.strip().lower().startswith("select"):
                    print("Query retornando resultados...")
                    results = cursor.fetchall()  # Obtém todos os resultados
                    return results
                else:
                    # Para queries que não retornam resultados, como INSERT, UPDATE, DELETE
                    self.connection.commit()
                    print("Query executada com sucesso!")
                    return None
                
            except Error as err:
                # Se não, exibe uma mensagem de erro e executa um rollback
                self.connection.rollback()
                print(f"Erro ao executar a query: {err}")
                return None
        else:
            # Se não, exibe uma mensagem de erro
            print("Conexão não estabelecida. Query não executada.")
            return None

    def close(self):
        # Fecha a conexão com o banco de dados e exibe uma mensagem de conexao encerrada
        if self.connection and self.connection.is_connected():
            self.connection.close()
            print("Conexão com o banco de dados encerrada")