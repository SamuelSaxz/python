from Crud import Crud

class User(Crud):
    def __init__(self):
        # Inicializa a classe Crud e define os campos padrões para a class User
        self.fields = ['name', 'email', 'password', 'money']
        super().__init__()

    def create(self, value: list):
        # Atribui o valor
        self.value = value
        # Verifica se o usuário já existe
        if self.verifyUser(value[1]):
            # Se já existe, exibe uma mensagem de erro
            raise ValueError("Usuário já existe!")
        else:
            # Se não, cria o usuário
            super().create('users', self.fields, self.value)
            print("Usuário Criado com Sucesso!")
    
    def verifyUser(self, email: str):
        # Verifica se o usuário já existe
        if self.verifyExist(self.read('users', self.fields, self.where(['email'], [email], ['=']))) == 0:
            print("Usuário não existe")
            return False
        else:
            return True

# Testes
user = User()
user.create(['Samuel', 'samuel8@gmail.com', 'Samuel1234', 1000])