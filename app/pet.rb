class Pet
    @@uri = "#{ENV['BASE_URI']}/pet" #Utilizando o DOTENV (https://petstore.swagger.io/v2) para popular a URI

    def create(body)
        uri = "#{@@uri}"
        response = without_authentication('post', uri, body)  # As APIs em questão não necessitam de autenticação
    end

    def read_all(situacao) #TODO: Esta API retornará todos os registros que possuem o status(@situacao) que informarmos
        uri = "#{@@uri}/findByStatus/?status=#{situacao}"
        response = without_authentication('get', uri)
    end

    def read(pet_id) #TODO: Esta API retornará o registro que possuir o ID(@pet_id) que informarmos
        uri = "#{@@uri}/#{pet_id}/"
        response = without_authentication('get', uri)
    end

    def update(body) #TODO: Esta API atualizará o registro que informarmos, o ID do registro está no @body junto aos novos valores
        uri = "#{@@uri}"
        response = without_authentication('put', uri, body)
    end

    def update_data(petId) #! Não está funcional no momento
        uri = "#{@@uri}/#{petId}"
        response = without_authentication('post', uri, 'q' => ['TesteFormData', 'sold'])
    end

    def delete(petId)
        uri = "#{@@uri}/#{petId}"
        response = without_authentication('delete', uri)
    end
end
