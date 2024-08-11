from Crud import Crud

class User(Crud):
    def __init__(self):
        # Inicializa a classe Crud e define os campos padrões para a class User
        self.fields = ['id', 'name', 'email', 'password', 'money']
        super().__init__()

    def create(self, fields: list):
        # Atribui o valor
        self.fields = fields
        if 'email' in self.fields and self.fields['email'] != '':
            # Verifica se o usuário já existe
            if self.verifyUser(['email'], [self.fields['email']], ['=']):
                # Se já existe, exibe uma mensagem de erro
                raise ValueError("Usuário já existe!")
            else:
                # Se não, cria o usuário
                super().create('users', [key for key in self.fields], [self.fields[key] for key in self.fields])
                print("Usuário Criado com Sucesso!")
        else:
            print("Preencha todos os campos!")
    
    def read(self, id: int):
        # Lê os dados do usuário
        print(super().read('users', self.fields, self.where(['id'], [id], ['='])))

    def update(self, fields: dict, id: int):
        #Atribui os valores
        self.fields = fields
        # Verifica se o e-mail já existe dentro dos Campos Passados
        if 'email' in self.fields and self.fields['email'] != '':
            if self.verifyUser(['email'], [fields['email']], ['=']) == 0:
                super().update('users', [key for key in self.fields], [self.fields[key] for key in self.fields], self.where(['id'], [id], ['=']))
                print("Usuário Atualizado com Sucesso!")
            else:
                raise ValueError("E-mail já Cadastrado!")
        else:
            super().update('users', [key for key in self.fields], [self.fields[key] for key in self.fields], self.where(['id'], [id], ['=']))
            print("Usuário Atualizado com Sucesso!")
    
    def delete(self, id: int):
        # Verifica se o usuário existe
        if self.verifyUser(['id'], [id], ['=']) > 0:
            # Deleta o usuário
            super().delete('users', False, None, self.where(['id'], [id], ['=']))
            print("Usuário Deletado com Sucesso!")
        else:
            raise ValueError("Usuário não existe!")
    
    def verifyUser(self, fields: list, values:list, operators:list, complements:list = None):
        # Verifica se o usuário já existe
        if super().verifyExist(super().read('users', self.fields, self.where(fields, values, operators, complements))) == 0:
            return False
        else:
            return True

""" Testes
user = User()
user.create({'name': 'Teste', 'email': 'samuel03@gmail.com', 'password': 'Teste1234', 'money': 500})
user.read(44)
user.update({'name': 'Teste', 'email': 'samuel04@gmail.com', 'password': 'Teste1234', 'money': 500}, 44)
user.update({'name': 'Teste2'}, 44)
user.delete(44)
"""
