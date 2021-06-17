class Pet
    
    @@uri = "#{ENV['BASE_URI']}/pet" #Utilizando o DOTENV (https://petstore.swagger.io/v2) para popular a URI

    def create(body)
        uri = "#{@@uri}"
        response = without_authentication('post', uri, body) 
    end

    def read_all(situacao)
        uri = "#{@@uri}/findByStatus/?status=#{situacao}"
        response = without_authentication('get', uri)
    end

    def read(pet_id)
        uri = "#{@@uri}/#{pet_id}/"
        response = without_authentication('get', uri)
    end

    def update(body)
        uri = "#{@@uri}"
        response = without_authentication('put', uri, body)
    end

    def update_data(petId)
        uri = "#{@@uri}/#{petId}"
        response = without_authentication('post', uri, 'q' => ['TesteFormData', 'sold'])
    end

    def delete(petId)
        # uri = "#{@@uri}/#{petId}"
        # header_value = { "Authorization" => "special-key", "Content-Type" => 'application/json', "Accept" => "application/json" }
        # response = generic_request('delete', uri, header_value)

        uri = "#{@@uri}/#{petId}"
        response = without_authentication('delete', uri)
    end
end
